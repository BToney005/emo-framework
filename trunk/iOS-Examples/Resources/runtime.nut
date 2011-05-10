/******************************************************
 *                                                    *
 *   RUNTIME CLASSES AND CONSTANTS FOR EMO-FRAMEWORK  *
 *                                                    *
 *            !!DO NOT EDIT THIS FILE!!               *
 ******************************************************/

const EMO_VERSION = 0.1;

const OS_ANDROID = "Android";
const OS_IOS     = "iOS";

const ANDROID_GRAPHICS_DIR = "graphics/";
const ANDROID_SOUNDS_DIR   = "sounds/";

const EMO_NO          = 0;
const EMO_YES         = 1;

const EMO_NO_ERROR    = 0x0000;
const EMO_ERROR       = 0x0001;
const LOG_INFO        = 0x0002;
const LOG_ERROR       = 0x0003;
const LOG_WARN        = 0x0004;

const ERR_SCRIPT_LOAD           = 0x0100;
const ERR_SCRIPT_OPEN           = 0x0101;
const ERR_SCRIPT_COMPILE        = 0x0102;
const ERR_SCRIPT_CALL_ROOT      = 0x0103;
const ERR_ASSET_LOAD            = 0x0104;
const ERR_ASSET_OPEN            = 0x0105;
const ERR_ASSET_UNLOAD          = 0x0106;
const ERR_AUDIO_ENGINE_CREATED  = 0x0107;
const ERR_AUDIO_CHANNEL_CREATED = 0x0108;
const ERR_AUDIO_ENGINE_INIT     = 0x0100;
const ERR_AUDIO_ASSET_INIT      = 0x0110;
const ERR_AUDIO_ENGINE_CLOSED   = 0x0111;
const ERR_AUDIO_CHANNEL_CLOSED  = 0x0112;
const ERR_AUDIO_ENGINE_STATUS   = 0x0113;
const ERR_INVALID_PARAM_COUNT   = 0x0114;
const ERR_INVALID_PARAM_TYPE    = 0x0115;
const ERR_INVALID_PARAM         = 0x0116;
const ERR_INVALID_ID            = 0x0117;
const ERR_FILE_OPEN             = 0x0118;
const ERR_CREATE_VERTEX         = 0x0119;
const ERR_NOT_SUPPORTED         = 0x0120;

const OPT_ENABLE_PERSPECTIVE_NICEST   = 0x1000;
const OPT_ENABLE_PERSPECTIVE_FASTEST  = 0x1001;
const OPT_WINDOW_FORCE_FULLSCREEN     = 0x1002;
const OPT_WINDOW_KEEP_SCREEN_ON       = 0x1003;
const OPT_ENABLE_BACK_KEY             = 0x1004;
const OPT_DISABLE_BACK_KEY            = 0x1005;
const OPT_ORIENTATION_PORTRAIT        = 0x1006;
const OPT_ORIENTATION_LANDSCAPE       = 0x1007;

const MODE_PRIVATE                    = 0x0000;
const MODE_WORLD_READABLE             = 0x0001;
const MODE_WORLD_WRITEABLE            = 0x0002;

const EVENT_MODIFIER_START             = 0;
const EVENT_MODIFIER_RESTART           = 1;
const EVENT_MODIFIER_FINISHED          = 2;

const MOTION_EVENT_ACTION_DOWN         = 0;
const MOTION_EVENT_ACTION_UP           = 1;
const MOTION_EVENT_ACTION_MOVE         = 2;
const MOTION_EVENT_ACTION_CANCEL       = 3;
const MOTION_EVENT_ACTION_OUTSIDE      = 4;
const MOTION_EVENT_ACTION_POINTER_DOWN = 5;
const MOTION_EVENT_ACTION_POINTER_UP   = 6;

const KEY_EVENT_ACTION_DOWN            = 0;
const KEY_EVENT_ACTION_UP              = 1;
const KEY_EVENT_ACTION_MULTIPLE        = 2;

const META_NONE           = 0;
const META_ALT_ON         = 0x02;
const META_ALT_LEFT_ON    = 0x10;
const META_ALT_RIGHT_ON   = 0x20;
const META_SHIFT_ON       = 0x01;
const META_SHIFT_LEFT_ON  = 0x40;
const META_SHIFT_RIGHT_ON = 0x80;
const META_SYM_ON         = 0x04;

const SENSOR_TYPE_ACCELEROMETER      = 1;
const SENSOR_TYPE_MAGNETIC_FIELD     = 2;
const SENSOR_TYPE_GYROSCOPE          = 4;
const SENSOR_TYPE_LIGHT              = 5;
const SENSOR_TYPE_PROXIMITY          = 8;

const SENSOR_STATUS_UNRELIABLE       = 0;
const SENSOR_STATUS_ACCURACY_LOW     = 1;
const SENSOR_STATUS_ACCURACY_MEDIUM  = 2;
const SENSOR_STATUS_ACCURACY_HIGH    = 3;

