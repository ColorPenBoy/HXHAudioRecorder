//
//  RecordController.m
//  HXHAudioRecorder
//
//  Created by 张强 on 16/6/7.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

#import "RecordController.h"
#import <AVFoundation/AVFoundation.h>
#import "VoiceModel.h"

@interface RecordController ()<AVAudioRecorderDelegate>

@property (strong, nonatomic) AVAudioPlayer *player;
@property (strong, nonatomic) AVAudioRecorder *recorder;
@property (strong, nonatomic) THRecordingStopCompletionHandler completionHandler;

@end

@implementation RecordController

- (id)init {
    self = [super init];
    if (self) {
        NSString *tmpDir = NSTemporaryDirectory();
        NSString *filePath = [tmpDir stringByAppendingPathComponent:@"memo.wav"];
        NSURL *fileURL = [NSURL fileURLWithPath:filePath];
        NSLog(@"Voice Path - %@", fileURL);
        
//        NSDictionary *settings = @{
//                                   AVFormatIDKey : @(kAudioFormatAppleIMA4),
//                                   AVSampleRateKey : @44100.0f,
//                                   AVNumberOfChannelsKey : @1,
//                                   AVEncoderBitDepthHintKey : @16,
//                                   AVEncoderAudioQualityKey : @(AVAudioQualityMedium)
//                                   };
        
        
        NSDictionary *settings = @{
                                   AVFormatIDKey : @(kAudioFormatLinearPCM),
                                   AVSampleRateKey : @8000.00f,
                                   AVNumberOfChannelsKey : @1,
                                   AVLinearPCMBitDepthKey : @16,
                                   AVLinearPCMIsNonInterleaved : @NO,
                                   AVLinearPCMIsFloatKey : @NO,
                                   AVLinearPCMIsBigEndianKey : @NO
                                   };
        
        NSError *error;
        self.recorder = [[AVAudioRecorder alloc] initWithURL:fileURL settings:settings error:&error];
        if (self.recorder) {
            self.recorder.delegate = self;
            self.recorder.meteringEnabled = YES;
            [self.recorder prepareToRecord];
        } else {
            NSLog(@"Error: %@", [error localizedDescription]);
        }
    }
    
    return self;
}

- (BOOL)record {
    return [self.recorder record];
}

- (void)pause {
    [self.recorder pause];
}

- (void)stopWithCompletionHandler:(THRecordingStopCompletionHandler)handler {
    self.completionHandler = handler;
    [self.recorder stop];
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)success {
    if (self.completionHandler) {
        self.completionHandler(success);
    }
}

- (void)saveRecordingWithName:(NSString *)name completionHandler:(THRecordingSaveCompletionHandler)handler {
    
    NSTimeInterval timestamp = [NSDate timeIntervalSinceReferenceDate];
    NSString *filename = [NSString stringWithFormat:@"%@_%.0f.wav", name, timestamp];
    
    NSString *docsDir = [self documentsDirectory];
    NSString *destPath = [docsDir stringByAppendingPathComponent:filename];
    
    NSURL *srcURL = self.recorder.url;
    NSURL *destURL = [NSURL fileURLWithPath:destPath];
    
    NSError *error;
    BOOL success = [[NSFileManager defaultManager] copyItemAtURL:srcURL toURL:destURL error:&error];
    if (success) {
        handler(YES, [VoiceModel voiceWithTitle:name url:destURL]);
        [self.recorder prepareToRecord];
    } else {
        handler(NO, error);
    }
}

#pragma mark - 获取路径
- (NSString *)documentsDirectory {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    return [paths objectAtIndex:0];
}


- (NSString *)formattedCurrentTime {
    
    NSUInteger time = (NSUInteger)self.recorder.currentTime;
    NSInteger hours = (time / 3600);
    NSInteger minutes = (time / 60) % 60;
    NSInteger seconds = time % 60;
    
    NSString *format = @"%02i:%02i:%02i";
    
    return [NSString stringWithFormat:format, hours, minutes, seconds];
}

- (BOOL)playbackVoiceModel:(VoiceModel *)model {
    
    [self.player stop];
    NSError *error;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:model.url error:&error];
    
    if (self.player) {
        [self.player play];
        return YES;
    }
    return NO;
}

- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder {
    if (self.delegate) {
        [self.delegate interruptionBegan];
    }
}


@end
