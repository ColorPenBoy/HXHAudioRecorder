//
//  RecordController.h
//  HXHAudioRecorder
//
//  Created by 张强 on 16/6/7.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol RecorderControllerDelegate <NSObject>
- (void)interruptionBegan;
@end

typedef void(^THRecordingStopCompletionHandler)(BOOL);
typedef void(^THRecordingSaveCompletionHandler)(BOOL, id);

@class VoiceModel;
@interface RecordController : NSObject

@property (copy, nonatomic, readonly) NSString *formattedCurrentTime;
@property (weak, nonatomic) id <RecorderControllerDelegate> delegate;

// 录音
- (BOOL)record;

// 暂停
- (void)pause;

// 停止
- (void)stopWithCompletionHandler:(THRecordingStopCompletionHandler)handler;

// 保存
- (void)saveRecordingWithName:(NSString *)name
            completionHandler:(THRecordingSaveCompletionHandler)handler;

// 播放
- (BOOL)playbackVoiceModel:(VoiceModel *)model;

@end
