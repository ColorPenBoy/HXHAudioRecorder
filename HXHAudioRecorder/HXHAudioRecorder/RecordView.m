//
//  RecordView.m
//  HXHAudioRecorder
//
//  Created by 张强 on 16/6/6.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

#import "RecordView.h"
#import "RecordController.h"

@interface RecordView ()

@property (strong, nonatomic) NSTimer * timer;
@property (strong, nonatomic) RecordController * controller;
@property (strong, nonatomic) NSMutableArray * mVoiceArray;

// 记录录音开始时间
@property (strong, nonatomic) NSDate * recordTimeBegin;

// 记录录音结束时间
@property (strong, nonatomic) NSDate * recordTimeEnd;

@end

static NSString * const VOICE_ARCHIVE = @"voice.archive";


@implementation RecordView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self recorderConfiger];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    [self recorderConfiger];
}

- (void)recorderConfiger {
    self.controller = [[RecordController alloc] init];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"🎈 touches Began!!");
    [super touchesBegan:touches withEvent:event];
    self.titleLabel.text = @"松开 发送";
    self.recordTimeBegin = [NSDate date];
    
    
    [self startTimer];
    [self.controller record];
    
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"🎈 touches Ended!!");

    [super touchesEnded:touches withEvent:event];
    self.titleLabel.text = @"按住 录音";
    
    [self stopRecord];
    self.recordTimeEnd = [NSDate date];

}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"🎈 touches Cancelled!!");

    [super touchesCancelled:touches withEvent:event];
    self.titleLabel.text = @"按住 录音";
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"🎈 touches Moved!!");

    [super touchesMoved:touches withEvent:event];
    
    UITouch  *touch=[touches anyObject];
    CGPoint  touchLocation= [touch locationInView:[touch view]];
    if (touchLocation.y < 0) {
      
    }
}

// 播放录音
- (void)playVoiceWithModel:(VoiceModel *)model {

    [self.controller playbackVoiceModel:model];
}


#pragma mark - Setter && Getter
- (NSMutableArray *)mVoiceArray {
    if (!_mVoiceArray) {
        
        NSData *data = [NSData dataWithContentsOfURL:[self archiveURL]];
        if (!data) {
            _mVoiceArray = [NSMutableArray array];
        } else {
            _mVoiceArray = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
    }
    return _mVoiceArray;
}

#pragma mark - private method
- (void)startTimer {
    [self.timer invalidate];
    self.timer = [NSTimer timerWithTimeInterval:0.5
                                         target:self
                                       selector:@selector(updateTimeDisplay)
                                       userInfo:nil
                                        repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)updateTimeDisplay {
    self.timeLabel.text = self.controller.formattedCurrentTime;
}

- (void)stopRecord {
    
    [self.controller stopWithCompletionHandler:^(BOOL result) {
        double delayInSeconds = 0.01;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t) (delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^{
            NSLog(@"开始时间 - %@", self.recordTimeBegin);
            NSLog(@"结束时间 - %@",self.recordTimeEnd);
            
            if ([self.recordTimeEnd timeIntervalSinceDate:self.recordTimeBegin] > 0) {
                [self saveVoice];
            }
        });
    }];
}

- (void)saveVoice {
    
    NSTimeInterval date = [[NSDate date] timeIntervalSince1970];
    NSString * fileName = [NSString stringWithFormat:@"FileName - %@",@(date)];
    
    [self.controller saveRecordingWithName:fileName completionHandler:^(BOOL success, id object) {
        if (success) {
            [self.mVoiceArray addObject:object];
            [self saveVoices];
            // tableView reloadData
            if (self.recordSuccessBlock) {
                self.recordSuccessBlock(self.mVoiceArray);
            }
            
        } else {
            NSLog(@"Error saving file: %@", [object localizedDescription]);
        }
    }];
}

#pragma mark - Voice Archiving
- (void)saveVoices {
    NSData *fileData = [NSKeyedArchiver archivedDataWithRootObject:self.mVoiceArray];
    [fileData writeToURL:[self archiveURL] atomically:YES];
}

- (NSURL *)archiveURL {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [paths objectAtIndex:0];
    NSString *archivePath = [docsDir stringByAppendingPathComponent:VOICE_ARCHIVE];
    NSLog(@"🎈 Path - %@",archivePath);
    return [NSURL fileURLWithPath:archivePath];
}

@end
