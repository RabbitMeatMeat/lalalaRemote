//
//  Information.h
//  lalala
//
//  Created by Rabbit.Meat on 15/5/1.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Information : NSObject
@property (nonatomic, copy) NSString *device;
@property (nonatomic, copy) NSString *brand;
@property (nonatomic, copy) NSString *buttonkey;
-(Information *) initWithDevice:(NSString *)device andBrand:(NSString *)brand andButtonKey:(NSString *)buttonkey;
+(Information *) initWithDevice:(NSString *)device andBrand:(NSString *)brand andButtonKey:(NSString *)buttonkey;

@end
