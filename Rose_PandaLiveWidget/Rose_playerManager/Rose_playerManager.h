//
//  Rose_playerManager.h
//  Rose_PandaLiveWidget
//
//  Created by Marilyn_Rose on 2017/5/15.
//  Copyright © 2017年 Marilyn_Rose. All rights reserved.
//

typedef void(^VIDEO_START_BLOCK)();

#import <Foundation/Foundation.h>
#import "KSYMoviePlayerController.h"

@interface Rose_playerManager : NSObject

//接收到第一贞图像的时候回调
@property(nonatomic,copy)VIDEO_START_BLOCK startFristVideoFrameRenderedBlock;

@property(nonatomic,strong)KSYMoviePlayerController *KSYPlayer;

/*
 金山流播放器单例初始化  API规定必须传URL过来 init初始化不生效！
 */
//+ (KSYMoviePlayerController *)sharedInstanceWithContentUrl:(NSURL *)url;

+ (Rose_playerManager *)sharedWithUrl:(NSURL *)url;

/*
 更改视频流地址 并重新拉取 方法
 */
- (void)reload:(NSURL *)aUrl;

/*
 添加播放器状态监听
 */
- (void)setupObservers;

/*
 移除播放器状态监听
 */
- (void)releaseObservers;

/*
 是否静音 默认不静音
 */
- (void)shouldMute:(BOOL)status;

/*
 是否在播放
 */
- (BOOL)isPlaying;

/*
 @abstract 当前缩放显示模式。
 @discussion 当前支持四种缩放模式：
 typedef NS_ENUM(NSInteger, MPMovieScalingMode) {
 MPMovieScalingModeNone,       // 无缩放
 MPMovieScalingModeAspectFit,  // 同比适配，某个方向会有黑边
 MPMovieScalingModeAspectFill, // 同比填充，某个方向的显示内容可能被裁剪
 MPMovieScalingModeFill        // 满屏填充，与原始视频比例不一致
 } NS_DEPRECATED_IOS(2_0, 9_0);
 */
- (void)setScalingMode:(MPMovieScalingMode)mode;

/*
 @abstract 准备视频播放 默认自动播放 调用此方法就可以 不用调用play
 */
- (void)prepareToPlay;

/**
 @abstract 播放当前视频。
 @discussion play的使用逻辑:
 
 * 如果调用play方法前已经调用[prepareToPlay]([KSYMediaPlayback prepareToPlay])完成播放器对视频文件的初始化，且[shouldAutoplay]([KSYMoviePlayerController shouldAutoplay])属性为NO，则调用play方法将开始播放当前视频。此时播放器状态为CBPMoviePlaybackStatePlaying。
 * 如果调用play方法前已经调用[prepareToPlay]([KSYMediaPlayback prepareToPlay])完成播放器对视频文件的初始化，且[shouldAutoplay]([KSYMoviePlayerController shouldAutoplay])属性为YES，则调用play方法将暂停播放当前视频，实现效果和pause一致。
 * 如果调用play方法前未调用[prepareToPlay]([KSYMediaPlayback prepareToPlay])完成播放器对视频文件的初始化，则播放器自动调用[prepareToPlay]([KSYMediaPlayback prepareToPlay])进行视频文件的初始化工作。
 * 如果调用play方法前已经调用pause暂停了正在播放的视频，则重新开始启动播放视频。
 @since Available in KSYMediaPlayback 1.0 and later.
 @see prepareToPlay
 */
// Plays items from the current queue, resuming paused playback if possible.
- (void)play;

/*
 @abstract 暂停
 */
- (void)pause;

/*
 @abstract 停止播放
 */
- (void)stop;

/*
 @abstract 是否被关闭
 */
- (BOOL)isBeColsed;

/**
 @abstract 重置播放器
 @param holdLastPic 是否保留最后一帧
 @discussion 使用说明
 
 * 通常用于使用一个对象进行多次播放的场景
 * 该方法可以停止播放，但是不会销毁播放器
 * 调用该方法后可以通过调用stop方法来销毁播放器
 * 如果使用一个对象进行多次播放，需要在reset后使用setUrl方法设置下次播放地址
 
 @warning 该方法由金山云引入，不是原生系统接口
 @since Available in KSYMoviePlayerController 1.6.2 and later.
 */
- (void)reset:(BOOL)holdLastPic;

/**
 @abstract 设置播放url
 @param url 视频播放地址，该地址可以是本地地址或者服务器地址.如果为nil，则使用前一次播放地址
 @discussion 使用说明
 
 * 通常用于使用一个对象进行多次播放的场景
 * 调用reset接口停止播放后使用该接口来设置下一次播放地址
 * 需要在[prepareToPlay]([KSYMediaPlayback prepareToPlay])方法之前设置
 
 @warning 该方法由金山云引入，不是原生系统接口
 @since Available in KSYMoviePlayerController 1.6.2 and later.
 */
- (void)setUrl:(NSURL *)url;


@end
