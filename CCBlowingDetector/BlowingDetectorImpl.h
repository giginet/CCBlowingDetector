#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface BlowingDetectorImpl : NSObject

+ (instancetype)sharedDetector;
- (BOOL)initialize;
- (BOOL)isDetected;
- (float)averagePowerForChannel:(NSUInteger)channelNumber;

@property (nonatomic, readonly) AVAudioRecorder *recorder;
@property (nonatomic, readonly) double lowPassResult;

@end
