//
//  Information.m
//  lalala
//
//  Created by Rabbit.Meat on 15/5/1.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import "Information.h"

@implementation Information

-(Information *)initWithDevice:(NSString *)device andBrand:(NSString *)brand andButtonKey:(NSString *)buttonkey{
    if (self = [super init]) {
        self.device = device;
        self.brand = brand;
        self.buttonkey = buttonkey;
    }
    return self;
}
+(Information *)initWithDevice:(NSString *)device andBrand:(NSString *)brand andButtonKey:(NSString *)buttonkey{
    Information *information = [[Information alloc] initWithDevice:device andBrand:brand andButtonKey:buttonkey];
    return information;
}
@end
