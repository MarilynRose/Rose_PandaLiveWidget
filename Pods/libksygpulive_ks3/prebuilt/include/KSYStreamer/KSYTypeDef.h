//
//  KSYTypeDef.h
//  KSStreamer
//
//  Created by pengbin on 10/15/15.
//  Copyright © 2015 ksyun. All rights reserved.
//

#ifndef _KSYTypeDef_h_
#define _KSYTypeDef_h_

#pragma mark - scene and performance settings

/// 直播场景 (KSY内部会根据场景的特征进行参数调优)
typedef NS_ENUM(NSUInteger, KSYLiveScene) {
    /// 默认通用场景(不确定场景时使用)
    KSYLiveScene_Default = 0,
    /// 秀场场景, 主播上半身为主
    KSYLiveScene_Showself,
    /// 游戏场景
    KSYLiveScene_Game,
    // others comming soon
};

/// 视频编码性能档次 (视频质量 和 设备资源之间的权衡)
typedef NS_ENUM(NSUInteger, KSYVideoEncodePerformance) {
    /// 低功耗:  cpu资源消耗低一些,视频质量差一些
    KSYVideoEncodePer_LowPower= 0,
    /// 均衡档次: 性价比比较高
    KSYVideoEncodePer_Balance,
    /// 高性能: 画面质量高
    KSYVideoEncodePer_HighPerformance,
};

#pragma mark - Authorization

/// 设备授权状态
typedef NS_ENUM(NSUInteger, KSYDevAuthStatus) {
    /// 还没有确定是否授权
    KSYDevAuthStatusNotDetermined = 0,
    /// 设备受限，一般在家长模式下设备会受限
    KSYDevAuthStatusRestricted,
    /// 拒绝授权
    KSYDevAuthStatusDenied,
    /// 已授权
    KSYDevAuthStatusAuthorized
};

#pragma mark - Video Dimension

/// 采集分辨率
typedef NS_ENUM(NSUInteger, KSYVideoDimension) {
    /// 16 : 9 宽高比，1280 x 720 分辨率
    KSYVideoDimension_16_9__1280x720 = 0,
    /// 16 : 9 宽高比，960 x 540 分辨率
    KSYVideoDimension_16_9__960x540,
    /// 4 : 3 宽高比，640 x 480 分辨率
    KSYVideoDimension_4_3__640x480,
    /// 16 : 9 宽高比，640 x 360 分辨率
    KSYVideoDimension_16_9__640x360,
    /// 4 : 3 宽高比，320 x 240 分辨率
    KSYVideoDimension_5_4__352x288,
    
    /// 缩放自定义分辨率 从设备支持的最近分辨率缩放获得, 若设备没有对应宽高比的分辨率，则裁剪后进行缩放
    KSYVideoDimension_UserDefine_Scale,
    /// 裁剪自定义分辨率 从设备支持的最近分辨率裁剪获得
    KSYVideoDimension_UserDefine_Crop,
    /// 注意： 选择缩放自定义分辨率时可能会有额外CPU代价
    
    /// 默认分辨率，默认为 4 : 3 宽高比，640 x 480 分辨率
    KSYVideoDimension_Default = KSYVideoDimension_4_3__640x480,
};

#pragma mark - Video & Audio Codec ID
/*!
 * @abstract  视频编码器类型
 */
typedef NS_ENUM(NSUInteger, KSYVideoCodec) {
    /// 视频编码器 - h264 软件编码器
    KSYVideoCodec_X264 = 0,
    /// 视频编码器 - KSY265 软件编码器
    KSYVideoCodec_QY265,
    /// 视频编码器 - iOS VT264硬件编码器 (iOS 8.0以上支持)
    KSYVideoCodec_VT264,
    /// 视频编码器 - 由SDK自动选择（ VT264 > X264）
    KSYVideoCodec_AUTO = 100,
};

/*!
 * @abstract  音频编码器类型
 */
