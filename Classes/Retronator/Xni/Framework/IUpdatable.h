#import "Retronator.Xni.Framework.classes.h"

@protocol IUpdatable

@property (nonatomic) BOOL enabled;
@property (nonatomic, readonly) Event *enabledChanged;

- (void) updateWithGameTime:(GameTime*)gameTime;

@end