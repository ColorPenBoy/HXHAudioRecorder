//
//  RecordView.h
//  HXHAudioRecorder
//
//  Created by 张强 on 16/6/6.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^RecordSuccessBlock)(NSArray * voicesArray);

@class VoiceModel;
@interface RecordView : UIView

@property (weak, nonatomic) IBOutlet UILabel * timeLabel;

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;

@property (nonatomic, copy) RecordSuccessBlock recordSuccessBlock;

- (void)playVoiceWithModel:(VoiceModel *)model;

@end