const SENSOR_STANDARD_GRAVITY           =  9.80665;
const SENSOR_MAGNETIC_FIELD_EARTH_MAX   =  60.0;
const SENSOR_MAGNETIC_FIELD_EARTH_MIN   =  30.0;

const KEYCODE_UNKNOWN         = 0;
const KEYCODE_SOFT_LEFT       = 1;
const KEYCODE_SOFT_RIGHT      = 2;
const KEYCODE_HOME            = 3;
const KEYCODE_BACK            = 4;
const KEYCODE_CALL            = 5;
const KEYCODE_ENDCALL         = 6;
const KEYCODE_0               = 7;
const KEYCODE_1               = 8;
const KEYCODE_2               = 9;
const KEYCODE_3               = 10;
const KEYCODE_4               = 11;
const KEYCODE_5               = 12;
const KEYCODE_6               = 13;
const KEYCODE_7               = 14;
const KEYCODE_8               = 15;
const KEYCODE_9               = 16;
const KEYCODE_STAR            = 17;
const KEYCODE_POUND           = 18;
const KEYCODE_DPAD_UP         = 19;
const KEYCODE_DPAD_DOWN       = 20;
const KEYCODE_DPAD_LEFT       = 21;
const KEYCODE_DPAD_RIGHT      = 22;
const KEYCODE_DPAD_CENTER     = 23;
const KEYCODE_VOLUME_UP       = 24;
const KEYCODE_VOLUME_DOWN     = 25;
const KEYCODE_POWER           = 26;
const KEYCODE_CAMERA          = 27;
const KEYCODE_CLEAR           = 28;
const KEYCODE_A               = 29;
const KEYCODE_B               = 30;
const KEYCODE_C               = 31;
const KEYCODE_D               = 32;
const KEYCODE_E               = 33;
const KEYCODE_F               = 34;
const KEYCODE_G               = 35;
const KEYCODE_H               = 36;
const KEYCODE_I               = 37;
const KEYCODE_J               = 38;
const KEYCODE_K               = 39;
const KEYCODE_L               = 40;
const KEYCODE_M               = 41;
const KEYCODE_N               = 42;
const KEYCODE_O               = 43;
const KEYCODE_P               = 44;
const KEYCODE_Q               = 45;
const KEYCODE_R               = 46;
const KEYCODE_S               = 47;
const KEYCODE_T               = 48;
const KEYCODE_U               = 49;
const KEYCODE_V               = 50;
const KEYCODE_W               = 51;
const KEYCODE_X               = 52;
const KEYCODE_Y               = 53;
const KEYCODE_Z               = 54;
const KEYCODE_COMMA           = 55;
const KEYCODE_PERIOD          = 56;
const KEYCODE_ALT_LEFT        = 57;
const KEYCODE_ALT_RIGHT       = 58;
const KEYCODE_SHIFT_LEFT      = 59;
const KEYCODE_SHIFT_RIGHT     = 60;
const KEYCODE_TAB             = 61;
const KEYCODE_SPACE           = 62;
const KEYCODE_SYM             = 63;
const KEYCODE_EXPLORER        = 64;
const KEYCODE_ENVELOPE        = 65;
const KEYCODE_ENTER           = 66;
const KEYCODE_DEL             = 67;
const KEYCODE_GRAVE           = 68;
const KEYCODE_MINUS           = 69;
const KEYCODE_EQUALS          = 70;
const KEYCODE_LEFT_BRACKET    = 71;
const KEYCODE_RIGHT_BRACKET   = 72;
const KEYCODE_BACKSLASH       = 73;
const KEYCODE_SEMICOLON       = 74;
const KEYCODE_APOSTROPHE      = 75;
const KEYCODE_SLASH           = 76;
const KEYCODE_AT              = 77;
const KEYCODE_NUM             = 78;
const KEYCODE_HEADSETHOOK     = 79;
const KEYCODE_FOCUS           = 80;
const KEYCODE_PLUS            = 81;
const KEYCODE_MENU            = 82;
const KEYCODE_NOTIFICATION    = 83;
const KEYCODE_SEARCH          = 84;
const KEYCODE_MEDIA_PLAY_PAUSE= 85;
const KEYCODE_MEDIA_STOP      = 86;
const KEYCODE_MEDIA_NEXT      = 87;
const KEYCODE_MEDIA_PREVIOUS  = 88;
const KEYCODE_MEDIA_REWIND    = 89;
const KEYCODE_MEDIA_FAST_FORWARD = 90;
const KEYCODE_MUTE            = 91;
const KEYCODE_PAGE_UP         = 92;
const KEYCODE_PAGE_DOWN       = 93;
const KEYCODE_PICTSYMBOLS     = 94;
const KEYCODE_SWITCH_CHARSET  = 95;
const KEYCODE_BUTTON_A        = 96;
const KEYCODE_BUTTON_B        = 97;
const KEYCODE_BUTTON_C        = 98;
const KEYCODE_BUTTON_X        = 99;
const KEYCODE_BUTTON_Y        = 100;
const KEYCODE_BUTTON_Z        = 101;
const KEYCODE_BUTTON_L1       = 102;
const KEYCODE_BUTTON_R1       = 103;
const KEYCODE_BUTTON_L2       = 104;
const KEYCODE_BUTTON_R2       = 105;
const KEYCODE_BUTTON_THUMBL   = 106;
const KEYCODE_BUTTON_THUMBR   = 107;
const KEYCODE_BUTTON_START    = 108;
const KEYCODE_BUTTON_SELECT   = 109;
const KEYCODE_BUTTON_MODE     = 110;

