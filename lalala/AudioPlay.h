//
//  AudioPlay.h
//  lalala
//
//  Created by Rabbit.Meat on 15/5/2.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

#define QUEUE_BUFFER_SIZE 4 //队列缓冲个数
#define EVERY_READ_LENGTH 1000 //每次读都长度
#define MIN_SIZE_PER_FRAME (1<<10) //每帧最小数据长度

@interface AudioPlay : NSObject{
    AudioStreamBasicDescription audioDescription;
    AudioQueueRef audioQueue; //音频播放队列
    AudioQueueBufferRef audioQueueBuffers[QUEUE_BUFFER_SIZE];
}
-(void) initAudioWithPCMData:(NSData *) aData;
@end
