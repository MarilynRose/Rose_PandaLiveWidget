//
//  ViewController.m
//  Rose_PandaLiveWidget
//
//  Created by Marilyn_Rose on 2017/5/15.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import "ViewController.h"
#import "liveRoomVC.h"
#import "Rose_playerManager.h"
#import "Rose_liveView.h"

#define LiveUrl     @"rtmp://live.hkstv.hk.lxdns.com/live/hks"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(140, 200, 100, 30) ;
    [btn setTitle:@"进入直播间" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(joinRoom) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [Rose_liveView shared].enlargeBlock = ^(){
        [self joinRoom];
    };
}

-(void)viewWillAppear:(BOOL)animated{
    if ([[Rose_playerManager sharedWithUrl:[NSURL URLWithString:LiveUrl]]isPlaying]) {
        [[Rose_liveView shared]setFrame:CGRectMake(0, 300 , 200, 200*0.75) withViewStyle:LIVEWIDGET];
        [self.view addSubview:[Rose_liveView shared]];
    }
    
}

- (void)joinRoom{
    liveRoomVC *vc = [[liveRoomVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
