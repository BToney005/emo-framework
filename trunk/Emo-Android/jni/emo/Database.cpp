#include "Database.h"

#include <sstream>
#include <stdlib.h>

#include "Constants.h"
#include "Runtime.h"
#include "Engine.h"
#include "VmFunc.h"

extern emo::Engine* engine;


void initDatabaseFunctions() {
    registerClass(engine->sqvm, EMO_DATABASE_CLASS);
    registerClass(engine->sqvm, EMO_PREFERENCE_CLASS);

    registerClassFunc(engine->sqvm, EMO_DATABASE_CLASS, "openOrCreate", emoDatabaseOpenOrCreate);
    registerClassFunc(engine->sqvm, EMO_DATABASE_CLASS, "open",         emoDatabaseOpen);
    registerClassFunc(engine->sqvm, EMO_DATABASE_CLASS, "close",        emoDatabaseClose);
    registerClassFunc(engine->sqvm, EMO_DATABASE_CLASS, "getPath",      emoDatabaseGetPath);
    registerClassFunc(engine->sqvm, EMO_DATABASE_CLASS, "getLastError", emoDatabaseGetLastError);
    registerClassFunc(engine->sqvm, EMO_DATABASE_CLASS, "getLastErrorMessage", emoDatabaseGetLastErrorMessage);
    registerClassFunc(engine->sqvm, EMO_DATABASE_CLASS, "deleteDatabase", emoDatabaseDeleteDatabase);

    registerClassFunc(engine->sqvm, EMO_PREFERENCE_CLASS, "open",         emoDatabaseOpenPreference);
    registerClassFunc(engine->sqvm, EMO_PREFERENCE_CLASS, "openOrCreate", emoDatabaseOpenOrCreatePreference);
    registerClassFunc(engine->sqvm, EMO_PREFERENCE_CLASS, "get",          emoDatabaseGetPreference);
    registerClassFunc(engine->sqvm, EMO_PREFERENCE_CLASS, "set",          emoDatabaseSetPreference);
    registerClassFunc(engine->sqvm, EMO_PREFERENCE_CLASS, "del",          emoDatabaseDeletePreference);
    registerClassFunc(engine->sqvm, EMO_PREFERENCE_CLASS, "keys",         emoDatabaseGetPreferenceKeys);
    registerClassFunc(engine->sqvm, EMO_PREFERENCE_CLASS, "close",        emoDatabaseClose);
}

static int database_preference_callback(void *arg, int argc, char **argv, char **column)  {
    std::string* value = (std::string*)arg;
    if (argc > 0) *value = argv[0];
    return SQLITE_OK;
}

static int database_count_callback(void *arg, int argc, char **argv, char **column)  {
    int* count = (int*)arg;
    if (argc > 0) *count = atoi(argv[0]);
    return SQLITE_OK;
}

static int database_query_vector_callback(void *arg, int argc, char **argv, char **column)  {
    std::vector<std::string>* values = (std::vector<std::string>*)arg;

    for (int i = 0; i < argc; i++) {
        values->push_back(argv[i]);
    }

    return SQLITE_OK;
}

namespace emo {

    Database::Database() {
        this->isOpen = false;
        this->lastError = SQLITE_OK;
    }

    Database::~Database() {

    }

    std::string Database::getPath(std::string name) {
        std::string databasePath;
        JNIEnv* env;
        JavaVM* vm = engine->app->activity->vm;
        
        vm->AttachCurrentThread(&env, NULL);

        jclass clazz = env->GetObjectClass(engine->app->activity->clazz);
        jmethodID methodj = env->GetMethodID(clazz, "getDatabasePath", "(Ljava/lang/String;)Ljava/io/File;");
        jobject filej = env->CallObjectMethod(engine->app->activity->clazz, methodj, env->NewStringUTF(name.c_str()));
        if (filej != NULL) {
            clazz = env->GetObjectClass(filej);
            methodj = env->GetMethodID(clazz, "getPath", "()Ljava/lang/String;");
            jstring jstr = (jstring)env->CallObjectMethod(filej, methodj);
            if (jstr != NULL) {
                const char* str = env->GetStringUTFChars(jstr, NULL);
                databasePath = str;
                env->ReleaseStringUTFChars(jstr, str);
            }
        }
        vm->DetachCurrentThread();

        return databasePath;
    }

