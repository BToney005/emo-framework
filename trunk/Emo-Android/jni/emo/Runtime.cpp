#include <math.h>

#include <android/log.h>
#include <android/native_activity.h>
#include <android_native_app_glue.h>
#include <android/window.h>
#include <android/configuration.h>

#include <EGL/egl.h>
#include <GLES/gl.h>

#include "Constants.h"
#include "Runtime.h"
#include "Engine.h"

extern emo::Engine* engine;

void initRuntimeFunctions() {
    engine->registerClass(engine->sqvm, EMO_RUNTIME_CLASS);
    engine->registerClass(engine->sqvm, EMO_EVENT_CLASS);
    engine->registerClass(engine->sqvm, EMO_STOPWATCH_CLASS);

    engine->registerClassFunc(engine->sqvm, EMO_RUNTIME_CLASS, "import",          emoImportScript);
    engine->registerClassFunc(engine->sqvm, EMO_RUNTIME_CLASS, "setOptions",      emoSetOptions);
    engine->registerClassFunc(engine->sqvm, EMO_RUNTIME_CLASS, "echo",            emoRuntimeEcho);
    engine->registerClassFunc(engine->sqvm, EMO_RUNTIME_CLASS, "log",             emoRuntimeLog);
    engine->registerClassFunc(engine->sqvm, EMO_RUNTIME_CLASS, "info",            emoRuntimeLogInfo);
    engine->registerClassFunc(engine->sqvm, EMO_RUNTIME_CLASS, "error",           emoRuntimeLogError);
    engine->registerClassFunc(engine->sqvm, EMO_RUNTIME_CLASS, "warn",            emoRuntimeLogWarn);
    engine->registerClassFunc(engine->sqvm, EMO_RUNTIME_CLASS, "finish",          emoRuntimeFinish);
    engine->registerClassFunc(engine->sqvm, EMO_RUNTIME_CLASS, "os",              emoRuntimeGetOSName);
    engine->registerClassFunc(engine->sqvm, EMO_STOPWATCH_CLASS, "start",         emoRuntimeStopwatchStart);
    engine->registerClassFunc(engine->sqvm, EMO_STOPWATCH_CLASS, "stop",          emoRuntimeStopwatchStop);
    engine->registerClassFunc(engine->sqvm, EMO_STOPWATCH_CLASS, "elapsed",       emoRuntimeStopwatchElapsed);

    engine->registerClassFunc(engine->sqvm, EMO_EVENT_CLASS,   "registerSensors", emoRegisterSensors);
    engine->registerClassFunc(engine->sqvm, EMO_EVENT_CLASS,   "enableSensor",    emoEnableSensor);
    engine->registerClassFunc(engine->sqvm, EMO_EVENT_CLASS,   "disableSensor",   emoDisableSensor);
    engine->registerClassFunc(engine->sqvm, EMO_EVENT_CLASS,   "enableOnDrawCallback",  emoEnableOnDrawCallback);
    engine->registerClassFunc(engine->sqvm, EMO_EVENT_CLASS,   "disableOnDrawCallback", emoDisableOnDrawCallback);
}

int32_t app_handle_input(struct android_app* app, AInputEvent* event) {
    return engine->event_handle_input(app, event);
}

void app_handle_cmd(struct android_app* app, int32_t cmd) {
    engine->event_handle_cmd(app, cmd);
}

/* Log INFO */
void LOGI(const char* msg) {
	((void)__android_log_print(ANDROID_LOG_INFO,  EMO_LOG_TAG, msg));
}

/* Log WARN */
void LOGW(const char* msg) {
	((void)__android_log_print(ANDROID_LOG_WARN,  EMO_LOG_TAG, msg));
}

/* Log ERROR */
void LOGE(const char* msg) {
	((void)__android_log_print(ANDROID_LOG_ERROR, EMO_LOG_TAG, msg));
}

/*
 * clear all OpenGL errors
 */
void clearGLErrors(const char* msg) {
    for (GLint error = glGetError(); error; error = glGetError()) {
        if (error != GL_NO_ERROR) {
            LOGI(msg);
            char str[128];
            sprintf(str, "err code=0x%x", error);
            LOGI(str);
        }
    }
}

