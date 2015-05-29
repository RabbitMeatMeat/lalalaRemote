//
//  WaveService.m
//  lalala
//
//  Created by Rabbit.Meat on 15/5/2.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import "WaveService.h"
#import "math.h"
#import "AudioPlay.h"
#import "testAudioPlay.h"

const double freqOfTone = 20000;
const int sampleRate = 44100;
const int duration = 10;
const int numSamples = duration * sampleRate;
double smaple[numSamples+10];
Byte generatedSnd[2 * numSamples + 10];
int pos;



@implementation WaveService

+(void)getToneWithTime:(double) time andPercent:(float) percent {
    int numSamples = (int)(time/1000 * sampleRate);
    double sample[numSamples+10];
    double PI = acos(-1.0);
    for (int i = 0; i < numSamples; i++) {
        sample[i] = sin(2 * PI * freqOfTone * i / sampleRate);
       
    }
    for (int i = 0; i < numSamples; i++) {
        short val = (short)(sample[i] * ((1<<15)-1) * percent);
        
        generatedSnd[pos++] = (Byte) (val & 0x00ff);
        generatedSnd[pos++] = (Byte) ((val >> 8) & 0x00ff);
    }
    
}

// 抗干扰
+(void) getLittleHigh{
    [self getToneWithTime:2.25-0.56 andPercent:0.08];
    [self getToneWithTime:0.56 andPercent:0];
}
+(void) getTou{
    for (int i = 0; i < 3; i++) {
        [self getToneWithTime:10 andPercent:0];
        for (int j = 0; j < 4; j++) {
            [self getLittleHigh];
        }
        [self getToneWithTime:10 andPercent:0];
    }
}



//nec 0
+(void) getLow{
    [self getToneWithTime:0.56 andPercent:1];
    [self getToneWithTime:1.125-0.56 andPercent:0];
}
//nec 1
+(void) getHigh{
    [self getToneWithTime:0.56 andPercent:1];
    [self getToneWithTime:2.25-0.56 andPercent:0];
}
// leader code
+(void) getWaveWithLeaderCode{
    [self getToneWithTime:9 andPercent:1];
    [self getToneWithTime:4.5 andPercent:0];
}
//user code
+(void) getWaveWithUserCode:(NSInteger) userCode{
    for (int i = 0; i < 16; i++) {
        if (((userCode >> i) & 0x1) == 1) {
            [self getHigh];
        } else {
            [self getLow];
        }
    }
}
//data code
+(void) getWaveWithDataCode:(NSInteger) dataCode{
    for (int i = 0; i < 8; i++) {
        if (((dataCode >> i) & 0x1) == 1) {
            [self getHigh];
        } else {
            [self getLow];
        }
    }
    
    for (int i = 0; i < 8; i++) {
        if (((dataCode >> i) & 0x1) == 1) {
            [self getHigh];
        } else {
            [self getLow];
        }
    }
}
// stop code
+(void) getWaveWithStopBit{
    [self getToneWithTime:0.56 andPercent:1];
}
// repeat code
+(void) getWaveWithRepeatCode{
    [self getToneWithTime:110 andPercent:0];
    [self getToneWithTime:9.0 andPercent:1];
    [self getToneWithTime:2.25 andPercent:0];
    [self getToneWithTime:0.56 andPercent:1];
}
+(void) getWaveWithUserCode:(NSInteger) userCode andDataCode:(NSInteger) dataCode{
    pos = 0;
    [self getTou];
    [self getWaveWithLeaderCode];
    [self getWaveWithUserCode: userCode];
    [self getWaveWithDataCode: dataCode];
    [self getWaveWithStopBit];
    [self getWaveWithRepeatCode];
    [self getTou];
    
}
+(void) playSoundWithUserCode:(NSInteger)userCode andDataCode:(NSInteger)dataCode{
    [self getWaveWithUserCode:userCode andDataCode:dataCode];
   // NSLog(@"playSoundWithUserCode:%d andDataCode:%d", userCode, dataCode);
    
    
    [self testData];
    NSData *aData=[[NSData alloc]initWithBytes:generatedSnd length:pos];
    [[AudioPlay alloc]initAudioWithPCMData:aData];
    
    //[[testAudioPlay alloc] initWithAudio:aData];
    
    
}
+(void)testData{
    for (int i = 0; i < pos; i++) {
        printf("%d",generatedSnd[i]);
    }
    printf("\n");
}

@end
