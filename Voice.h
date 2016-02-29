//
//  Voice.h
//  TestRecord
//
//  Created by LennonChen on 16/2/26.
//  Copyright © 2016年 LennonChen. All rights reserved.
//

#ifndef Voice_h
#define Voice_h

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface VoiceRecorder : NSObject

/*
*    开始录音
*
*    @param file 录音文件的路径，wav格式
*
*    @return 0失败，1成功
*/
+ (int)Start:(nonnull NSString *)file;

/*
*    停止录音和播放
*
*/
+ (void)Stop;

/*
*    播放录音
*
*    @param file wav文件路径
*
*    @return 0失败，1成功
*/
+ (int)Play:(nonnull NSString *)file;

/*
*    是否播放中
*
*    @return 0未播放，1播放中
*/
+ (int)IsPlaying;

/*
*    是否录音中
*
*    @return 0未录音, 1录音中
*/
+ (int)IsRecording;

/*
*    获取当前时间
*
*    @return 当前时间戳的字符串
*/
+ (NSString *)GetCurrentTimeForString;

/*
*    获取文件大小
*
*    @param filePath 文件路劲
*
*    @return 文件大小, -1失败
*/
+ (unsigned long long)GetFileSize:(nonnull NSString *)filePath;

/*
    重命名文件
    
    @param orgFile 原始文件路径
    @param dstFile 目的路径
 
    @return 0失败，1成功
*/
+ (int)RenameFile:(nonnull NSString *)orgFile toPath:(nonnull NSString *)dstPath;

/*
*    wav文件转换为amr文件
*
*    @param wavFile wav文件路径
*    @param amrFile 转换成amr文件的目的路径
*
*    @return 0失败，1成功
*/
+ (int)WAV2AMR:(nonnull NSString *)wavFile amr:(nonnull NSString *)amrFile;

/*
*    amr文件转换为wav文件
*
*    @param amrFile amr文件路径
*    @param wavFile 转换成wav文件的目的路径
*
*    @return 0失败，1成功
*/
+ (int)AMR2WAV:(nonnull NSString *)amrFile wav:(nonnull NSString *)wavFile;

@end
#endif /* Voice_h */
