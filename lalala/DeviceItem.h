//
//  DeviceItem.h
//  lalala
//
//  Created by Rabbit.Meat on 15/5/2.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DeviceItem : NSObject
@property  NSString *name;
@property  NSString *imageName;
-(DeviceItem *) initWithName:(NSString *)name andImageName:(NSString *)imageName;
+(DeviceItem *) initWithName:(NSString *)name andImageName:(NSString *)imageName;

@end