bool printGLErrors(const char* msg) {
    bool result = true;
    for (GLint error = glGetError(); error; error = glGetError()) {
        if (error != GL_NO_ERROR) {
            LOGE(msg);
            char str[128];
            sprintf(str, "err code=0x%x", error);
            LOGE(str);
            result = false;
        }
    }
    return result;
}

/*
 * callback function to read squirrel script
 */
static SQInteger sq_lexer(SQUserPointer asset) {
	SQChar c;
		if(AAsset_read((AAsset*)asset, &c, 1) > 0) {
			return c;
		}
	return 0;
}

/*
 * Load squirrel script from asset
 */
bool loadScriptFromAsset(const char* fname) {
    /*
     * read squirrel script from asset
     */
    AAssetManager* mgr = engine->app->activity->assetManager;
    if (mgr == NULL) {
    	engine->setLastError(ERR_SCRIPT_LOAD);
    	LOGE("loadScriptFromAsset: failed to load AAssetManager");
    	return false;
    }

    AAsset* asset = AAssetManager_open(mgr, fname, AASSET_MODE_UNKNOWN);
    if (asset == NULL) {
    	engine->setLastError(ERR_SCRIPT_OPEN);
    	LOGW("loadScriptFromAsset: failed to open main script file");
        LOGW(fname);
    	return false;
    }

    if(SQ_SUCCEEDED(sq_compile(engine->sqvm, sq_lexer, asset, fname, SQTrue))) {
        sq_pushroottable(engine->sqvm);
        if (SQ_FAILED(sq_call(engine->sqvm, 1, SQFalse, SQTrue))) {
        	engine->setLastError(ERR_SCRIPT_CALL_ROOT);
            LOGW("loadScriptFromAsset: failed to sq_call");
            LOGW(fname);
            return false;
        }
    } else {
    	engine->setLastError(ERR_SCRIPT_COMPILE);
        LOGW("loadScriptFromAsset: failed to compile squirrel script");
        LOGW(fname);
        return false;
    }

    AAsset_close(asset);

    return true;
}

/*
 * Runtime logging
 */
SQInteger emoRuntimeLog(HSQUIRRELVM v) {
    SQInteger nargs = sq_gettop(v);
    SQInteger level;
    const SQChar *message;

    if (nargs < 3) return 0;

    if (sq_gettype(v, 2) == OT_INTEGER && sq_gettype(v, 3) == OT_STRING) {
        sq_getinteger(v, 2, &level);
        sq_tostring(v, 3);
        sq_getstring(v, -1, &message);
        sq_poptop(v);

        switch(level) {
        case LOG_INFO:
            LOGI((char*)message);
            break;
        case LOG_ERROR:
            LOGE((char*)message);
            break;
        case LOG_WARN:
            LOGW((char*)message);
            break;
        }
    }
	return 0;
}

/*
 * Runtime log info
 */
SQInteger emoRuntimeLogInfo(HSQUIRRELVM v) {
    const SQChar *str;
    SQInteger nargs = sq_gettop(v);
    for(SQInteger n = 1; n <= nargs; n++) {
        if (sq_gettype(v, n) == OT_STRING) {
            sq_tostring(v, n);
            sq_getstring(v, -1, &str);

            LOGI((char*)str);
        }
    }
    return 0;
}

/*
 * Runtime log error
 */
SQInteger emoRuntimeLogError(HSQUIRRELVM v) {
    const SQChar *str;
    SQInteger nargs = sq_gettop(v);
    for(SQInteger n = 1; n <= nargs; n++) {
        if (sq_gettype(v, n) == OT_STRING) {
            sq_tostring(v, n);
            sq_getstring(v, -1, &str);

            LOGE((char*)str);
        }
    }
    return 0;
}

/*
 * Runtime log warn
 */
SQInteger emoRuntimeLogWarn(HSQUIRRELVM v) {
    const SQChar *str;
    SQInteger nargs = sq_gettop(v);
    for(SQInteger n = 1; n <= nargs; n++) {
        if (sq_gettype(v, n) == OT_STRING) {
            sq_tostring(v, n);
            sq_getstring(v, -1, &str);

            LOGW((char*)str);
        }
    }
    return 0;
}


/*
 * Runtime echo
 */
