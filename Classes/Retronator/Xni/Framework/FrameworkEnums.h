#import <UIKit/UIKit.h>

typedef enum {
	DisplayOrientationDefault = UIInterfaceOrientationMaskAll,
	DisplayOrientationLandscapeLeft = UIInterfaceOrientationMaskLandscapeLeft,
	DisplayOrientationLandscapeRight = UIInterfaceOrientationMaskLandscapeRight,
	DisplayOrientationPortrait = UIInterfaceOrientationMaskPortrait,
    DisplayOrientationPortraitUpsideDown = UIInterfaceOrientationMaskPortraitUpsideDown
} DisplayOrientation;