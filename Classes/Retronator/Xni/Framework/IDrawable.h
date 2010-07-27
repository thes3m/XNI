#import "Retronator.Xni.Framework.classes.h"

@protocol IDrawable

@property (nonatomic) BOOL visible;
@property (nonatomic, readonly) Event *visibleChanged;

- (void) drawWithGameTime:(GameTime*)gameTime;

@end