    std::string Database::create(std::string name, jint mode) {
        std::string filename;
        JNIEnv* env;
        JavaVM* vm = engine->app->activity->vm;
        
        vm->AttachCurrentThread(&env, NULL);

        jclass clazz = env->GetObjectClass(engine->app->activity->clazz);
        jmethodID methodj = env->GetMethodID(clazz, "openOrCreateDatabase", "(Ljava/lang/String;ILandroid/database/sqlite/SQLiteDatabase$CursorFactory;)Landroid/database/sqlite/SQLiteDatabase;");
        jobject jdb = env->CallObjectMethod(engine->app->activity->clazz, methodj,  env->NewStringUTF(name.c_str()), mode, NULL);
        if (jdb != NULL) {
            clazz = env->GetObjectClass(jdb);
            methodj = env->GetMethodID(clazz, "getPath", "()Ljava/lang/String;");
            jstring jstr = (jstring)env->CallObjectMethod(jdb, methodj);
            if (jstr != NULL) {
                const char* str = env->GetStringUTFChars(jstr, NULL);
                filename = str;
                env->ReleaseStringUTFChars(jstr, str);
            }
            methodj = env->GetMethodID(clazz, "close", "()V");
            env->CallVoidMethod(jdb, methodj);
        }
        vm->DetachCurrentThread();

        return filename;
    }

    bool Database::deleteDatabase(std::string name) {
        JNIEnv* env;
        JavaVM* vm = engine->app->activity->vm;
        
        vm->AttachCurrentThread(&env, NULL);

        jclass clazz = env->GetObjectClass(engine->app->activity->clazz);
        jmethodID methodj = env->GetMethodID(clazz, "deleteDatabase", "(Ljava/lang/String;)Z");
        jboolean deleted = env->CallBooleanMethod(engine->app->activity->clazz, methodj, env->NewStringUTF(name.c_str()));

        vm->DetachCurrentThread();

        return deleted;
    }

    bool Database::openOrCreate(std::string name, jint mode) {
        if (this->isOpen) return false;
        
        std::string path = this->create(name, mode);
        
        int rcode = sqlite3_open(path.c_str(), &this->db);
        
        if (rcode != SQLITE_OK) {
            this->lastError = rcode;
            this->lastErrorMessage =  sqlite3_errmsg(this->db);
        }
        
        this->isOpen = true;
        return true;
    }

    bool Database::open(std::string name) {
        if (this->isOpen) return false;

        std::string path = this->getPath(name);

        int rcode = sqlite3_open(path.c_str(), &this->db);
        
        if (rcode != SQLITE_OK) {
            this->lastError = rcode;
            this->lastErrorMessage =  sqlite3_errmsg(this->db);
        }
        
        this->isOpen = true;
        return true;
    }

    bool Database::close() {
        if (!this->isOpen) return false;

        sqlite3_close(this->db);

        this->isOpen = false;
        return true;
    }

    int Database::exec(std::string sql) {
        char* error;
        int rcode = sqlite3_exec(this->db, sql.c_str(), NULL, 0, &error);
        if (rcode != SQLITE_OK) {
            this->lastError = rcode;
            this->lastErrorMessage = error;
            sqlite3_free(error);
        }
        return rcode;
    }

    int Database::exec_count(std::string sql, int* count) {
        char* error;
        int rcode = sqlite3_exec(this->db, sql.c_str(), database_count_callback, count, &error);
        if (rcode != SQLITE_OK) {
            this->lastError = rcode;
            this->lastErrorMessage = error;
            sqlite3_free(error);
        }
        return rcode;
    }

    int Database::query_vector(std::string sql, std::vector<std::string>* values) {
        char* error;
        int rcode = sqlite3_exec(this->db, sql.c_str(), database_query_vector_callback, values, &error);
        if (rcode != SQLITE_OK) {
            this->lastError = rcode;
            this->lastErrorMessage = error;
            sqlite3_free(error);
        }
        return rcode;
    }

    bool Database::openOrCreatePreference() {
        bool result = this->openOrCreate(DEFAULT_DATABASE_NAME, FILE_MODE_PRIVATE);
        if (!result) return false;

        char* sql = sqlite3_mprintf("CREATE TABLE IF NOT EXISTS %q (KEY TEXT PRIMARY KEY, VALUE TEXT)", PREFERENCE_TABLE_NAME);
        int rcode = this->exec(sql);
        sqlite3_free(sql);

        return rcode == SQLITE_OK;
    }

    bool Database::openPreference() {
        return this->open(DEFAULT_DATABASE_NAME);
    }

