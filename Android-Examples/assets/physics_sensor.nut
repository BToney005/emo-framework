emo.Runtime.import("physics.nut");

local stage = emo.Stage();
local event = emo.Event();
local physics = emo.Physics();

local gravity = emo.Vec2(0, 10);
local world   = emo.physics.World(gravity, true);

const FPS = 60.0;
const WALL_WIDTH = 10;

class Main {

    sprite = emo.Sprite("ball.png");

	/*
	 * Called when this class is loaded
	 */
    function onLoad() {
        print("onLoad"); 

		local wall1  = emo.Rectangle();
		local wall2  = emo.Rectangle();
		local wall3  = emo.Rectangle();
		local wall4  = emo.Rectangle();

		wall1.setSize(stage.getWindowWidth(), WALL_WIDTH);
		wall2.setSize(stage.getWindowWidth(), WALL_WIDTH);
		wall3.setSize(WALL_WIDTH, stage.getWindowHeight());
		wall4.setSize(WALL_WIDTH, stage.getWindowHeight());
		
		wall1.move(0, 0);
		wall2.move(0, stage.getWindowHeight() - wall2.getHeight());
		wall3.move(0, 0);
		wall4.move(stage.getWindowWidth() - wall4.getWidth(), 0);
		
		physics.createStaticSprite(world, wall1);
		physics.createStaticSprite(world, wall2);
		physics.createStaticSprite(world, wall3);
		physics.createStaticSprite(world, wall4);
		
		// move sprite to the center of the screen
		local x = (stage.getWindowWidth()  - sprite.getWidth())  / 2;
		local y = (stage.getWindowHeight() - sprite.getHeight()) / 2;
		
		sprite.move(x, y);

		local bodyDef = emo.physics.BodyDef();
		bodyDef.allowSleep = false;

		local fixture = emo.physics.FixtureDef();
		fixture.density  = 1.0;
		fixture.friction = 0.3;
		fixture.restitution = 0.3;
		
		physics.createDynamicCircleSprite(world, sprite, sprite.getWidth() * 0.5, fixture, bodyDef);
		
		// load sprite to the screen
        sprite.load();
		wall1.load();
		wall2.load();
		wall3.load();
		wall4.load();
		
		event.registerSensors(SENSOR_TYPE_ACCELEROMETER);
		
		// Set OnDrawCallback interval (millisecond)
		event.enableOnDrawCallback(1000.0 / FPS);
    }

	/*
	 * Called when the app has gained focus
	 */
    function onGainedFocus() {
        print("onGainedFocus");
		event.enableSensor(SENSOR_TYPE_ACCELEROMETER, 100);
    }

	/*
	 * Called when the app has lost focus
	 */
    function onLostFocus() {
        print("onLostFocus"); 
		event.disableSensor(SENSOR_TYPE_ACCELEROMETER);
    }

	/*
	 * Called when this class will be disposed
	 */
    function onDispose() {
        print("onDispose");
        
        // remove sprite from the screen
        sprite.remove();
    }

    function onDrawFrame(dt) {
		// step the world (second)
		world.step(1.0 / FPS, 6, 2);
		world.clearForces();
	}
	
	/*
	 * touch event
	 */
	function onSensorEvent(sevent) {
		if (sevent.getType() == SENSOR_TYPE_ACCELEROMETER) {
			gravity.x = sevent.getAccelerationX() * 10;
			gravity.y = -(sevent.getAccelerationY() * 10);
			world.setGravity(gravity);
		}
	}
}

function emo::onLoad() {
    stage.load(Main());
}