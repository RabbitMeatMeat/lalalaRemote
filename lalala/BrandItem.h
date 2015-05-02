//
//  BrandItem.h
//  lalala
//  品牌数据列表
//  Created by Rabbit.Meat on 15/5/1.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandItem : NSObject
@property (nonatomic, copy) NSString *englishName;
@property (nonatomic, copy) NSString *chineseName;

-(BrandItem *) initWithEnglishName:(NSString *) englishName andChineseName:(NSString *) chineseName;
-(NSString *) getName;
+(BrandItem *) initWithEnglishName:(NSString *) englishName andChineseName:(NSString *) chineseName;
@end