    std::string Database::getPreference(std::string key) {
        bool forceClose = false;

        if (!this->isOpen) {
            this->openOrCreatePreference();
            forceClose = true;
        }

        std::string value;
        char* sql = sqlite3_mprintf("SELECT VALUE FROM %q WHERE KEY=%Q", PREFERENCE_TABLE_NAME, key.c_str());

        char* error;
        int rcode = sqlite3_exec(this->db, sql, database_preference_callback, &value, &error);
        if (rcode != SQLITE_OK) {
            this->lastError = rcode;
            this->lastErrorMessage = error;
            sqlite3_free(error);
        }
        sqlite3_free(sql);

        if (forceClose) {
            this->close();
        }
        return value;
    }

    bool Database::setPreference(std::string key, std::string value) {
        bool forceClose = false;
        if (!this->isOpen) {
            this->openOrCreatePreference();
            forceClose = true;
        }

        int count;
        char *csql = sqlite3_mprintf("SELECT COUNT(*) FROM %q WHERE KEY=%Q", PREFERENCE_TABLE_NAME, key.c_str());
        exec_count(csql, &count);
        sqlite3_free(csql);

        int rcode = SQLITE_OK;
        if (count == 0) {
            char* sql = sqlite3_mprintf("INSERT INTO %q(KEY,VALUE) VALUES(%Q,%Q)", PREFERENCE_TABLE_NAME, key.c_str(), value.c_str());
            rcode = this->exec(sql);
            sqlite3_free(sql);
        } else {
            char* sql = sqlite3_mprintf("UPDATE %q SET VALUE=%Q WHERE KEY=%Q", PREFERENCE_TABLE_NAME, value.c_str(), key.c_str());
            rcode = this->exec(sql);
            sqlite3_free(sql);
        }

        if (forceClose) {
            this->close();
        }

        return rcode == SQLITE_OK;
    }

    std::vector<std::string> Database::getPreferenceKeys() {
        bool forceClose = false;
        if (!this->isOpen) {
            this->openOrCreatePreference();
            forceClose = true;
        }

        std::vector<std::string> keys;
        char *sql = sqlite3_mprintf("SELECT KEY FROM %q", PREFERENCE_TABLE_NAME);
        query_vector(sql, &keys);
        sqlite3_free(sql);

        if (forceClose) {
            this->close();
        }
        return keys;
    }

    bool Database::deletePreference(std::string key) {
        bool forceClose = false;
        if (!this->isOpen) {
            this->openOrCreatePreference();
            forceClose = true;
        }

        char *sql = sqlite3_mprintf("DELETE FROM %q WHERE KEY=%Q", PREFERENCE_TABLE_NAME, key.c_str());
        int rcode = this->exec(sql);
        sqlite3_free(sql);

        if (forceClose) {
            this->close();
        }
        return rcode == SQLITE_OK;
    }

}
SQInteger emoDatabaseOpenOrCreate(HSQUIRRELVM v) {
    const SQChar* name;
    SQInteger nargs = sq_gettop(v);
    if (nargs >= 2 && sq_gettype(v, 2) == OT_STRING) {
        sq_tostring(v, 2);
        sq_getstring(v, -1, &name);
        sq_poptop(v);
    } else {
        sq_pushinteger(v, ERR_INVALID_PARAM);
        return 1;
    }

    SQInteger mode = FILE_MODE_PRIVATE;
    if (nargs >= 3 && sq_gettype(v, 3) == OT_INTEGER) {
        sq_getinteger(v, 3, &mode);
    }

    if (!engine->database->openOrCreate(name, mode)) {
        sq_pushinteger(v, ERR_DATABASE_OPEN);
        return 1;
    }

    sq_pushinteger(v, EMO_NO_ERROR);
    return 1;
}

SQInteger emoDatabaseOpen(HSQUIRRELVM v) {
    const SQChar* name;
    SQInteger nargs = sq_gettop(v);
    if (nargs >= 2 && sq_gettype(v, 2) == OT_STRING) {
        sq_tostring(v, 2);
        sq_getstring(v, -1, &name);
        sq_poptop(v);
    } else {
        sq_pushinteger(v, ERR_INVALID_PARAM);
        return 1;
    }

    if (!engine->database->open(name)) {
        sq_pushinteger(v, ERR_DATABASE_OPEN);
        return 1;
    }

    sq_pushinteger(v, EMO_NO_ERROR);
    return 1;
}

SQInteger emoDatabaseClose(HSQUIRRELVM v) {
    if (!engine->database->close()) {
        sq_pushinteger(v, ERR_DATABASE_CLOSE);
        return 1;
    }

    sq_pushinteger(v, EMO_NO_ERROR);
    return 1;
}