const AUDIO_CHANNEL_STOPPED   = 1;
const AUDIO_CHANNEL_PAUSED    = 2;
const AUDIO_CHANNEL_PLAYING   = 3;

EMO_RUNTIME_DELEGATE    <- null;
EMO_RUNTIME_STOPWATCH   <- emo.Stopwatch();

MOTION_EVENT_LISTENERS <- [];
KEY_EVENT_LISTENERS    <- [];
SENSOR_EVENT_LISTENERS <- [];

class emo.ModifierManager {
	modifiers = null;
	modifiersToRemove = null;
	function constructor() {
		modifiers = [];
		modifiersToRemove = [];
	}
	
	function add(modifier) {
		if (modifiers.len() == 0) {
			emo.Event().enableOnUpdateCallback();
		}
		modifiers.append(modifier);
	}
	
	function remove(modifier) {
		modifiersToRemove.append(modifier);
	}
	
	function onUpdate() {
		for (local i = 0; i < modifiers.len(); i++) {
			modifiers[i].onUpdate();
		}
		if (modifiersToRemove.len() > 0) {
			for (local i = 0; i < modifiersToRemove.len(); i++) {
				local idx = modifiers.find(modifiersToRemove[i]);
				if (idx != null) {
					modifiers.remove(idx);
				}
			}
			if (modifiers.len() == 0) {
				emo.Event().disableOnUpdateCallback();
			}
			modifiersToRemove.clear();
		}
	}
	
	function onPause() {
		for (local i = 0; i < modifiers.len(); i++) {
			modifiers[i].onPause();
		}
	}
	
	function onResume() {
		for (local i = 0; i < modifiers.len(); i++) {
			modifiers[i].onResume();
		}
	}
}

EMO_MODIFIER_MANAGER    <- emo.ModifierManager();

class emo.Modifier {
	name      = null;
	targetObj = null;
	startTime   = null;
	pausedTime  = null;
	minValue = null;
	maxValue = null;
	duration = null;
	easing   = null;
	started  = null;
	repeatCount   = null;
	currentCount  = null;
	eventCallback = null;
	function constructor(_minValue, _maxValue, _duration, _easing, _repeatCount = 0) {
		startTime   = EMO_RUNTIME_STOPWATCH.elapsed();
		pausedTime  = startTime;
		
		minValue = _minValue;
		maxValue = _maxValue;
		duration = _duration.tofloat();
		easing   = _easing;
		started  = false;
		repeatCount  = _repeatCount;
		currentCount = 0;
	}
	function elapsed() {
		return EMO_RUNTIME_STOPWATCH.elapsed() - startTime;
	}
	function currentValue(min, max, percent) {
		return min + (percent * (max - min));
	}
	function onPause() {
		pausedTime = EMO_RUNTIME_STOPWATCH.elapsed();
	}
	function onResume() {
		startTime = startTime + (EMO_RUNTIME_STOPWATCH.elapsed() - pausedTime);
	}
	function onUpdate() {
		if (!started) {
			started = true;
			if (eventCallback != null) {
				eventCallback(targetObj, this, EVENT_MODIFIER_START);
			}
		}

		local elapsedf = elapsed().tofloat();
		local percent  = easing(elapsedf, duration);
		local current  = currentValue(minValue, maxValue, percent);
		if (elapsedf >= duration) {
			onModify(maxValue);
			if (repeatCount == currentCount) {
				EMO_MODIFIER_MANAGER.remove(this);
				if (eventCallback != null) {
					eventCallback(targetObj, this, EVENT_MODIFIER_FINISH);
				}
			} else {
				startTime = EMO_RUNTIME_STOPWATCH.elapsed();
				currentCount++;
				if (eventCallback != null) {
					eventCallback(targetObj, this, EVENT_MODIFIER_RESTART);
				}
			}
			return;
		}
		onModify(current);
	}
	/* subclass must override this method to apply changes to targetObj. */
	function onModify(currentValue) {
		
	}
	function setObject(obj) {
		targetObj = obj;
	}

	function setName(_name) {
		name = _name;
	}

	function getName() {
		return name;
	}

	function setEventCallback(func) {
		eventCallback = func;
	}
}