typedef NS_ENUM(NSUInteger, KSYAudioCodec) {
    /// faac音频软件编码器 - AAC_HE
    KSYAudioCodec_AAC_HE = 0,
    /// faac音频软件编码器 - AAC_LC
    KSYAudioCodec_AAC,
    /// iOS自带的audiotoolbox音频编码器 - AAC_LC
    KSYAudioCodec_AT_AAC,
};

#pragma mark - QYPublisher State

/*!
 * @abstract  采集设备状态
 */
typedef NS_ENUM(NSUInteger, KSYCaptureState) {
    /// 设备空闲中
    KSYCaptureStateIdle,
    /// 设备工作中
    KSYCaptureStateCapturing,
    /// 设备授权被拒绝
    KSYCaptureStateDevAuthDenied,
    /// 关闭采集设备中
    KSYCaptureStateClosingCapture,
    /// 参数错误，无法打开（比如设置的分辨率，码率当前设备不支持）
    KSYCaptureStateParameterError,
    /// 设备正忙，请稍后尝试 ( 该状态在发出通知0.5秒后被清除 ）
    KSYCaptureStateDevBusy,
};

/*!
 * @abstract  推流状态
 */
typedef NS_ENUM(NSUInteger, KSYStreamState) {
    /// 初始化时状态为空闲
    KSYStreamStateIdle = 0,
    /// 连接中
    KSYStreamStateConnecting,
    /// 已连接
    KSYStreamStateConnected,
    /// 断开连接中
    KSYStreamStateDisconnecting,
    /// 推流出错
    KSYStreamStateError,
};

/*!
 * @abstract  推流错误码，用于指示推流失败的原因
 */
typedef NS_ENUM(NSUInteger, KSYStreamErrorCode) {
    /// 正常无错误
    KSYStreamErrorCode_NONE = 0,
    /// (obsolete)
    KSYStreamErrorCode_KSYAUTHFAILED,
    /// 当前帧编码失败
    KSYStreamErrorCode_ENCODE_FRAMES_FAILED,
    /// 无法打开配置指示的CODEC
    KSYStreamErrorCode_CODEC_OPEN_FAILED,
    /// 连接出错，检查地址
    KSYStreamErrorCode_CONNECT_FAILED,
    /// 网络连接中断
    KSYStreamErrorCode_CONNECT_BREAK,
    /// rtmp 推流域名不存在 (KSY 自定义)
    KSYStreamErrorCode_RTMP_NonExistDomain,
    /// rtmp 应用名不存在(KSY 自定义)
    KSYStreamErrorCode_RTMP_NonExistApplication,
    /// rtmp 流名已存在(KSY 自定义)
    KSYStreamErrorCode_RTMP_AlreadyExistStreamName,
    /// rtmp 被黑名单拒绝(KSY 自定义)
    KSYStreamErrorCode_RTMP_ForbiddenByBlacklist,
    /// rtmp 内部错误(KSY 自定义)
    KSYStreamErrorCode_RTMP_InternalError,
    /// rtmp URL 地址已过期(KSY 自定义)
    KSYStreamErrorCode_RTMP_URLExpired,
    /// rtmp URL 地址签名错误(KSY 自定义)
    KSYStreamErrorCode_RTMP_SignatureDoesNotMatch,
    /// rtmp URL 中AccessKeyId非法(KSY 自定义)
    KSYStreamErrorCode_RTMP_InvalidAccessKeyId,
    /// rtmp URL 中参数错误(KSY 自定义)
    KSYStreamErrorCode_RTMP_BadParams,
    /// rtmp URL 中的推流不在发布点内（KSY 自定义）
    KSYStreamErrorCode_RTMP_ForbiddenByRegion,
    /// (obsolete)
    KSYStreamErrorCode_FRAMES_THRESHOLD,
    /// (obsolete)
    KSYStreamErrorCode_NO_INPUT_SAMPLE,
    /// 对于URL中的域名解析失败
    KSYStreamErrorCode_DNS_Parse_failed,
    /// 对于URL对应的服务器连接失败(无法建立TCP连接)
    KSYStreamErrorCode_Connect_Server_failed,
    /// 跟RTMP服务器完成握手后,向{appname}/{streamname} 推流失败
    KSYStreamErrorCode_RTMP_Publish_failed,
    /// 音视频同步失败 (输入的音频和视频的时间戳的差值超过5s)
    KSYStreamErrorCode_AV_SYNC_ERROR,
    /// 非法地址(地址为空或url中的协议或本地文件的后缀SDK不支持, 请检查)
    KSYStreamErrorCode_INVALID_ADDRESS,
};

