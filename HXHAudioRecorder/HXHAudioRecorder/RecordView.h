//
//  RecordView.h
//  HXHAudioRecorder
//
//  Created by 张强 on 16/6/6.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^touchesBeginBlock)();
typedef void (^touchesEndedBlock)();
typedef void (^touchesCancelledBlock)();

@interface RecordView : UIView

@property (weak, nonatomic) IBOutlet UILabel * titleLabel;

@property (nonatomic, copy) touchesBeginBlock touchesBeginBlock;
@property (nonatomic, copy) touchesEndedBlock touchesEndedBlock;
@property (nonatomic, copy) touchesCancelledBlock touchesCancelledBlock;

@end
