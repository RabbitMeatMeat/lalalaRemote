//
//  AudioPlay.m
//  lalala
//
//  Created by Rabbit.Meat on 15/5/2.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import "AudioPlay.h"
#import <AudioToolbox/AudioToolbox.h>
#import "math.h"
#define QUEUE_BUFFER_SIZE 4 //队列缓冲个数
#define EVERY_READ_LENGTH 1000 //每次读都长度
#define MIN_SIZE_PER_FRAME 2000 //每帧最小数据长度


AudioStreamBasicDescription audioDescription;
AudioQueueRef audioQueue; //音频播放队列
AudioQueueBufferRef audioQueueBuffers[QUEUE_BUFFER_SIZE];
NSLock *synlock; //同步控制
Byte *pcmDataBuffer;
int pcmDataSize;
int pos;

@implementation AudioPlay

//回调函数
static void bufferCallback(void *input, AudioQueueRef audioQueueRef, AudioQueueBufferRef audioQueueBufferRef) {
    AudioPlay * play = (__bridge AudioPlay *) input;
    [play readPCMDataAndPlayWithAudioQueueRef:audioQueueRef andQueueBufferRef:audioQueueBufferRef];
}
-(void) readPCMDataAndPlayWithAudioQueueRef:(AudioQueueRef) audioQueueRef andQueueBufferRef:(AudioQueueBufferRef) audioQueueBufferRef{
    
    if (pcmDataSize - pos > 0) {
        int size = MIN(pcmDataSize - pos, EVERY_READ_LENGTH);
        audioQueueBufferRef->mAudioDataByteSize = size;
        Byte *audioData = (Byte *)audioQueueBufferRef->mAudioData;
        for (int i = 0; i < size; i++) {
            audioData[i] = pcmDataBuffer[pos + i];
        }
        pos += size;
        
        AudioQueueEnqueueBuffer(audioQueueRef, audioQueueBufferRef, 0, nil);
        
    }
    
    
}
-(void) initAudioWithPCMData:(Byte *) pcmData andSize:(int) size{
    pcmDataBuffer = pcmData;
    pcmDataSize = size;
    pos = 0;
   // NSLog(@"%d **********",size);
    audioDescription.mSampleRate = 44100;
    audioDescription.mFormatID = kAudioFormatLinearPCM;
    audioDescription.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
    audioDescription.mChannelsPerFrame = 1;
    audioDescription.mFramesPerPacket = 1;
    audioDescription.mBytesPerPacket = 16;
    audioDescription.mBytesPerFrame = (audioDescription.mBitsPerChannel / 8) * audioDescription.mChannelsPerFrame;
    audioDescription.mBytesPerPacket = audioDescription.mBytesPerFrame;
    
    
    AudioQueueNewOutput(&audioDescription, bufferCallback, (__bridge void *)(self), nil, nil, 0, &audioQueue);
    for (int i = 0; i < QUEUE_BUFFER_SIZE; i++) {
        AudioQueueAllocateBuffer(audioQueue, MIN_SIZE_PER_FRAME, &audioQueueBuffers[i]);
        
        [self readPCMDataAndPlayWithAudioQueueRef:audioQueue andQueueBufferRef:audioQueueBuffers[i]];
        
    }
  
    AudioQueueSetParameter(audioQueue, kAudioQueueParam_Volume, 1.0);
    AudioQueueStart(audioQueue, NULL);
    
    
}

@end