/*!
 * @abstract  网络状况事件码，用于指示当前网络健康状况
 */
typedef NS_ENUM(NSUInteger, KSYNetStateCode) {
    /// 正常无错误
    KSYNetStateCode_NONE = 0,
    /// 发送包时间过长，( 单次发送超过 500毫秒 ）
    KSYNetStateCode_SEND_PACKET_SLOW,
    /// 估计带宽调整，上调
    KSYNetStateCode_EST_BW_RAISE,
    /// 估计带宽调整，下调
    KSYNetStateCode_EST_BW_DROP,
    /// SDK 鉴权失败 (暂时正常推流5~8分钟后终止推流)
    KSYNetStateCode_KSYAUTHFAILED,
    /// 输入音频不连续
    KSYNetStateCode_IN_AUDIO_DISCONTINUOUS,
};

/*!
 * @abstract  音频播放状态
 */
typedef NS_ENUM(NSUInteger, KSYBgmPlayerState) {
    /// 初始状态
    KSYBgmPlayerStateInit,
    /// 背景音正在播放
    KSYBgmPlayerStateStarting,
    /// 背景音停止
    KSYBgmPlayerStateStopped,
    /// 背景音正在播放
    KSYBgmPlayerStatePlaying,
    /// 背景音暂停
    KSYBgmPlayerStatePaused,
    /// 背景音播放出错
    KSYBgmPlayerStateError,
    /// 背景音被打断
    KSYBgmPlayerStateInterrupted
};


/*!
 * @abstract  音频输入设备类型
 * @discussion 参考 AVAudioSessionPortBuiltInMic
 */
typedef NS_ENUM(NSUInteger, KSYMicType) {
    /// Built-in microphone on an iOS device
    KSYMicType_builtinMic = 0,
    /// Microphone on a wired headset
    KSYMicType_headsetMic,
    /// 蓝牙设备
    KSYMicType_bluetoothMic,
    
    /// 未知设备
    KSYMicType_unknow = 1000,
};

 /*!
  * @abstract  网络自适应模式类型
  */
typedef NS_ENUM(NSUInteger, KSYBWEstimateMode) {
    /// 默认模式 (综合模式,比较平稳)
    KSYBWEstMode_Default = 0,
    /// 流畅优先模式(消极上调, 极速下调)
    KSYBWEstMode_Negtive,
    
    /// 禁用网络自适应网络调整
    KSYBWEstMode_Disable = 1000,
};

/*!
 * @abstract  旁路录制状态
 */
typedef NS_ENUM(NSInteger, KSYRecordState) {
    /// 初始状态
    KSYRecordStateIdle,
    /// 录像中
    KSYRecordStateRecording,
    /// 录像停止
    KSYRecordStateStopped,
    /// 录像失败
    KSYRecordStateError,
};

/*!
 * @abstract  旁路录制错误码
 */
typedef NS_ENUM(NSInteger, KSYRecordError) {
    /// 无错误
    KSYRecordErrorNone,
    /// 地址错误
    KSYRecordErrorPathInvalid,
    /// 格式不支持
    KSYRecordErrorFormatNotSupport,
    /// 内部错误
    KSYRecordErrorInternal,
};

#pragma mark - KSY_EXTERN
#ifndef KSY_EXTERN
#ifdef __cplusplus
#define KSY_EXTERN     extern "C" __attribute__((visibility ("default")))
#else
#define KSY_EXTERN     extern __attribute__((visibility ("default")))
#endif
#endif

#endif
