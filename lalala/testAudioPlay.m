//
//  testAudioPlay.m
//  lalala
//
//  Created by Rabbit.Meat on 15/5/3.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import "testAudioPlay.h"

#define AVCODEC_MAX_AUDIO_FRAME_SIZE  4096*2// (0x10000)/4
//static UInt32 gBufferSizeBytes=0x10000;//65536
static UInt32 gBufferSizeBytes=0x10000;//It must be pow(2,x)
Byte *pcmDataBuffer;
int pcmDataSzie;
int pos;
@implementation testAudioPlay

@synthesize queue;

//回调函数(Callback)的实现
static void BufferCallback(void *inUserData,AudioQueueRef inAQ,
                           AudioQueueBufferRef buffer){
    testAudioPlay* player=(__bridge testAudioPlay*)inUserData;
    [player audioQueueOutputWithQueue:inAQ queueBuffer:buffer];
}


//缓存数据读取方法的实现
-(void) audioQueueOutputWithQueue:(AudioQueueRef)audioQueue queueBuffer:(AudioQueueBufferRef)audioQueueBuffer{
    //读取包数据
    UInt32 numBytes;
    //    UInt32 numPackets=numPacketsToRead;
    UInt32 numPackets=numPacketsToRead;
    
    //成功读取时
   // numBytes=fread(inbuf, 1, numPackets*4,wavFile);
    
    AudioQueueBufferRef outBufferRef=audioQueueBuffer;
    NSData *aData=[[NSData alloc]initWithBytes:inbuf length:numBytes];
    
    if(numBytes>0){
        memcpy(outBufferRef->mAudioData, aData.bytes, aData.length);
        
        outBufferRef->mAudioDataByteSize=numBytes;
        AudioQueueEnqueueBuffer(audioQueue, outBufferRef, 0, nil);
        packetIndex += numPackets;
    }
    else{
    }
}

//音频播放方法的实现
-(id) initWithAudio:(NSData *)adata{
    if (!(self=[super init])) return nil;
    pcmDataBuffer = (Byte  *)[adata bytes];
    pcmDataSzie = (int)[adata length];
    pos = 0;
    
    inbuf=(uint8_t *)malloc(gBufferSizeBytes);
    
    for (int i=0; i<NUM_BUFFERS; i++) {
        AudioQueueEnqueueBuffer(queue, buffers[i], 0, nil);
    }
    
    //取得音频数据格式
    {
        dataFormat.mSampleRate=44100;//采样频率
        dataFormat.mFormatID=kAudioFormatLinearPCM;
        dataFormat.mFormatFlags=kAudioFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
        dataFormat.mBytesPerFrame=4;
        dataFormat.mBytesPerPacket=4;
        dataFormat.mFramesPerPacket=1;//wav 通常为1
        dataFormat.mChannelsPerFrame=2;//通道数
        dataFormat.mBitsPerChannel=16;//采样的位数
        dataFormat.mReserved=0;
    }
    
    //创建播放用的音频队列
    AudioQueueNewOutput(&dataFormat, BufferCallback, (__bridge void *)(self),
                        nil, nil, 0, &queue);
    //计算单位时间包含的包数
    
    //    numPacketsToRead= gBufferSizeBytes/dataFormat.mBytesPerPacket;
    //    numPacketsToRead=AVCODEC_MAX_AUDIO_FRAME_SIZE
    numPacketsToRead=AVCODEC_MAX_AUDIO_FRAME_SIZE;
    packetDescs=nil;
    
    //设置Magic Cookie，参见第二十七章的相关介绍
    
    //创建并分配缓冲控件
    packetIndex=0;
    for (int i=0; i<NUM_BUFFERS; i++) {
        AudioQueueAllocateBuffer(queue, gBufferSizeBytes, &buffers[i]);
        //读取包数据
        if ([self readPacketsIntoBuffer:buffers[i]]==1) {
            break;
        }
    }
    
    Float32 gain=1.0;
    //设置音量
    AudioQueueSetParameter(queue, kAudioQueueParam_Volume, gain);
    //队列处理开始，此后系统开始自动调用回调(Callback)函数
    AudioQueueStart(queue, nil);
    return self;
}

-(UInt32)readPacketsIntoBuffer:(AudioQueueBufferRef)buffer {
    UInt32 numBytes,numPackets;
    //从文件中接受数据并保存到缓存(buffer)中
    //AVCODEC_MAX_AUDIO_FRAME_SIZE*100
    numPackets = numPacketsToRead;
    AudioQueueBufferRef outBufferRef=buffer;
    numBytes = MIN(numPackets, pcmDataSzie - pos);
    
    //numBytes=fread(inbuf, 1, numPackets*4,wavFile);
    for (int i = 0; i < numBytes; i++) {
        inbuf[i] = pcmDataBuffer[pos + i];
    }
    pos += numBytes;
    
    NSData *aData=[[NSData alloc]initWithBytes:inbuf length:numBytes];
    
    
    if(numBytes>0){
        memcpy(outBufferRef->mAudioData, aData.bytes, aData.length);
        outBufferRef->mAudioDataByteSize=numBytes;
        AudioQueueEnqueueBuffer(queue, outBufferRef, 0, nil);
        packetIndex += numPackets;
    }
    else{
        return 1;//意味着我们没有读到任何的包
    }
    return 0;//0代表正常的退出
}
@end