//
//  LalalaDataBase.h
//  lalala
//
//  Created by Rabbit.Meat on 15/5/2.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwoCode.h"

@interface LalalaDataBase : NSObject

+(void) initDataBase;
+(NSMutableArray *) getDevice;
+(NSMutableArray *) getBrandWithDevice:(NSString *) device;
+(TwoCode *) getCodeWithDevice:(NSString *) device andBrand:(NSString *) brand andButtonKey:(NSString *) buttonKey;
@end