class emo.MultiModifier extends emo.Modifier {
	enableMultipleEasing = null;
	function constructor(_minValue, _maxValue, _duration, _easing, _repeatCount = 0) {
		base.constructor(_minValue, _maxValue, _duration, _easing, _repeatCount);
		enableMultipleEasing = type(_easing) == "array";
	}

	function onUpdate() {
		if (!started) {
			started = true;
			if (eventCallback != null) {
				eventCallback(targetObj, this, EVENT_MODIFIER_START);
			}
		}
		local current = [];
		local elapsedf = elapsed().tofloat();
		for (local i = 0; i < minValue.len(); i++) {
			if (elapsedf >= duration) {
				onModify(maxValue);
				if (repeatCount == currentCount) {
					EMO_MODIFIER_MANAGER.remove(this);
					if (eventCallback != null) {
						eventCallback(targetObj, this, EVENT_MODIFIER_FINISH);
					}
				} else {
					startTime = EMO_RUNTIME_STOPWATCH.elapsed();
					currentCount++;
					if (eventCallback != null) {
						eventCallback(targetObj, this, EVENT_MODIFIER_RESTART);
					}
				}
				return;
			}
			local percent;
			if (enableMultipleEasing) {
				percent = easing[i](elapsedf, duration);
			} else {
				percent = easing(elapsedf, duration);
			}
			current.append(currentValue(minValue[i], maxValue[i], percent));
		}
		onModify(current);
	}
}

class emo.AlphaModifier extends emo.Modifier {
	function onModify(currentValue) {
		targetObj.alpha(currentValue);
	}
}

class emo.ScaleModifier extends emo.Modifier {
	function onModify(currentValue) {
		targetObj.scale(currentValue, currentValue);
	}
}

class emo.RotateModifier extends emo.Modifier {
	function onModify(currentValue) {
		targetObj.rotate(currentValue);
	}
}

class emo.AlphaModifier extends emo.Modifier {
	function onModify(currentValue) {
		targetObj.alpha(currentValue);
	}
}

class emo.MoveModifier extends emo.MultiModifier {
	function onModify(currentValue) {
		targetObj.move(currentValue[0], currentValue[1]);
	}
}

class emo.ColorModifier extends emo.MultiModifier {
	function onModify(currentValue) {
		targetObj.color(currentValue[0], currentValue[1], currentValue[2]);
	}
}

emo.easing <- {};
function emo::easing::Linear(elapsed, duration) {
	return elapsed / duration;
}

function emo::easing::CubicIn(elapsed, duration) {
	return (elapsed = elapsed / duration) * pow(elapsed, 2);
}

function emo::easing::CubicOut(elapsed, duration) {
	return (elapsed = elapsed / duration - 1) * pow(elapsed, 2) + 1;
}

function emo::easing::CubicInOut(elapsed, duration) {
	if ((elapsed /= duration / 2.0) < 1) return 1.0 / 2.0 * pow(elapsed, 3);
	return 1.0 / 2.0 * ((elapsed -= 2) * pow(elapsed, 2) + 2);
}

function emo::easing::BackIn(elapsed, duration) {
	return (elapsed /= duration) * elapsed * ((1.70158 + 1) * elapsed - 1.70158);
}

function emo::easing::BackOut(elapsed, duration) {
	return ((elapsed = elapsed / duration - 1) * elapsed * ((1.70158 + 1) * elapsed + 1.70158) + 1);
}

function emo::easing::BackInOut(elapsed, duration) {
	local s = 1.70158;
	if ((elapsed /= duration / 2.0) < 1) return 1.0 / 2.0 * (elapsed * elapsed * (((s *= (1.525)) + 1) * elapsed - s));
	return 1.0 / 2.0 * ((elapsed -= 2) * elapsed * (((s *= (1.525)) + 1) * elapsed + s) + 2);
}

function emo::easing::ElasticIn(elapsed, duration) {
	if ((elapsed /= duration) == 1) return 1;
	local p = duration * 0.3;
	local s = p / 4.0;
	return -(pow(2, 10 * (elapsed -= 1)) * sin((elapsed * duration - s) * (2.0 * PI) / p));
}

function emo::easing::ElasticOut(elapsed, duration) {
	if ((elapsed /= duration) == 1) return 1;
	local p = duration * 0.3;
	local s = p / 4.0;
	return (pow(2, -10 * elapsed) * sin((elapsed * duration - s) * (2.0 * PI) / p) + 1);
}

function emo::easing::ElasticInOut(elapsed, duration) {
	if ((elapsed /= duration / 2.0) == 2) return 1;
	local p = duration * (0.3 * 1.5);
	local s = p / 4.0;
	if (elapsed < 1) return -0.5 * (pow(2, 10 * (elapsed -= 1)) * sin((elapsed * duration - s) * (2.0 * PI) / p));
	return pow(2, -10 * (elapsed -= 1)) * sin((elapsed * duration - s) * (2.0 * PI) / p) * 0.5 + 1;
}

