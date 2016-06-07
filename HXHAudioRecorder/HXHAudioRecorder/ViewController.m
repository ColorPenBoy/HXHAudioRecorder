//
//  ViewController.m
//  HXHAudioRecorder
//
//  Created by 张强 on 16/6/6.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

#import "ViewController.h"
#import "RecordView.h"
#import "VoiceCell.h"
#import "VoiceModel.h"

static NSString * const VOICE_CELL = @"voiceCell";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet RecordView *recordView;

@property (copy, nonatomic) NSMutableArray * dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self.mainTableView registerNib:[UINib nibWithNibName:@"VoiceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:VOICE_CELL];

    self.recordView.recordSuccessBlock = ^(NSArray * voicesArray){
        self.dataArray = [NSMutableArray arrayWithArray:voicesArray];
        [self.mainTableView reloadData];
    };
}


#pragma mark - UITabelViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    VoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:VOICE_CELL forIndexPath:indexPath];
    
    cell.leftLabel.text = [NSString stringWithFormat:@"录音 - %@",@(indexPath.row)];
    cell.centerLabel.text = @"";
    cell.rightLabel.text = @"";
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击播放录音 - %@",@(indexPath.row));
    VoiceModel * model = self.dataArray[indexPath.row];
    [self.recordView playVoiceWithModel:model];
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
