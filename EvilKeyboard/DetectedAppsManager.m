#import "DetectedAppsManager.h"

NSString *const DetectedAppsManagerDidAddAppNotification = @"DetectedAppsManagerDidAddAppNotification";

@implementation DetectedApp
@end

@interface DetectedAppsManager ()
@property (strong, nonatomic) NSMutableArray <DetectedApp *> *theApps;
@end

@implementation DetectedAppsManager

+ (instancetype)sharedManager
{
	static dispatch_once_t onceToken;
	static DetectedAppsManager *manager;
	dispatch_once(&onceToken, ^{
		manager = [[DetectedAppsManager alloc] init];
	});
	return manager;
}

- (instancetype)init
{
	self = [super init];
	if (self) {
		self.theApps = [[NSMutableArray alloc] init];
	}
	return self;
}

- (void)addApp:(NSString *)bundleID
{
	DetectedApp *app = [[DetectedApp alloc] init];
	app.bundleID = bundleID;
	app.date = [NSDate date];
	[self.theApps addObject:app];
	[[NSNotificationCenter defaultCenter] postNotificationName:DetectedAppsManagerDidAddAppNotification object:self];
}

- (NSArray<DetectedApp *> *)apps
{
	return [self.theApps copy];
}

@end