SQInteger emoDatabaseGetPath(HSQUIRRELVM v) {
    const SQChar* name;
    SQInteger nargs = sq_gettop(v);
    if (nargs >= 2 && sq_gettype(v, 2) == OT_STRING) {
        sq_tostring(v, 2);
        sq_getstring(v, -1, &name);
        sq_poptop(v);
    } else {
        return 0;
    }

    const char* path = engine->database->getPath(name).c_str();

    sq_pushstring(v, path, strlen(path));

    return 1;
}

SQInteger emoDatabaseGetLastError(HSQUIRRELVM v) {
    sq_pushinteger(v, engine->database->lastError);
    return 1;
}

SQInteger emoDatabaseGetLastErrorMessage(HSQUIRRELVM v) {
    const char* str = engine->database->lastErrorMessage.c_str();
    sq_pushstring(v, str, strlen(str));
    return 1;
}

SQInteger emoDatabaseOpenPreference(HSQUIRRELVM v) {
    if (!engine->database->openPreference()) {
        sq_pushinteger(v, ERR_DATABASE_OPEN);
        return 1;
    }

    sq_pushinteger(v, EMO_NO_ERROR);
    return 1;
}

SQInteger emoDatabaseOpenOrCreatePreference(HSQUIRRELVM v) {
    if (!engine->database->openOrCreatePreference()) {
        sq_pushinteger(v, ERR_DATABASE_OPEN);
        return 1;
    }

    sq_pushinteger(v, EMO_NO_ERROR);
    return 1;
}

SQInteger emoDatabaseGetPreference(HSQUIRRELVM v) {
    const SQChar* key;
    SQInteger nargs = sq_gettop(v);
    if (nargs >= 2 && sq_gettype(v, 2) == OT_STRING) {
        sq_tostring(v, 2);
        sq_getstring(v, -1, &key);
        sq_poptop(v);
    } else {
        return 0;
    }

    const char* str = engine->database->getPreference(key).c_str();

    sq_pushstring(v, str, strlen(str));
    return 1;
}

SQInteger emoDatabaseSetPreference(HSQUIRRELVM v) {
    const SQChar* key;
    SQInteger nargs = sq_gettop(v);
    if (nargs >= 2 && sq_gettype(v, 2) == OT_STRING) {
        sq_tostring(v, 2);
        sq_getstring(v, -1, &key);
        sq_poptop(v);
    } else {
        sq_pushinteger(v, ERR_INVALID_PARAM);
        return 1;
    }

    const SQChar* value;
    if (nargs >= 3 && sq_gettype(v, 3) == OT_STRING) {
        sq_tostring(v, 3);
        sq_getstring(v, -1, &value);
        sq_poptop(v);
    } else {
        sq_pushinteger(v, ERR_INVALID_PARAM);
        return 1;
    }

    if (!engine->database->setPreference(key, value)) {
        sq_pushinteger(v, ERR_DATABASE);
        return 1;
    }

    sq_pushinteger(v, EMO_NO_ERROR);
    return 1;
}

SQInteger emoDatabaseDeleteDatabase(HSQUIRRELVM v) {
    const SQChar* name;
    SQInteger nargs = sq_gettop(v);
    if (nargs >= 2 && sq_gettype(v, 2) == OT_STRING) {
        sq_tostring(v, 2);
        sq_getstring(v, -1, &name);
        sq_poptop(v);
    } else {
        sq_pushinteger(v, ERR_INVALID_PARAM);
        return 1;
    }
    if (!engine->database->deleteDatabase(name)) {
        sq_pushinteger(v, ERR_DATABASE);
        return 1;
    }

    sq_pushinteger(v, EMO_NO_ERROR);
    return 1;

}

SQInteger emoDatabaseDeletePreference(HSQUIRRELVM v) {
    const SQChar* key;
    SQInteger nargs = sq_gettop(v);
    if (nargs >= 2 && sq_gettype(v, 2) == OT_STRING) {
        sq_tostring(v, 2);
        sq_getstring(v, -1, &key);
        sq_poptop(v);
    } else {
        sq_pushinteger(v, ERR_INVALID_PARAM);
        return 1;
    }
    if (!engine->database->deletePreference(key)) {
        sq_pushinteger(v, ERR_DATABASE);
        return 1;
    }

    sq_pushinteger(v, EMO_NO_ERROR);
    return 1;
}

SQInteger emoDatabaseGetPreferenceKeys(HSQUIRRELVM v) {

    std::vector<std::string> keys = engine->database->getPreferenceKeys();

    sq_newarray(v, 0);

    for (unsigned int i = 0; i < keys.size(); i++) {
        sq_pushstring(v, keys[i].c_str(), -1);
        sq_arrayappend(v, -2);
    }

    sq_push(v, -1);

    return 1;
}