function emo::easing::BounceOut(elapsed, duration) {
	if ((elapsed /= duration) < (1.0 / 2.75)) return (7.5625 * elapsed * elapsed);
	else if (elapsed < (2.0 / 2.75)) return (7.5625 * (elapsed -= (1.5 / 2.75)) * elapsed + 0.75);
	else if (elapsed < (2.5 / 2.75)) return (7.5625 * (elapsed -= (2.25 / 2.75)) * elapsed + 0.9375);
	else return (7.5625 * (elapsed -= (2.625 / 2.75)) * elapsed + 0.984375);
}

function emo::easing::BounceIn(elapsed, duration) {
	return 1 - emo.easing.BounceOut(duration - elapsed, duration);
}

function emo::easing::BounceInOut(elapsed, duration) {
	if (elapsed < duration / 2.0) return emo.easing.BounceIn(elapsed * 2.0, duration) * 0.5;
	else return emo.easing.BounceOut(t * 2.0 - duration, duration) * 0.5 + 0.5;
}

function emo::easing::ExpoIn(elapsed, duration) {
	return (elapsed == 0) ? 0 : pow(2, 10 * (elapsed / duration - 1));
}

function emo::easing::ExpoOut(elapsed, duration) {
	return (elapsed == duration) ? 1 : (-pow(2, -10 * elapsed / duration) + 1);
}

function emo::easing::ExpoInOut(elapsed, duration) {
	if (elapsed == 0) return 0;
	if (elapsed == duration) return 1;
	if ((elapsed /= duration / 2.0) < 1) return 1.0 / 2.0 * pow(2, 10 * (elapsed - 1));
	return 1.0 / 2.0 * (-pow(2, -10 * --elapsed) + 2);
}

function emo::easing::QuadIn(elapsed, duration) {
	return (elapsed /= duration) * elapsed;
}

function emo::easing::QuadOut(elapsed, duration) {
	return -1 * (elapsed /= duration) * (elapsed - 2);
}

function emo::easing::QuadInOut(elapsed, duration) {
	if ((elapsed /= duration / 2.0) < 1) return 1.0 / 2.0 * elapsed * elapsed;
	return -1.0 / 2.0 * ((--elapsed) * (elapsed - 2) - 1);
}

function emo::easing::SineIn(elapsed, duration) {
	return -1 * cos(elapsed / duration * (PI / 2.0)) + 1;
}

function emo::easing::SineOut(elapsed, duration) {
	return 1 * sin(elapsed / duration * (PI / 2.0));
}

function emo::easing::SineInOut(elapsed, duration) {
	if ((elapsed /= duration / 2.0) < 1) return 1.0 / 2.0 * (sin(PI * elapsed / 2.0));
	return -1.0 / 2.0 * (cos(PI * --elapsed / 2.0) - 2);
}

function emo::easing::CircIn(elapsed, duration) {
	return -1 * (sqrt(1 - (elapsed /= duration) * elapsed) - 1);
}

function emo::easing::CircOut(elapsed, duration) {
	return sqrt(1 - (elapsed = elapsed / duration - 1) * elapsed);
}

function emo::easing::CircInOut(elapsed, duration) {
	if ((elapsed /= duration / 2.0) < 1) return -1.0 / 2.0 * (sqrt(1 - elapsed * elapsed) - 1);
	return 1.0 / 2.0 * (sqrt(1 - (elapsed -= 2) * elapsed) + 1);

}

function emo::easing::QuintIn(elapsed, duration) {
	return (elapsed /= duration) * elapsed * elapsed * elapsed * elapsed;
}

function emo::easing::QuintOut(elapsed, duration) {
	return ((elapsed = elapsed / duration - 1) * elapsed * elapsed * elapsed * elapsed + 1);
}

function emo::easing::QuintInOut(elapsed, duration) {
	if ((elapsed /= duration / 2.0) < 1) return 1.0 / 2.0 * elapsed * elapsed * elapsed * elapsed * elapsed;
	return 1.0 / 2.0 * ((elapsed -= 2) * elapsed * elapsed * elapsed * elapsed + 2);
}

function emo::easing::QuartIn(elapsed, duration) {
	return (elapsed /= duration) * elapsed * elapsed * elapsed;
}

function emo::easing::QuartOut(elapsed, duration) {
	return -1 * ((elapsed = elapsed / duration - 1) * elapsed * elapsed * elapsed - 1);
}

function emo::easing::QuartInOut(elapsed, duration) {
	if ((t /= duration / 2.0) < 1) return 1.0 / 2.0 * elapsed * elapsed * elapsed * elapsed;
	return -1.0 / 2.0 * ((elapsed -= 2) * elapsed * elapsed * elapsed - 2);
}

class emo.MotionEvent {
    param = null;
    function constructor(args) {
        param = args;
    }

