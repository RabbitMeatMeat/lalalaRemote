//
//  TwoCode.m
//  lalala
//
//  Created by Rabbit.Meat on 15/5/2.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import "TwoCode.h"

@implementation TwoCode
-(TwoCode *) initWithUserCode:(NSInteger )userCode andDataCode:(NSInteger )dataCode{
    if (self = [super init]) {
        self.userCode = userCode;
        self.dataCode = dataCode;
    }
    return self;
}
+(TwoCode *) initWithUserCode:(NSInteger )userCode andDataCode:(NSInteger )dataCode{
    TwoCode * twoCode = [[TwoCode alloc] initWithUserCode:userCode andDataCode:dataCode];
    return twoCode;
}
@end