SQInteger emoRuntimeEcho(HSQUIRRELVM v) {
	const SQChar *str;
    SQInteger nargs = sq_gettop(v);
    for(SQInteger n = 1; n <= nargs; n++) {
    	if (sq_gettype(v, n) == OT_STRING) {
            sq_tostring(v, n);
            sq_getstring(v, -1, &str);
            sq_poptop(v);
    	}
    }
	
	if (str != NULL) {
		sq_pushstring(v, str, -1);
	}
	
	return 1;
}

/*
 * Shutdown the runtime
 */
SQInteger emoRuntimeFinish(HSQUIRRELVM v) {
    engine->finishing = true;
    return 0;
}

/*
 * Returns OS name
 */
SQInteger emoRuntimeGetOSName(HSQUIRRELVM v) {
    sq_pushstring(v, (SQChar*)OS_ANDROID, -1);
    return 1;
}


/*
 * start stopwatch
 */
SQInteger emoRuntimeStopwatchStart(HSQUIRRELVM v) {
    engine->stopwatchStart();
    return 0;
}

/*
 * get elapsed time from stop watch
 */
SQInteger emoRuntimeStopwatchElapsed(HSQUIRRELVM v) {
    sq_pushinteger(v, engine->stopwatchElapsed());
    return 1;
}

/*
 * stop stopwatch
 */
SQInteger emoRuntimeStopwatchStop(HSQUIRRELVM v) {
    engine->stopwatchStop();
    return 0;
}

/*
 * Import function called from squirrel script
 */
SQInteger emoImportScript(HSQUIRRELVM v) {
    SQInteger nargs = sq_gettop(v);
    for(SQInteger n = 1; n <= nargs; n++) {
    	if (sq_gettype(v, n) == OT_STRING) {
    		const SQChar *fname;
            sq_tostring(v, n);
            sq_getstring(v, -1, &fname);
            sq_poptop(v);

    		loadScriptFromAsset((char*)fname);
    	}
    }
	return 0;
}

/*
 * set options function called from script
 */
SQInteger emoSetOptions(HSQUIRRELVM v) {
    SQInteger nargs = sq_gettop(v);
    for(SQInteger n = 1; n <= nargs; n++) {
        if (sq_gettype(v, n) == OT_INTEGER) {
            SQInteger value;
            sq_getinteger(v, n, &value);

            engine->updateOptions(value);
        }
    }
    return 0;
}

/*
 * register sensors function called from script
 */
SQInteger emoRegisterSensors(HSQUIRRELVM v) {
    SQInteger nargs = sq_gettop(v);
    for(SQInteger n = 1; n <= nargs; n++) {
        if (sq_gettype(v, n) == OT_INTEGER) {
            SQInteger value;
            sq_getinteger(v, n, &value);

            engine->createSensors(value);
        }
    }
    return 0;
}

/*
 * enable sensor
 */
SQInteger emoEnableSensor(HSQUIRRELVM v) {
    SQInteger nargs = sq_gettop(v);
    if (nargs < 3) {
        LOGE("Invalid call: emoEnableSensors(sensorType, interval)");
        return 0;
    }

    SQInteger sensorType;
    SQInteger interval;

    sq_getinteger(v, 2, &sensorType);
    sq_getinteger(v, 3, &interval);

    engine->enableSensor(sensorType, interval);

    return 0;
}

/*
 * disable sensor
 */
SQInteger emoDisableSensor(HSQUIRRELVM v) {
    SQInteger nargs = sq_gettop(v);
    if (nargs < 2) {
        LOGE("Invalid call: emoDisableSensors(sensorType)");
        return 0;
    }

    SQInteger sensorType;
    sq_getinteger(v, 2, &sensorType);

    engine->disableSensor(sensorType);

    return 0;
}

SQInteger emoEnableOnDrawCallback(HSQUIRRELVM v) {
    engine->enableOnDrawListener(true);

    SQInteger nargs = sq_gettop(v);

    if (nargs <= 2 && sq_gettype(v, 2) == OT_INTEGER) {
        SQInteger interval;
        sq_getinteger(v, 2, &interval);

        engine->setOnDrawListenerInterval(interval);
    }

    return 0;
}

SQInteger emoDisableOnDrawCallback(HSQUIRRELVM v) {
    engine->enableOnDrawListener(false);
    return 0;
}