    function getPointerId() { return param[0]; }
    function getAction()    { return param[1]; }
    function getX() { return param[2]; }
    function getY() { return param[3]; }
    function getEventTime() { return param[4] + (param[5] / 1000); }
    function getDeviceId()  { return param[6]; }
    function getSource() { return param[7]; }

    function toString() {
        local sb = "";
        for(local i = 0; i < param.len(); i++) {
            sb = sb + param[i] + " ";
        }
        return sb;
    }
}

class emo.KeyEvent {
    param = null;
    function constructor(args) {
        param = args;
    }
    function getAction() { return param[0]; }
    function getKeyCode() { return param[1]; }
    function getRepeatCount() { return param[2]; }
    function getMetaState() { return param[3]; }
    function getEventTime() { return param[4] + (param[5] / 1000); }
    function getDeviceId()  { return param[6]; }
    function getSource() { return param[7]; }

    function toString() {
        local sb = "";
        for(local i = 0; i < param.len(); i++) {
            sb = sb + param[i] + " ";
        }
        return sb;
    }
}

class emo.SensorEvent {
    param = null;
    function constructor(args) {
        param = args;
    }

    function getType() { return param[0]; }
    function getAccelerationX() { return param[1]; }
    function getAccelerationY() { return param[2]; }
    function getAccelerationZ() { return param[3]; }

    function toString() {
        local sb = "";
        for(local i = 0; i < param.len(); i++) {
            sb = sb + param[i] + " ";
        }
        return sb;
    }
}

class emo.AudioChannel {

    id        = null;
    manager   = null;

    function constructor(_id, _manager) {
        id = _id;
        manager = _manager;
    }

    function load(file) {
        local runtime = emo.Runtime();
        if (runtime.os() == OS_ANDROID) {
            file = ANDROID_SOUNDS_DIR + file;
        }
	    return manager.load(id, file);
	}
    function play()  { return manager.play(id); }
    function pause() { return manager.pause(id); }
    function stop()  { return manager.stop(id); }
    function seek(pos) { return manager.seek(id, pos); }
    function getVolume() { return manager.getVolume(id); }
    function setVolume(vol) { return manager.setVolume(id, vol); }
    function getMaxVolume() { return manager.getMaxVolume(id); }
    function getMinVolume() { return manager.getMinVolume(id); }
    function setLoop(enable) {
        return manager.setLoop(id, enable ? EMO_YES : EMO_NO);
    }
    function isLoop() {
        return manager.isLoop(id) == EMO_YES ? true : false;
    }
    function getState() { return manager.getState(id); }
    function close() { return manager.close(id); }
}

function emo::Audio::createChannel(id) {
    return emo.AudioChannel(id, this);
}

class emo.Sprite {

    name   = null;
    stage  = emo.Stage();
    runtime = emo.Runtime();

    id       = null;
    childId  = null;
    loaded   = null;

    function constructor(rawname) {
        name = this.getResourceName(rawname);
        id   = stage.createSprite(name);
        childId = -1;
        loaded = false;
    }

    function getResourceName(rawname) {
        if (runtime.os() == OS_ANDROID) {
            rawname = ANDROID_GRAPHICS_DIR + rawname;
        }
        return rawname;
    }

    function load(x = null, y = null, width = null, height = null) {
        local status = EMO_NO_ERROR;
        if (!loaded) {

            status = stage.loadSprite(id, x, y, width, height);

            if (status == EMO_NO_ERROR) {
                loaded = true;
            }
        }
        return status;
    }
	
    function show() { return stage.show(id); }
    function hide() { return stage.hide(id); }
    function alpha(a = null) { return stage.alpha(id, a); }
    function red  (r = null) { return stage.red  (id, r); }
    function green(g = null) { return stage.green(id, g); }
    function blue (b = null) { return stage.blue (id, b); }

    function isLoaded() { return loaded; }

    function getX() { return stage.getX(id); }
    function getY() { return stage.getY(id); }
    function getZ() { return stage.getZ(id); }
    function getWidth()  { return stage.getWidth(id); }
    function getHeight() { return stage.getHeight(id); }

    function setX(x) { return stage.setX(id, x); }
    function setY(y) { return stage.setY(id, y); }
    function setZ(z) { return stage.setZ(id, z); }

    function setWidth(w)   { return stage.setWidth(id, w); }
    function setHeight(h)  { return stage.setHeight(id, h); }
    function setSize(w, h) { return stage.setSize(id, w, h); }

    function getScale()  { return stage.getScaleX(id); }
    function getScaleX() { return stage.getScaleX(id); }
    function getScaleY() { return stage.getScaleY(id); }
    function getAngle()  { return stage.getAngle(id); }

    function contains(x, y) {
        return x >= this.getX() && x <= getX() + getWidth() &&
               y >= this.getY() && y <= getY() + getHeight();
    }

    function collidesWith(other) {
        return this.getX() < other.getX() + other.getWidth() && other.getX() < this.getX() + this.getWidth() &&
            this.getY() < other.getY() + other.getHeight() && other.getY() < this.getY() + this.getHeight();
    }

