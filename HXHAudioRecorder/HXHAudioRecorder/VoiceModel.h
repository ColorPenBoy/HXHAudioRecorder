//
//  VoiceModel.h
//  HXHAudioRecorder
//
//  Created by 张强 on 16/6/7.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoiceModel : NSObject <NSCoding>

// 存储路径
@property (strong, nonatomic, readonly) NSURL *url;

// 名字
@property (copy, nonatomic, readonly) NSString *title;

// 数据
@property (copy, nonatomic, readonly) NSString *dateString;

// 时长
@property (copy, nonatomic, readonly) NSString *timeString;

/*!
 *  构造函数
 *  @param title 名字
 *  @param url 存储路径
 */
+ (instancetype)voiceWithTitle:(NSString *)title url:(NSURL *)url;

/*!
 *  删除录音
 *  @return 删除是否成功
 */
- (BOOL)deleteVoice;

@end
