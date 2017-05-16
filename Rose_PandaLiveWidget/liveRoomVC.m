//
//  liveRoomVC.m
//  Rose_PandaLiveWidget
//
//  Created by Marilyn_Rose on 2017/5/16.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import "liveRoomVC.h"
#import "Rose_liveView.h"

#define LiveUrl     @"rtmp://live.hkstv.hk.lxdns.com/live/hks"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHigth [UIScreen mainScreen].bounds.size.height
@interface liveRoomVC ()

@end

@implementation liveRoomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

    
    [[Rose_liveView shared]setLiveURL:[NSURL URLWithString:LiveUrl]];
    [[Rose_liveView shared]setFrame:CGRectMake(0, 64, kWidth, kWidth*0.75) withViewStyle:NORMAL];
    [self.view addSubview: [Rose_liveView shared]];
    [[Rose_liveView shared]play];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
