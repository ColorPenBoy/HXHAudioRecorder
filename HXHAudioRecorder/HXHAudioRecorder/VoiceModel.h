//
//  VoiceModel.h
//  HXHAudioRecorder
//
//  Created by 张强 on 16/6/7.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoiceModel : NSObject <NSCoding>

@property (copy, nonatomic, readonly) NSString *title;
@property (strong, nonatomic, readonly) NSURL *url;
@property (copy, nonatomic, readonly) NSString *dateString;
@property (copy, nonatomic, readonly) NSString *timeString;

+ (instancetype)voiceWithTitle:(NSString *)title url:(NSURL *)url;

- (BOOL)deleteVoice;

@end
