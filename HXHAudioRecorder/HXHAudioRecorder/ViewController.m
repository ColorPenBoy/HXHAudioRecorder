//
//  ViewController.m
//  HXHAudioRecorder
//
//  Created by 张强 on 16/6/6.
//  Copyright © 2016年 ColorPen. All rights reserved.
//

#import "ViewController.h"
#import "RecordView.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet RecordView *recordView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.mainTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CELLID"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID" forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"录音 - %@",@(indexPath.row)];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"点击播放录音 - %@",@(indexPath.row));
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