    function _cmp(other) {
        if (this.getId() == other.getId())  return 0;
        if (this.getId() >  other.getId())  return 1;
        return -1;
    }

    function move(x, y, z = 0) {
        return stage.move(id, x, y, z);
    }

    function pos(x, y, z = 0) {
        return move(x, y, z);
    }

    function scale(scaleX, scaleY, centerX = null, centerY = null) {
        return stage.scale(id, scaleX, scaleY, centerX, centerY);
    }

    function rotate(angle, centerX = null, centerY = null, axis = null) {
        return stage.rotate(id, angle, centerX, centerY, axis);
    }

    function color(red, green, blue, alpha = null) {
        return stage.color(id, red, green, blue, alpha);
    }

    function remove() {
        local status = EMO_NO_ERROR;
        if (loaded) {
            status = stage.remove(id);
            loaded = false;
        }
        return status;
    }

    function getId() {
        return id;
    }

    function getName() {
        return name;
    }
    
    function addModifier(modifier) {
    	modifier.setObject(this);
    	EMO_MODIFIER_MANAGER.add(modifier);
    }

    function removeModifier(modifier) {
    	EMO_MODIFIER_MANAGER.remove(modifier);
    }
}

class emo.SpriteSheet extends emo.Sprite {

	function constructor(rawname, frameWidth, frameHeight, border = 0, margin = 0, frameIndex = 0) {
        name = base.getResourceName(rawname);
        id = stage.createSpriteSheet(name, frameIndex, frameWidth, frameHeight, border, margin);
	}
	
    function load(x = null, y = null, frameIndex = null) {
        local status = EMO_NO_ERROR;
        if (!loaded) {
            if (frameIndex != null) setFrame(frameIndex);
            status = stage.loadSprite(id, x, y);

            if (status == EMO_NO_ERROR) {
                loaded = true;
            }
        }
        return status;
    }

    function animate(startFrame, frameCount, interval, loopCount = 0) {
        return stage.animate(id, startFrame, frameCount, interval, loopCount);
    }

    function pause() {
        return stage.pause(id);
    }

    function pauseAt(frameIndex) {
        return stage.pauseAt(id, frameIndex);
    }

    function setFrame(frameIndex) {
        return pauseAt(frameIndex);
    }

    function stop() {
        return stage.stop(id);
    }
	
	function getFrameIndex() {
		return stage.getFrameIndex(id);
	}
	
	function getFrameCount() {
		return stage.getFrameCount(id);
	}
}

class emo.Rectangle extends emo.Sprite {
	function constructor() {
		name = null;
        id = stage.createSprite(name);
	}
}

class emo.MapSprite extends emo.Sprite {
    function constructor(rawname, frameWidth, frameHeight, border = 0, margin = 0, frameIndex = 0) {
        local sprite = emo.SpriteSheet(rawname, frameWidth, frameHeight, border, margin, frameIndex);
        name         = sprite.getName();
        childId      = sprite.getId();
        id           = stage.createMapSprite(sprite.getId());
    }

    function load(x = null, y = null, width = null, height = null) {
        local status = EMO_NO_ERROR;
        if (!loaded) {
            status = stage.loadMapSprite(id, x, y, width, height);
            if (status == EMO_NO_ERROR) {
                loaded = true;
            }
        }
        return status;
    }

    function addRow(tiles) {
        return stage.addTileRow(id, tiles);
    }

    function setMap(tiles) {
        stage.clearTiles(id);
        for (local i = 0; i < tiles.len(); i++) {
            this.addRow(tiles[i]);
        }
    }

    function setTileAt(row, column, value) {
        return stage.setTileAt(id, row, column, value);
    }

    function getTileAt(row, column) {
        return stage.getTileAt(id, row, column);
    }

    function getTileIndexAtCoord(x, y) {
        return stage.getTileIndexAtCoord(id, x, y);
    }

    function getTilePositionAtCoord(x, y) {
        return stage.getTilePositionAtCoord(id, x, y);
    }

    function show() { return stage.show(childId); }
    function hide() { return stage.hide(childId); }
    function alpha(a = null) { return stage.alpha(childId, a); }
    function red  (r = null) { return stage.red  (childId, r); }
    function green(g = null) { return stage.green(childId, g); }
    function blue (b = null) { return stage.blue (childId, b); }
}

function emo::Stage::load(obj) {

    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onDispose")) {
        EMO_RUNTIME_DELEGATE.onDispose();
        EMO_RUNTIME_DELEGATE = null;
    }

    EMO_RUNTIME_DELEGATE = obj;
    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onLoad")) {
        EMO_RUNTIME_DELEGATE.onLoad();
    }
}

function emo::Stage::getWindowWidth() {
	return this.windowWidth();
}

function emo::Stage::getWindowHeight() {
	return this.windowHeight();
}

function emo::Event::addMotionEventListener(listener) {
	MOTION_EVENT_LISTENERS.append(listener);
}

