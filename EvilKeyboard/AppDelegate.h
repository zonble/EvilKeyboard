@import UIKit;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@end

@interface AppDelegate (GetApp)
- (id)getPreviousApplication;
- (void)goBack;
@end
