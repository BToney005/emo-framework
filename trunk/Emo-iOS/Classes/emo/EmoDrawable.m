#include <EmoDrawable.h>
#include <squirrel.h>
#include <Constants.h>
#include <VmFunc.h>
#include <EmoEngine.h>
#include <EmoEngine_glue.h>

extern EmoEngine* engine;

@implementation EmoAnimationFrame
@synthesize name;
@synthesize start, count, loop, interval;
@synthesize lastOnAnimationInterval;
- (id)init {
    self = [super init];
    if (self != nil) {
        start      = 0;
        count      = 1;
        interval   = 0;
        loop       = 0;
        currentLoopCount = 0;
        currentCount = 0;
        lastOnAnimationInterval = [engine uptime];
    }
    return self;
}

-(NSInteger)getNextIndex:(NSInteger)frameCount withIndex:(NSInteger)currentIndex {
	
	if (currentLoopCount > loop) {
		return currentIndex;
	}
	
	currentCount++;
	
	if (currentCount >= count) {
		currentCount = 0;
		if (loop > 0) {
			currentLoopCount++;
		}
	}
	
	if (currentCount + start >= frameCount) {
		currentCount = 0;
	}
	
	int nextIndex = currentCount + start;
	
	return nextIndex;
}
-(NSTimeInterval)getLastOnAnimationDelta:(NSTimeInterval)uptime {
	return (uptime - lastOnAnimationInterval) * 1000;
}
@end


@interface EmoDrawable (PrivateMethods)
-(NSInteger)tex_coord_frame_startX;
-(NSInteger) tex_coord_frame_startY;
-(float)getTexCoordStartX;
-(float)getTexCoordEndX;
-(float)getTexCoordStartY;
-(float)getTexCoordEndY;
-(void)garbage;
@end

@implementation EmoDrawable
@synthesize name;
@synthesize x, y, z;
@synthesize width, height;
@synthesize hasTexture, hasSheet;
@synthesize texture;
@synthesize frameCount, frame_index, border, margin;

-(BOOL)onDrawFrame:(NSTimeInterval)dt withStage:(EmoStage*)stage {
    if (!loaded) return FALSE;
	
	if (frameIndexChanged) {
		frame_index = nextFrameIndex;
		frameIndexChanged = FALSE;
	}

	if (animating && currentAnimation != nil) {
		EmoAnimationFrame* animation = currentAnimation;
		NSTimeInterval delta = [animation getLastOnAnimationDelta:[engine uptime]];
		if (delta >= animation.interval) {
			[self setFrameIndex:[animation getNextIndex:frameCount withIndex:frame_index]];
			animation.lastOnAnimationInterval = [engine uptime];
		}
	}
	
	if (frames_vbos[frame_index] <= 0) {
		[self bindVertex];
	}
	
    glMatrixMode (GL_MODELVIEW);
    glLoadIdentity (); 
	
    // update colors
    glColor4f(param_color[0], param_color[1], param_color[2], param_color[3]);
	
    // update position
    glTranslatef(x, y, z);
	
    // update width and height
    glScalef(width, height, 1);
	
    // rotate
    glTranslatef(param_rotate[1], param_rotate[2], 0);
    if (param_rotate[3] == AXIS_X) {
        glRotatef(param_rotate[0], 1, 0, 0);
    } else if (param_rotate[3] == AXIS_Y) {
        glRotatef(param_rotate[0], 0, 1, 0);
    } else {
        glRotatef(param_rotate[0], 0, 0, 1);
    }
    glTranslatef(-param_rotate[1], -param_rotate[2], 0);
	
    // scale
    glTranslatef(param_scale[2], param_scale[3], 0);
    glScalef(param_scale[0], param_scale[1], 1);
    glTranslatef(-param_scale[2], -param_scale[3], 0);
	
    // bind vertex positions
    glBindBuffer(GL_ARRAY_BUFFER, [stage getPositionPointer]);
    glVertexPointer(3, GL_FLOAT, 0, 0);
	
	// bind a texture
    if (hasTexture) {
		glEnable(GL_TEXTURE_2D);
        glBindTexture(GL_TEXTURE_2D, texture.textureId);
	} else {
		glDisable(GL_TEXTURE_2D);
	}
	
    // bind texture coords
    glBindBuffer(GL_ARRAY_BUFFER, frames_vbos[frame_index]);
    glTexCoordPointer(2, GL_FLOAT, 0, 0);
	
    // bind indices
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, [stage getIndicePointer]);
	
    // draw sprite
    glDrawElements(GL_TRIANGLE_FAN, 4, GL_UNSIGNED_SHORT, 0);
	
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
	glBindBuffer(GL_ARRAY_BUFFER, 0);
	glBindTexture(GL_TEXTURE_2D, 0);
	
	return TRUE;
}
-(void)initDrawable {
	x = 0;
	y = 0;
	z = 0;
	width  = 0;
	height = 0;
	name = nil;

	hasTexture = FALSE;
	loaded     = FALSE;
	hasSheet   = FALSE;
	animating  = FALSE;

	// color param RGBA
    param_color[0] = 1.0f;
    param_color[1] = 1.0f;
    param_color[2] = 1.0f;
    param_color[3] = 1.0f;
	
    // rotate angle, center x, center y, axis
    param_rotate[0] = 0;
    param_rotate[1] = 0;
    param_rotate[2] = 0;
    param_rotate[3] = AXIS_Z;
	
    // scale param x, y, center x, center y
    param_scale[0] = 1;
    param_scale[1] = 1;
    param_scale[2] = 0;
    param_scale[3] = 0;
	
	frameCount  = 1;
    frame_index = 0;
    border      = 0;
    margin      = 0;
	
	animations        = [[NSMutableDictionary alloc]init];
	nextFrameIndex    = 0;
	frameIndexChanged = FALSE;
	currentAnimation  = nil;
}

