#import "BlowingDetectorImpl.h"

@implementation BlowingDetectorImpl

+ (instancetype)sharedDetector {
    static BlowingDetectorImpl *sharedDetector = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedDetector = [[self alloc] init];
    });
    return sharedDetector;
}


- (BOOL)initialize
{
    self = [super init];
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord 
                  withOptions:AVAudioSessionCategoryOptionDefaultToSpeaker 
                        error:nil];
    [audioSession setActive:YES error:nil];
    
    NSURL *url = [NSURL URLWithString:@"/dev/null"];
    NSDictionary<NSString *, NSNumber *> *settings = @{
                                                       AVSampleRateKey : @(44100.0), 
                                                       AVFormatIDKey : @(kAudioFormatAppleLossless),
                                                       AVNumberOfChannelsKey : @(1),
                                                       AVEncoderAudioQualityKey : @(AVAudioQualityMax)
                                                       };
    NSError *error;
    _recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
    if (self.recorder != nil) {
        [self.recorder prepareToRecord];
        self.recorder.meteringEnabled = YES;
        [self.recorder record];
    }
    _averageThreshold = -5;
    _blowingDuration = 0;
    _requireBlowingDuration = 0;
    return self;
}

- (BOOL)isDetected:(float)dt
{
    [self.recorder updateMeters];
    float average = [self averagePowerForChannel:0];
    if (average > self.averageThreshold) {
        _blowingDuration += dt;
        if (self.blowingDuration >= self.requireBlowingDuration) {
            return YES;
        }
    } else {
        _blowingDuration = 0;
    }
    return NO;
}

- (float)averagePowerForChannel:(NSUInteger)channelNumber
{
    [self.recorder updateMeters];
    float average = [self.recorder averagePowerForChannel:0];
    return average;
}

@end
