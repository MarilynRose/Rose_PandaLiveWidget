//
//  Rose_playerManager.m
//  Rose_PandaLiveWidget
//
//  Created by Marilyn_Rose on 2017/5/15.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

#import "Rose_playerManager.h"

@interface Rose_playerManager ()

@property(nonatomic,strong)NSURL *liveURL;

@property(nonatomic)BOOL          isBeColsed;
@end

@implementation Rose_playerManager


+(Rose_playerManager *)sharedWithUrl:(NSURL *)url{
    static dispatch_once_t pred = 0;
    
    __strong static id _sharedObject = nil;
    
    dispatch_once(&pred, ^{
        _sharedObject = [[Rose_playerManager alloc] init];
        [_sharedObject initKSYMoviewPlayerWithUrl:url];
    });
    
    
    return _sharedObject;
}

-(void)initKSYMoviewPlayerWithUrl:(NSURL *)url {
    self.KSYPlayer = [[KSYMoviePlayerController alloc] initWithContentURL:url];
    self.isBeColsed = NO;
}

- (void)reload:(NSURL *)aUrl{
    
    _liveURL = aUrl;
    
    [self.KSYPlayer reload:aUrl flush:NO mode:MPMovieReloadMode_Fast] ;
}

- (void)shouldMute:(BOOL)status{
    _KSYPlayer.shouldMute = status;
}

- (BOOL)isPlaying{
    return _KSYPlayer.isPlaying;
}

- (void)setScalingMode:(MPMovieScalingMode)mode{
    _KSYPlayer.scalingMode = mode;
}

- (void)prepareToPlay{
    [_KSYPlayer prepareToPlay ];
}

- (void)play{
    [_KSYPlayer play];
}

- (void)pause{
    [_KSYPlayer pause];
}

- (void)stop{
    [_KSYPlayer stop];
    _isBeColsed = YES;
}

- (BOOL)isBeColsed{
    return _isBeColsed;
}

- (void)reset:(BOOL)holdLastPic{
    [_KSYPlayer reset:holdLastPic];
    _isBeColsed = YES;
}

- (void)setUrl:(NSURL *)url{
    [_KSYPlayer setUrl:url];
}

- (void)setupObservers{
    
    /*做好播放准备 监听*/
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMediaPlaybackIsPreparedToPlayDidChangeNotification)
                                              object:_KSYPlayer];
    /*播放状态改变 监听*/
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerPlaybackStateDidChangeNotification)
                                              object:_KSYPlayer];
    /*媒体播放完成或用户手动退出，具体完成原因可以通过通知userInfo中的key为MPMoviePlayerPlaybackDidFinishReasonUserInfoKey的对象获取 监听*/
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerPlaybackDidFinishNotification)
                                              object:_KSYPlayer];
    /*媒体网络加载状态改变 监听*/
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerLoadStateDidChangeNotification)
                                              object:_KSYPlayer];
    /*确定了媒体的实际尺寸后 监听*/
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMovieNaturalSizeAvailableNotification)
                                              object:_KSYPlayer];
    /*得到第一贞图像后 监听*/
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerFirstVideoFrameRenderedNotification)
                                              object:_KSYPlayer];
    /*得到第一贞音频后 监听*/
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerFirstAudioFrameRenderedNotification)
                                              object:_KSYPlayer];
    /*播放器建议重新加载 这个时候需要调用reload方法重新拉流 监听*/
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerSuggestReloadNotification)
                                              object:_KSYPlayer];
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(handlePlayerNotify:)
                                                name:(MPMoviePlayerPlaybackStatusNotification)
                                              object:_KSYPlayer];
    //    [[NSNotificationCenter defaultCenter]addObserver:self
    //                                            selector:@selector(netWorkChangeNotify:)
    //                                                name:(Notification_NetWorkStatusChangedInLivingRoom)
    //                                              object:[playerManager sharedInstanceWithContentUrl:_liveURL]];
}



