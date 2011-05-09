#import <UIKit/UIKit.h>

#import <OpenGLES/EAGL.h>

#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>
#import <Constants.h>
#import <EmoEngine.h>
#import <EmoView.h>

@interface EmoViewController : UIViewController <EmoViewEventHandler>
{
    EAGLContext *context;
    
    BOOL animating;
    NSInteger animationFrameInterval;
    CADisplayLink *displayLink;
	
	NSMutableDictionary *touchIdMaster;
	float touchEventParamCache[MOTION_EVENT_PARAMS_SIZE];
	NSInteger nextTouchId;
	
	NSString* runtimeScript;
	NSString* mainScript;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;
@property (readwrite, copy) NSString* runtimeScript;
@property (readwrite, copy) NSString* mainScript;

- (void)onLoad;
- (void)startAnimation;
- (void)onGainedFocus;
- (void)onLostFocus;
- (void)stopAnimation;
- (void)onDispose;

@end