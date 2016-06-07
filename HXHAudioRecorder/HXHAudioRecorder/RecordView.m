//
//  RecordView.m
//  HXHAudioRecorder
//
//  Created by 张强 on 16/6/6.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

#import "RecordView.h"
#import "RecordController.h"

@implementation RecordView

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [super touchesBegan:touches withEvent:event];
    
    if (self.touchesBeginBlock) {
        self.touchesBeginBlock();
    }
    self.titleLabel.text = @"松开 发送";
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    
    if (self.touchesEndedBlock) {
        self.touchesEndedBlock();
    }
    self.titleLabel.text = @"按住 录音";
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    
    if (self.touchesCancelledBlock) {
        self.touchesCancelledBlock();
    }
    self.titleLabel.text = @"按住 录音";
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    
    UITouch  *touch=[touches anyObject];
    CGPoint  touchLocation= [touch locationInView:[touch view]];
    if (touchLocation.y < 0) {
      
    }
}

@end