-(void)handlePlayerNotify:(NSNotification*)notify
{
    if (!_KSYPlayer) {
        return;
    }
    if (MPMediaPlaybackIsPreparedToPlayDidChangeNotification ==  notify.name) {
        
        //        // using autoPlay to start live stream
        //        //        [_player play];
        
    }
    if (MPMoviePlayerPlaybackStateDidChangeNotification ==  notify.name) {
        //        NSLog(@"------------------------");
        //        NSLog(@"player playback state: %ld", (long)_player.playbackState);
        //        NSLog(@"------------------------");
        
        if (      _KSYPlayer.playbackState == MPMoviePlaybackStateStopped){//播放停止
            
        }else if (_KSYPlayer.playbackState == MPMoviePlaybackStatePlaying){//正在播放
            
        }else if (_KSYPlayer.playbackState == MPMoviePlaybackStatePaused){//播放暂停
            
        }else if (_KSYPlayer.playbackState == MPMoviePlaybackStateInterrupted){//播放被打断
            
        }else if (_KSYPlayer.playbackState == MPMoviePlaybackStateSeekingForward){//向前seeking中
            
        }else if (_KSYPlayer.playbackState == MPMoviePlaybackStateSeekingBackward){//向后seeking中
            
        }else{
            
        }
    }
    if (MPMoviePlayerLoadStateDidChangeNotification ==  notify.name) {
        //        NSLog(@"player load state: %ld", (long)_player.loadState);
        if (MPMovieLoadStateStalled & _KSYPlayer.loadState) {
            
            //            NSLog(@"player start caching");
        }
        
        if (_KSYPlayer.bufferEmptyCount &&
            (MPMovieLoadStatePlayable & _KSYPlayer.loadState ||
             MPMovieLoadStatePlaythroughOK & _KSYPlayer.loadState)){
                //                NSLog(@"player finish caching");
                //                NSString *message = [[NSString alloc]initWithFormat:@"loading occurs, %d - %0.3fs",
                //                                     (int)_player.bufferEmptyCount,
                //                                     _player.bufferEmptyDuration];
            }
    }
    if (MPMoviePlayerPlaybackDidFinishNotification ==  notify.name) {
        //        NSLog(@"player finish state: %ld", (long)_player.playbackState);
        //        NSLog(@"player download flow size: %f MB", _player.readSize);
        //        NSLog(@"buffer monitor  result: \n   empty count: %d, lasting: %f seconds",
        //              (int)_player.bufferEmptyCount,
        //              _player.bufferEmptyDuration);
        int reason = [[[notify userInfo] valueForKey:MPMoviePlayerPlaybackDidFinishReasonUserInfoKey] intValue];
        if (reason ==  MPMovieFinishReasonPlaybackEnded) {//播放结束
            
            //            if (self.playFinishEndedBlock) {
            //                self.playFinishEndedBlock();
            //            }
            //_textLabel.text = [NSString stringWithFormat:@"player finish"];
        }else if (reason == MPMovieFinishReasonPlaybackError){//播放错误
            
            //_textLabel.text = [NSString stringWithFormat:@"player Error : %@", [[notify userInfo] valueForKey:@"error"]];
        }else if (reason == MPMovieFinishReasonUserExited){//用户主动退出
            
            
            
        }
        
    }
    if (MPMovieNaturalSizeAvailableNotification ==  notify.name) {
        //        NSLog(@"video size %.0f-%.0f", _player.naturalSize.width, _player.naturalSize.height);
    }
    if (MPMoviePlayerFirstVideoFrameRenderedNotification == notify.name)
    {
        if (self.startFristVideoFrameRenderedBlock) {
            self.startFristVideoFrameRenderedBlock();
        }
        //        fvr_costtime = (int)((long long int)([self getCurrentTime] * 1000) - prepared_time);
        //        NSLog(@"first video frame show, cost time : %dms!\n", fvr_costtime);
    }
    
    if (MPMoviePlayerFirstAudioFrameRenderedNotification == notify.name)
    {
        //        far_costtime = (int)((long long int)([self getCurrentTime] * 1000) - prepared_time);
        //        NSLog(@"first audio frame render, cost time : %dms!\n", far_costtime);
    }
    
    if (MPMoviePlayerSuggestReloadNotification == notify.name)
    {
        //        NSLog(@"suggest using reload function!\n");
        if (_KSYPlayer){
            if (_liveURL) {
                [_KSYPlayer reload:_liveURL flush:NO mode:MPMovieReloadMode_Accurate];
            }
            
        }
    }
    
    if(MPMoviePlayerPlaybackStatusNotification == notify.name)
    {
        int status = [[[notify userInfo] valueForKey:MPMoviePlayerPlaybackStatusUserInfoKey] intValue];
        if(MPMovieStatusVideoDecodeWrong == status)
        {
            NSLog(@"Video Decode Wrong!\n");
        }
        else if(MPMovieStatusAudioDecodeWrong == status)
        {
            NSLog(@"Audio Decode Wrong!\n");
        }
        else if (MPMovieStatusHWCodecUsed == status )
        {
            NSLog(@"Hardware Codec used\n");
        }
        else if (MPMovieStatusSWCodecUsed == status )
        {
            NSLog(@"Software Codec used\n");
        }
    }
}

- (void)releaseObservers
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMediaPlaybackIsPreparedToPlayDidChangeNotification
                                                 object:_KSYPlayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerPlaybackStateDidChangeNotification
                                                 object:_KSYPlayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerPlaybackDidFinishNotification
                                                 object:_KSYPlayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerLoadStateDidChangeNotification
                                                 object:_KSYPlayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMovieNaturalSizeAvailableNotification
                                                 object:_KSYPlayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerFirstVideoFrameRenderedNotification
                                                 object:_KSYPlayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerFirstAudioFrameRenderedNotification
                                                 object:_KSYPlayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerSuggestReloadNotification
                                                 object:_KSYPlayer];
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:MPMoviePlayerPlaybackStatusNotification
                                                 object:_KSYPlayer];
    //    [[NSNotificationCenter defaultCenter]removeObserver:self
    //                                                   name:Notification_NetWorkStatusChangedInLivingRoom
    //                                                 object:[playerManager sharedInstanceWithContentUrl:_liveURL]];
}


@end
