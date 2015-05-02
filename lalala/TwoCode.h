//
//  TwoCode.h
//  lalala
//
//  Created by Rabbit.Meat on 15/5/2.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwoCode : NSObject
@property NSInteger userCode;
@property NSInteger dataCode;
-(TwoCode *) initWithUserCode:(NSInteger ) userCode andDataCode:(NSInteger ) dataCode;
+(TwoCode *) initWithUserCode:(NSInteger ) userCode andDataCode:(NSInteger ) dataCode;

@end
