#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface BlowingDetectorImpl : NSObject

+ (instancetype)sharedDetector;
- (BOOL)initialize;
- (BOOL)isDetected:(float)dt;
- (BOOL)isGranted;
- (float)averagePowerForChannel:(NSUInteger)channelNumber;
- (float)peakPowerForChannel:(NSUInteger)channelNumber;

@property (nonatomic, readonly) AVAudioRecorder *recorder;
@property (nonatomic, readonly) double lowPassResult;
@property (nonatomic) CGFloat averageThreshold;
@property (nonatomic) CGFloat requireBlowingDuration;
@property (nonatomic, readonly) CGFloat blowingDuration;

@end
