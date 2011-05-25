local stage = emo.Stage();

/*
 * This example shows single sprite that rotates and scales on touch-down event
 */
class Main {

    text = emo.TextSprite("font_16x16.png", 16, 16, 
		" !\"c*%#'{}@+,=./0123456789:;[|]?&ABCDEFGHIJKLMNOPQRSQTVWXYZ");

	/*
	 * Called when this class is loaded
	 */
    function onLoad() {
        print("onLoad"); 
				
		text.setText("HELLO, WORLD!");
		text.scale(4, 4);
		
		// move sprite to the center of the screen
		local x = (stage.getWindowWidth()  - text.getScaledWidth())  / 2;
		local y = (stage.getWindowHeight() - text.getScaledHeight()) / 2;
		
		print(format("%dx%d", stage.getWindowHeight(), x, y));
		text.move(x, y);

		// load sprite to the screen
        text.load();
    }

	/*
	 * Called when the app has gained focus
	 */
    function onGainedFocus() {
        print("onGainedFocus");
    }

	/*
	 * Called when the app has lost focus
	 */
    function onLostFocus() {
        print("onLostFocus"); 
    }

	/*
	 * Called when the class ends
	 */
    function onDispose() {
        print("onDispose");
        
        // remove sprite from the screen
        text.remove();
    }

	/*
	 * touch event
	 */
	function onMotionEvent(mevent) {
		if (mevent.getAction() == MOTION_EVENT_ACTION_DOWN) {

		}
	}
}

function emo::onLoad() {
    stage.load(Main());
}
