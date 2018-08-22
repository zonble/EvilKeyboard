#import "AppDelegate.h"
#import "ViewController.h"
#import "DetectedAppsManager.h"

@interface UISystemNavigationAction : NSObject
{
}

@property (nonatomic, readonly) NSArray *destinations;

- (long long)UIActionType;
- (id)URLForDestination:(unsigned long long)arg1;
- (id)bundleIdForDestination:(unsigned long long)arg1;
- (id)keyDescriptionForSetting:(unsigned long long)arg1;
- (bool)sendResponseForDestination:(unsigned long long)arg1;
- (id)titleForDestination:(unsigned long long)arg1;
- (id)valueDescriptionForFlag:(long long)arg1 object:(id)arg2 ofSetting:(unsigned long long)arg3;
@end

@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
	ViewController *controller = [[ViewController alloc] initWithStyle:UITableViewStylePlain];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:controller];
	UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
	self.window = window;
	window.rootViewController = navController;
	[window makeKeyAndVisible];
	return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options
{
	UISystemNavigationAction *action = [self getPreviousApplication];
	if (action != nil) {
		NSInteger count = action.destinations.count;
		NSInteger lastIndex = 0;
		if (count > 0) {
			lastIndex = count - 1;
			NSLog(@"bundleIdForDestination:%@", [action bundleIdForDestination:lastIndex]);
			NSLog(@"URLForDestination:%@", [action URLForDestination:lastIndex]);
			NSLog(@"keyDescriptionForSetting:%@", [action keyDescriptionForSetting:lastIndex]);
			NSLog(@"titleForDestination:%@", [action titleForDestination:lastIndex]);

			[[DetectedAppsManager sharedManager] addApp:[action bundleIdForDestination:lastIndex]];
		}
	}
	return YES;
}

@end


@implementation AppDelegate (GetApp)
- (id)getPreviousApplication
{
	id systemNavigationAction = [[UIApplication sharedApplication] valueForKey:@"systemNavigationAction"];
	if ([systemNavigationAction respondsToSelector:@selector(destinations)]) {
		return systemNavigationAction;
	}
	return nil;
}

- (void)goBack
{
	UISystemNavigationAction *action = [self getPreviousApplication];
	if (action != nil) {
		NSInteger count = action.destinations.count;
		NSInteger lastIndex = 0;
		if (count > 0) {
			lastIndex = count - 1;
			[action sendResponseForDestination:lastIndex];
		}
	}
}

@end

