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
    return self;
}

- (BOOL)isDetected
{
    [self.recorder updateMeters];
    float average = [self averagePowerForChannel:0];
    if (average > -1) {
        return YES;
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
