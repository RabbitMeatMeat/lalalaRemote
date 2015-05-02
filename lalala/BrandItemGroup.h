//
//  BrandItemGroup.h
//  lalala
//
//  Created by Rabbit.Meat on 15/5/1.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BrandItemGroup : NSObject
//组名
@property (nonatomic, copy) NSString *name;

//品牌
@property (nonatomic, copy) NSMutableArray *brandItems;

//带参数带构造函数
-(BrandItemGroup *) initWithName:(NSString *) name andBrandItems:(NSMutableArray *) brandItems;

//静态初始化
+(BrandItemGroup *) initWithName:(NSString *) name andBrandItems:(NSMutableArray *) brandItems;

@end