function emo::Event::addKeyEventListener(listener) {
	KEY_EVENT_LISTENERS.append(listener);
}

function emo::Event::addSensorEventListener(listener) {
	SENSOR_EVENT_LISTENERS.append(listener);
}

function emo::Event::removeMotionEventListener(listener) {
	MOTION_EVENT_LISTENERS.remove(listener);
}

function emo::Event::removeKeyEventListener(listener) {
	KEY_EVENT_LISTENERS.remove(listener);
}

function emo::Event::removeSensorEventListener(listener) {
	SENSOR_EVENT_LISTENERS.remove(listener);
}

function emo::_onLoad() { 
    if (emo.rawin("onLoad")) {
        emo.onLoad();
    }
}

function emo::_onGainedFocus() {

    EMO_RUNTIME_STOPWATCH.start();
	EMO_MODIFIER_MANAGER.onResume();

    if (emo.rawin("onGainedFocus")) {
        emo.onGainedFocus();
    }
    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onGainedFocus")) {
        EMO_RUNTIME_DELEGATE.onGainedFocus();
    }
}

function emo::_onLostFocus() {

	EMO_MODIFIER_MANAGER.onPause();
	
    if (emo.rawin("onLostFocus")) {
        emo.onLostFocus();
    }
    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onLostFocus")) {
        EMO_RUNTIME_DELEGATE.onLostFocus();
    }

    EMO_RUNTIME_STOPWATCH.stop();
}

function emo::_onDispose() {
    if (emo.rawin("onDispose")) {
        emo.onDispose();
    }
    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onDispose")) {
        EMO_RUNTIME_DELEGATE.onDispose();
    }
} 

function emo::_onError(msg) {
    if (emo.rawin("onError")) {
        emo.onError(msg);
    }
    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onError")) {
        EMO_RUNTIME_DELEGATE.onError(msg);
    }
}

function emo::_onDrawFrame(dt) {
    if (emo.rawin("onDrawFrame")) {
        emo.onDrawFrame(dt);
    }
    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onDrawFrame")) {
        EMO_RUNTIME_DELEGATE.onDrawFrame(dt);
    }
}

function emo::_onUpdate(dt) {
    EMO_MODIFIER_MANAGER.onUpdate();
}

function emo::_onLowMemory() {
    if (emo.rawin("onLowMemory")) {
        emo.onLowMemory();
    }
    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onLowMemory")) {
        EMO_RUNTIME_DELEGATE.onLowMemory();
    }
}

function emo::_onMotionEvent(...) {
    local mevent = emo.MotionEvent(vargv);
    if (emo.rawin("onMotionEvent")) {
        emo.onMotionEvent(mevent);
    }
    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onMotionEvent")) {
        EMO_RUNTIME_DELEGATE.onMotionEvent(mevent);
    }

    for (local i = 0; i < MOTION_EVENT_LISTENERS.len(); i++) {
        if (MOTION_EVENT_LISTENERS[i].rawin("onMotionEvent")) {
            MOTION_EVENT_LISTENERS[i].onMotionEvent(mevent);
        }
    }
}

function emo::_onKeyEvent(...) {
    local kevent = emo.KeyEvent(vargv);
    if (emo.rawin("onKeyEvent")) {
        emo.onKeyEvent(kevent);
    }
    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onKeyEvent")) {
        EMO_RUNTIME_DELEGATE.onKeyEvent(kevent);
    }

    for (local i = 0; i < KEY_EVENT_LISTENERS.len(); i++) {
        if (KEY_EVENT_LISTENERS[i].rawin("onKeyEvent")) {
            KEY_EVENT_LISTENERS[i].onKeyEvent(kevent);
        }
    }
}

function emo::_onSensorEvent(...) {
    local sevent = emo.SensorEvent(vargv);
    if (emo.rawin("onSensorEvent")) {
        emo.onSensorEvent(sevent);
    }
    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onSensorEvent")) {
        EMO_RUNTIME_DELEGATE.onSensorEvent(sevent);
    }

    for (local i = 0; i < SENSOR_EVENT_LISTENERS.len(); i++) {
        if (SENSOR_EVENT_LISTENERS[i].rawin("onSensorEvent")) {
            SENSOR_EVENT_LISTENERS[i].onSensorEvent(sevent);
        }
    }
}

function emo::_onCallback(...) {
    if (emo.rawin("onCallback")) {
        emo.onCallback(vargv[0], vargv[1]);
    }
    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onCallback")) {
        EMO_RUNTIME_DELEGATE.onCallback(vargv[0], vargv[1]);
    }
}

function emo::_onFps(fps) {
    if (emo.rawin("onFps")) {
        emo.onFps(fps);
    }
    if (EMO_RUNTIME_DELEGATE != null &&
             EMO_RUNTIME_DELEGATE.rawin("onFps")) {
        EMO_RUNTIME_DELEGATE.onFps(fps);
    }
}
