//
//  Rose_liveView.m
//  Rose_PandaLiveWidget
//
//  Created by Marilyn_Rose on 2017/5/15.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import "Rose_liveView.h"
#import "Rose_playerManager.h"
#define LiveUrl     @"rtmp://live.hkstv.hk.lxdns.com/live/hks"
@interface Rose_liveView ()

@property(nonatomic,strong)UIButton *closeBtn;

@property(nonatomic,strong)UIButton *enlargeBtn;

@property(nonatomic,strong)UIActivityIndicatorView *activityIndicator ;

@property(nonatomic,strong)NSURL *url;

@end

@implementation Rose_liveView

+(Rose_liveView *)shared{
    
    static dispatch_once_t pred = 0;
    
    __strong static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        
        _sharedObject = [[Rose_liveView alloc]init];
        
        [_sharedObject greateUI];
    });
    
    
    return _sharedObject;
}

-(void)greateUI{
    
}
-(void)setFrame:(CGRect)frame withViewStyle:(viewStyleENUM)style{
    [self setFrame:frame];
    self.backgroundColor = [UIColor blackColor];
    [[Rose_playerManager sharedWithUrl:nil].KSYPlayer.view setFrame: CGRectMake(1, 1, self.bounds.size.width-2, self.bounds.size.height-2)];
    [self addSubview:[Rose_playerManager sharedWithUrl:nil].KSYPlayer.view];
    _activityIndicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    _activityIndicator.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    [self addSubview:_activityIndicator];
    
    switch (style) {
        case NORMAL:
            
            break;
        case LIVEWIDGET:
            [self greateBtn];

            break;
            
        default:
            break;
    }
    
    if ([[Rose_playerManager sharedWithUrl:nil]isPlaying]) {
        [_activityIndicator stopAnimating];
    }else{
        [_activityIndicator startAnimating];
    }
    
   
    [Rose_playerManager sharedWithUrl:nil].startFristVideoFrameRenderedBlock = ^(){
        [_activityIndicator stopAnimating];
    };
    
    
}

-(void)setLiveURL:(NSURL *)url{
    _url=url;
    [Rose_playerManager sharedWithUrl:url];
    [[Rose_playerManager sharedWithUrl:nil] setupObservers];
}

-(void)play{
    
    if ([[Rose_playerManager sharedWithUrl:nil]isBeColsed]) {
        [[Rose_playerManager sharedWithUrl:nil]setUrl:_url];
        [[Rose_playerManager sharedWithUrl:nil] prepareToPlay];
    }else{
        [[Rose_playerManager sharedWithUrl:nil] prepareToPlay];
    }
    
    

}

-(void)reloadUrl:(NSURL *)url{
    [[Rose_playerManager sharedWithUrl:nil]reload:url];
}

-(void)greateBtn{
    _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeBtn setImage:[UIImage imageNamed:@"失败"] forState:UIControlStateNormal];
    [_closeBtn setFrame:CGRectMake(0, 0, 30, 30)];
    _closeBtn.center =CGPointMake(self.bounds.size.width, 0);
    [_closeBtn addTarget:self action:@selector(closeClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_closeBtn];
    
    _enlargeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_enlargeBtn setImage:[UIImage imageNamed:@"展开"] forState:UIControlStateNormal];
    [_enlargeBtn setFrame:CGRectMake(0, 0, 20, 20)];
    _enlargeBtn.center =CGPointMake(self.bounds.size.width-10, self.bounds.size.height-10);
    [_enlargeBtn addTarget:self action:@selector(enlargeClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_enlargeBtn];
    
    UIPanGestureRecognizer * panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                            action:@selector(doHandlePanAction:)];
    [self addGestureRecognizer:panGestureRecognizer];
}

-(void)closeClick{
    [[Rose_playerManager sharedWithUrl:nil]reset:YES];
    [[Rose_playerManager sharedWithUrl:nil]releaseObservers];
    [self removeFromSuperview];
}


//(lldb) po _KSYPlayer
///<: 0x1015031a0>
-(void)enlargeClick{
    if (self.enlargeBlock) {
        self.enlargeBlock();
    }
}

- (void) doHandlePanAction:(UIPanGestureRecognizer *)paramSender{
    
    CGPoint point = [paramSender translationInView:self.superview];
    NSLog(@"X:%f;Y:%f",point.x,point.y);
    
    paramSender.view.center = CGPointMake(paramSender.view.center.x + point.x, paramSender.view.center.y + point.y);
    [paramSender setTranslation:CGPointMake(0, 0) inView:self.superview];
    
    
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    UIView *view = [super hitTest:point withEvent:event];
    if (view == nil) {
        // 转换坐标系
        CGPoint newPoint = [_closeBtn convertPoint:point fromView:self];
        // 判断触摸点是否在button上
        if (CGRectContainsPoint(_closeBtn.bounds, newPoint)) {
            view = _closeBtn;
        }
    }
    return view;
}

@end
