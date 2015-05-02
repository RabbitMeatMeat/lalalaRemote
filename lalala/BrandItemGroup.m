//
//  BrandItemGroup.m
//  lalala
//
//  Created by Rabbit.Meat on 15/5/1.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import "BrandItemGroup.h"

@implementation BrandItemGroup
-(BrandItemGroup *) initWithName:(NSString *)name andBrandItems:(NSMutableArray *)brandItems{
    if (self = [super init]) {
        self.name = name;
        self.brandItems = brandItems;
    }
    return self;
}

+(BrandItemGroup *) initWithName:(NSString *)name andBrandItems:(NSMutableArray *)brandItems{
    BrandItemGroup *brandItemGroup = [[BrandItemGroup alloc] initWithName:name andBrandItems:brandItems];
    return brandItemGroup;
}

@end
