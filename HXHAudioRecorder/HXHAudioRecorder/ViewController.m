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

static NSString * const VOICE_CELL = @"voiceCell";
static NSString * const VOICE_ARCHIVE = @"voice.archive";

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet RecordView *recordView;

@property (strong, nonatomic) NSMutableArray * mVoiceArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mVoiceArray = [NSMutableArray array];
    
    [self.mainTableView registerNib:[UINib nibWithNibName:@"VoiceCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:VOICE_CELL];

}


#pragma mark - UITabelViewDataSource && UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
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
}

#pragma mark - Voice Archiving
- (void)saveMemos {
    NSData *fileData = [NSKeyedArchiver archivedDataWithRootObject:self.mVoiceArray];
    [fileData writeToURL:[self archiveURL] atomically:YES];
}

- (NSURL *)archiveURL {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docsDir = [paths objectAtIndex:0];
    NSString *archivePath = [docsDir stringByAppendingPathComponent:VOICE_ARCHIVE];
    return [NSURL fileURLWithPath:archivePath];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
