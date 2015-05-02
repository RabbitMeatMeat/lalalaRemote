//
//  BrandItem.m
//  lalala
//
//  Created by Rabbit.Meat on 15/5/1.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import "BrandItem.h"

@implementation BrandItem
-(BrandItem *) initWithEnglishName:(NSString *)englishName andChineseName:(NSString *)chineseName {
    if (self = [super init]) {
        self.englishName = englishName;
        self.chineseName = chineseName;
    }
    return self;
}
-(NSString *) getName{
    return [NSString stringWithFormat:@"%@ %@",_englishName, _chineseName];
}
+(BrandItem *) initWithEnglishName:(NSString *)englishName andChineseName:(NSString *)chineseName{
    BrandItem * brandItem = [[BrandItem alloc] initWithEnglishName:englishName andChineseName:chineseName];
    return brandItem;
}

@end
