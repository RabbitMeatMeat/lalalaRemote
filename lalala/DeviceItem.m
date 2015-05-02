//
//  DeviceItem.m
//  lalala
//
//  Created by Rabbit.Meat on 15/5/2.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import "DeviceItem.h"

@implementation DeviceItem
-(DeviceItem *)initWithName:(NSString *)name andImageName:(NSString *)imageName{
    if (self = [super init]) {
        self.name = name;
        self.imageName = imageName;
    }
    return self;
}
+(DeviceItem *)initWithName:(NSString *)name andImageName:(NSString *)imageName{
    DeviceItem *deviceItem = [[DeviceItem alloc] initWithName:name andImageName:imageName];
    return deviceItem;
}
@end
