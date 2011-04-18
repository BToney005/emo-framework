#include <android_native_app_glue.h>

#include "emo/Runtime.h"
#include "emo/Engine.h"

emo::Engine* g_engine;

void android_main(struct android_app* state) {

    app_dummy();

    emo::Engine* engine = new emo::Engine();
    g_engine = engine;

    state->userData = engine;
    state->onAppCmd = app_handle_cmd;
    state->onInputEvent = app_handle_input;
    engine->setApp(state);

    engine->onInitEngine();

    while (1) {
        int ident;
        int events;
        struct android_poll_source* source;

        while ((ident=ALooper_pollAll(engine->isAnimating(), NULL, &events,
                (void**)&source)) >= 0) {

            // Process this event.
            if (source != NULL) {
                source->process(state, source);
            }

            // Process the user queue.
            if (ident == LOOPER_ID_USER) {
                if (engine->getSensorEventQueue() != NULL) {
                    ASensorEvent event;
                    while (ASensorEventQueue_getEvents(
                            engine->getSensorEventQueue(), &event, 1) > 0) {
                        engine->onSensorEvent(&event);
                    }
                }
            }

            if (state->destroyRequested != 0) {
                engine->onDispose();
                engine->onTerminateDisplay();
                delete engine;
                return;
            }
        }

        if (engine->isAnimating()) {
            engine->onDrawFrame();
        }
    }
}