-(NSInteger)tex_coord_frame_startX {
	int xcount = (int)round((texture.width - (margin * 2) + border) / (float)(width  + border));
	int xindex = frame_index % xcount;
	return ((border + width) * xindex) + margin;
}

-(NSInteger) tex_coord_frame_startY {
	int xcount = (int)round((texture.width - (margin * 2) + border) / (float)(width  + border));
	int ycount = (int)round((texture.height - (margin * 2) + border) / (float)(height + border));
	int yindex = ycount - (frame_index / xcount) - 1;
	return ((border + height) * yindex) + margin;
}

-(float)getTexCoordStartX {
	if (hasSheet) {
        return [self tex_coord_frame_startX] / (float)texture.glWidth;
    } else {
        return 0;
    }
}

-(float)getTexCoordEndX {
	if (!hasTexture) {
		return 1;
    } else if (hasSheet) {
        return (float)([self tex_coord_frame_startX] + width) / (float)texture.glWidth;
    } else {
        return (float)texture.width / (float)texture.glWidth;
    }
}

-(float)getTexCoordStartY {
	if (!hasTexture) {
		return 1;
	} else if (hasSheet) {
        return (float)([self tex_coord_frame_startY] + height) / (float)texture.glHeight;
    } else {
        return (float)texture.height / (float)texture.glHeight;
    }
}

-(float)getTexCoordEndY {
    if (hasSheet) {
        return [self tex_coord_frame_startY] / (float)texture.glHeight;
    } else {
        return 0;
    }
}

-(BOOL)bindVertex {
    clearGLErrors("EmoDrawable:bindVertex");
	
    vertex_tex_coords[0] = [self getTexCoordStartX];
    vertex_tex_coords[1] = [self getTexCoordStartY];
	
    vertex_tex_coords[2] = [self getTexCoordStartX];
    vertex_tex_coords[3] = [self getTexCoordEndY];
	
    vertex_tex_coords[4] = [self getTexCoordEndX];
    vertex_tex_coords[5] = [self getTexCoordEndY];
	
    vertex_tex_coords[6] = [self getTexCoordEndX];
    vertex_tex_coords[7] = [self getTexCoordStartY];
	
	if (frames_vbos[frame_index] == 0) {
		glGenBuffers (1, &frames_vbos[frame_index]);
	}
	
	glEnable(GL_TEXTURE_2D);
    glBindBuffer(GL_ARRAY_BUFFER, frames_vbos[frame_index]);
    glBufferData(GL_ARRAY_BUFFER, sizeof(float) * 8, vertex_tex_coords, GL_STATIC_DRAW);
	
	printGLErrors("Could not create OpenGL vertex");
	
    if (hasTexture && !texture.loaded) {
		glBindTexture(GL_TEXTURE_2D, texture.textureId);
		
		glPixelStorei(GL_UNPACK_ALIGNMENT, 1);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

        if (texture.hasAlpha) {
            GLubyte* holder = (GLubyte*)malloc(sizeof(GLubyte) * texture.glWidth * texture.glHeight * 4);
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, texture.glWidth, texture.glHeight, 0, GL_RGBA, GL_UNSIGNED_BYTE, holder);
            glTexSubImage2D(GL_TEXTURE_2D, 0, 
							0, 0, texture.width, texture.height, GL_RGBA, GL_UNSIGNED_BYTE, texture.data);
            free(holder);
        } else {
            GLubyte* holder = (GLubyte*)malloc(sizeof(GLubyte) * texture.glWidth * texture.glHeight * 3);
            glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, texture.glWidth, texture.glHeight, 0, GL_RGB, GL_UNSIGNED_BYTE, holder);
            glTexSubImage2D(GL_TEXTURE_2D, 0, 
							0, 0, texture.width, texture.height, GL_RGB, GL_UNSIGNED_BYTE, texture.data);
            free(holder);
        }
		glBindTexture(GL_TEXTURE_2D, 0);
		
		texture.loaded = TRUE;
        printGLErrors("Could not bind OpenGL textures");
    }
	
	loaded = TRUE;
	
	return TRUE;
}
-(void)updateKey:(char*)key {
	double uptime = [engine uptime];
	int uptimes = (int)floor(uptime);
	int uptimem = (int)floor((uptime - uptimes) * 1000);
    sprintf(key, "%d%d-%d", uptimes, uptimem, frames_vbos[frame_index]);
}
-(void)setScale:(NSInteger)index withValue:(float)value {
	param_scale[index] = value;
}
-(void)setRotate:(NSInteger)index withValue:(float)value {
	param_rotate[index] = value;
}
-(void)setColor:(NSInteger)index withValue:(float)value {
	param_color[index] = value;
}
-(float)getColor:(NSInteger)index {
	return param_color[index];
}
-(float)getScaleX {
	return param_scale[0];
}
-(float)getScaleY {
	return param_scale[1];
}
-(float)getAngle {
	return param_rotate[0];
}

