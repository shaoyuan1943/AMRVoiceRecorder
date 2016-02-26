//
//  Voice.m
//  TestRecord
//
//  Created by LennonChen on 16/2/26.
//  Copyright © 2016年 LennonChen. All rights reserved.
//

#import "Voice.h"
#import "VoiceConverter.h"

static AVAudioRecorder *recorder = nil;
static AVAudioPlayer *player = nil;

@implementation VoiceRecorder

+ (int)Start:(NSString *)file
{
    NSURL *fileUri = [NSURL fileURLWithPath: file];
    NSError *error = nil;
    recorder = [[AVAudioRecorder alloc] initWithURL: fileUri settings: [VoiceConverter GetAudioRecorderSettingDict] error:&error];
    if (error)
    {
        NSLog(@"录音机创建失败：%@", error.localizedDescription);
        return 0;
    }
    
    error = nil;
    if ([recorder prepareToRecord])
    {
        [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayAndRecord error: &error];
        [[AVAudioSession sharedInstance] setActive: YES error: &error];
        if (error)
        {
            NSLog(@"录音预处理失败：%@", error.localizedDescription);
            return 0;
        }
    }
    
    if ([recorder record])
    {
        return 1;
    }
    
    return 0;
}

+ (void)Stop
{
    if (recorder && recorder.isRecording)
    {
        [recorder stop];
        recorder = nil;
    }
    
    if (player && player.isPlaying)
    {
        [player stop];
        player = nil;
    }
}

+ (int)Play:(NSString *)file
{
    NSError *error = nil;
    NSURL *fileUri = [NSURL fileURLWithPath: file];
    player = [[AVAudioPlayer alloc] initWithContentsOfURL: fileUri error:&error];
    if (error)
    {
        NSLog(@"播放机错误：%@", error.localizedDescription);
        return 0;
    }
    
    player.numberOfLoops = 0;
    [player prepareToPlay];
    
    if ([player play])
    {
        return 1;
    }
    return 0;
}

+ (int)IsPlaying
{
    if (player && player.isPlaying)
    {
        return 1;
    }
    
    return 0;
}

+ (int)IsRecording
{
    if (recorder && recorder.isRecording)
    {
        return 1;
    }
    
    return 0;
}

+ (NSString *)GetCurrentTimeForString
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow: 0];
    NSTimeInterval a = [date timeIntervalSince1970] * 1000;
    NSString *time = [NSString stringWithFormat: @"%f", a];
    return time;
}

+ (unsigned long long)GetFileSize:(NSString *)filePath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    if ([mgr fileExistsAtPath: filePath])
    {
        unsigned long long size = [[mgr attributesOfItemAtPath: filePath error:nil] fileSize];
        
        return size;
    }
    return -1;
}

+ (int)RenameFile:(NSString *)orgFile toPath:(NSString *)dstPath
{
    NSFileManager *mgr = [NSFileManager defaultManager];
    if ([mgr fileExistsAtPath: orgFile])
    {
        if ([mgr copyItemAtPath: orgFile toPath: dstPath error: nil])
        {
            [mgr removeItemAtPath: orgFile error: nil];
            return 1;
        }
    }
    
    return 0;
}

+ (int)WAV2AMR:(NSString *)wavFile amr:(NSString *)amrFile
{
    if ([VoiceConverter ConvertWavToAmr: wavFile amrSavePath: amrFile])
    {
        unsigned long long size = [VoiceRecorder GetFileSize: amrFile];
        if (size > 0)
        {
            return 1;
        }
    }

    NSLog(@"WAV转换AMR失败！");
    return 0;
}

+ (int)AMR2WAV:(NSString *)amrFile wav:(NSString *)wavFile
{
    if ([VoiceConverter ConvertAmrToWav: amrFile wavSavePath: wavFile])
    {
        unsigned long long size = [VoiceRecorder GetFileSize: wavFile];
        if (size > 0)
        {
            return 1;
        }
    }

    NSLog(@"AMR转换WAV失败！");
    return 0;
}

@end