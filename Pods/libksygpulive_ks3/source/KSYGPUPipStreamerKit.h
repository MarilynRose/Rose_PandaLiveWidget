//
//  KSYGPUPipStreamerKit.h
//  KSYStreamer
//
//  Created by jaingdong on 28/12/16.
//  Copyright © 2016 ksyun. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "KSYGPUStreamerKit.h"

@interface KSYGPUPipStreamerKit : KSYGPUStreamerKit

/**
 @abstract 画中画通道
 */
@property (nonatomic, readonly) int pipTrack;
/**
 @abstract 背景图片图层
 */
@property (nonatomic, readonly) NSInteger bgPicLayer;
/**
 @abstract 画中画图层
 */
@property (nonatomic, readonly) NSInteger pipLayer;
/**
 @abstract   开启画中画
 @param playerUrl:播放视频的url
 @param bgUrl:背景图片的url
 */
-(void)startPipWithPlayerUrl:(NSURL*)playerUrl
                       bgPic:(NSURL*)bgUrl;
/**
 @abstract   停止画中画
 **/
-(void)stopPip;

/**
 @abstract 背景播放器
 */
@property (nonatomic, strong) KSYMoviePlayerController *player;
/**
 @abstract 背景图片
 */
@property (nonatomic, strong) GPUImagePicture          *bgPic;

/**
 @abstract   画中画图像输入
 @discussion 用于衔接画中画播放器和图像混合器 (KSYPicPipLayer = 1)
 @discussion 主要用于将图像的原始数据上传到GPU
 */
@property (nonatomic, readonly)KSYGPUPicInput         *yuvInput;

/**
 @abstract   背景图片的位置和大小
 @discussion 位置和大小的单位为预览视图的百分比, 左上角为(0,0), 右下角为(1.0, 1.0)
 @discussion 如果宽为0, 则根据图像的宽高比, 和设置的高度比例, 计算得到宽度的比例
 @discussion 如果高为0, 方法同上
 */
@property (nonatomic, readwrite) CGRect               bgPicRect;

/**
 @abstract   画中画的位置和大小
 @discussion 位置和大小的单位为预览视图的百分比, 左上角为(0,0), 右下角为(1.0, 1.0)
 @discussion 如果宽为0, 则根据图像的宽高比, 和设置的高度比例, 计算得到宽度的比例
 @discussion 如果高为0, 方法同上
 */
@property (nonatomic, readwrite) CGRect               pipRect;

/**
@abstract   相机的位置和大小
@discussion 位置和大小的单位为预览视图的百分比, 左上角为(0,0), 右下角为(1.0, 1.0)
@discussion 如果宽为0, 则根据图像的宽高比, 和设置的高度比例, 计算得到宽度的比例
@discussion 如果高为0, 方法同上
*/
@property (nonatomic, readwrite) CGRect               cameraRect;

/**
 @abstract   获取状态对应的字符串
 @param      stat 状态
 */
- (NSString*) getPipStateName : (MPMoviePlaybackState) stat;
/**
 @abstract   获取当前状态对应的字符串
 */
- (NSString*) getCurPipStateName;

/**
 @abstract   设置当前的播放状态
 */
- (void) newPipState: (MPMoviePlaybackState) stat;

/**
 @abstract    播放状态
 */
@property (nonatomic, readonly) MPMoviePlaybackState PipState;


// Posted when audio state changes
FOUNDATION_EXPORT NSString *const KSYPipStateDidChangeNotification NS_AVAILABLE_IOS(7_0);

@end