-(void)createTextureBuffer {
    frames_vbos = (GLuint *)malloc(sizeof(GLuint) * frameCount);
	
	for (int i = 0; i < frameCount; i++) {
		frames_vbos[i] = 0;
	}
	glGenBuffers (1, &frames_vbos[frame_index]);
}
-(void)doUnload {
	if (hasTexture) {
		[texture doUnload];
		[texture release];
		hasTexture = FALSE;
	}
	for (int i = 0; i < frameCount; i++) {
		if (frames_vbos[i] > 0) {
			glDeleteBuffers(1, &frames_vbos[i]);
		}
	}
	frameCount  = 1;
	frame_index = 0;
	free(frames_vbos);
	
	[self deleteAnimations];
}
-(BOOL)setFrameIndex:(NSInteger)index {
	if (index < 0 || frameCount <= index) {
		return FALSE;
	}
	nextFrameIndex = index;
	frameIndexChanged = TRUE;
	return TRUE;
}
-(BOOL)pauseAt:(NSInteger)index {
	if (![self setFrameIndex:index]) {
		return FALSE;
	}
	animating = FALSE;
	
	return TRUE;
}
-(void)pause {
	animating = FALSE;
}
-(void)stop {
	animating = FALSE;
	[self setFrameIndex:0];
}

-(void)addAnimation:(EmoAnimationFrame*)animation {
	[self deleteAnimation:animation.name];
	[animations setObject:animation forKey:animation.name];
}

-(BOOL)setAnimation:(NSString*)_name {
	if ([self getAnimation:_name] == nil) {
		animationName = nil;
		return FALSE;
	} else {
		animationName = _name;
	}
	return TRUE;
}

-(EmoAnimationFrame*)getAnimation:(NSString*)_name {
	return [animations objectForKey:_name];
}

-(BOOL)deleteAnimation:(NSString*)_name {
	EmoAnimationFrame* animation = [self getAnimation:_name];

	if (animation == nil) return FALSE;
	
	[animation release];
	[animations removeObjectForKey:_name];
	
	return TRUE;
}

-(void)deleteAnimations {
	for (NSString* key in animations) {
		[[animations objectForKey:key] release];
	}
	[animations removeAllObjects];
}

-(BOOL)enableAnimation:(BOOL)enable {
	animating = enable;
	
	currentAnimation = nil;
	
	if (enable) {
		if (animationName == nil) return FALSE;
		EmoAnimationFrame* animation = [self getAnimation:animationName];
		if (animation == nil) {
			return FALSE;
		} else {
			currentAnimation = animation;
			animation.lastOnAnimationInterval = [engine uptime];
		}
	}
	return TRUE;
}
-(void)garbage {
	int retainCount = [name retainCount];
	for (int i = 0; i < retainCount; i++) {
		[name release];
	}
	name = nil;
}
-(void)dealloc {
	[animations release];
	[self garbage];
	[super dealloc];
}
@end
