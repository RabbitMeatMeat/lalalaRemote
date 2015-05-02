//
//  AudioPlay.h
//  lalala
//
//  Created by Rabbit.Meat on 15/5/2.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioPlay : NSObject
-(void) initAudioWithPCMData:(Byte *) pcmData andSize:(int) size;
@end
