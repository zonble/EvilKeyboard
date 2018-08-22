@import Foundation;

extern NSString *const DetectedAppsManagerDidAddAppNotification;

@interface DetectedApp : NSObject
@property (strong, nonatomic) NSString *bundleID;
@property (strong, nonatomic) NSDate *date;
@end

@interface DetectedAppsManager : NSObject

+ (instancetype)sharedManager;
- (void)addApp:(NSString *)bundleID;
@property (strong, nonatomic)NSArray <DetectedApp *> *apps;
@end

