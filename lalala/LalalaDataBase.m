//
//  LalalaDataBase.m
//  lalala
//
//  Created by Rabbit.Meat on 15/5/2.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import "LalalaDataBase.h"
#import "FMDatabase.h"
#import "DeviceItem.h"
#import "sqlite3.h"
#import "BrandItem.h"
#import "BrandItemGroup.h"
#import "TwoCode.h"

@implementation LalalaDataBase

#define DATA_FILE @"swing.db"

FMDatabase *db;

+(NSString *) dataFilePath{
    NSArray * myPaths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * myDocPath = [myPaths objectAtIndex:0];
    NSString *filename = [myDocPath stringByAppendingPathComponent:DATA_FILE];
    return filename;
}
+(void) initDataBase{
    
    NSString *fileName = [self dataFilePath];
    db = [FMDatabase databaseWithPath:fileName];
    if (![db open]) {
        NSLog(@"Could not open db.!");
        return;
    }
    //[db executeUpdate:@"drop database swing.db"];
    [self deleteTableData];
    [self createTable];
    [self insertDeviceData];
    [self insertBrandData];
    [self insertCodeData];
    [self testData];
    [db close];
}
+(void) testData{
    /*NSString *fileName = [self dataFilePath];
    db = [FMDatabase databaseWithPath:fileName];
    if (![db open]) {
        NSLog(@"Could not open db in get!");
        return;
    }
     */
    NSString *selectDevice = @"select * from DEVICE";
    FMResultSet *set = [db executeQuery:selectDevice];
    NSLog(@"+++++++ device table ++++++++");
    while ([set next]) {
        NSLog(@"%@ %@", [set stringForColumn:@"name"], [set stringForColumn:@"imageName"]);
    }
    NSLog(@"+++++ device end ++++++");

    NSString *selectBrand = @"select * from BRAND";
    set = [db executeQuery:selectBrand];
    NSLog(@"+++++++ brand table ++++++++");
    while ([set next]) {
        NSLog(@"%@ %@ %@", [set stringForColumn:@"device"], [set stringForColumn:@"brandEnglishName"], [set stringForColumn:@"brandChineseName"]);
    }
    NSLog(@"+++++ brand end ++++++");
    
    NSString *selectCode = @"select * from CODE";
    set = [db executeQuery:selectCode];
    NSLog(@"+++++++ code table ++++++++");
    while ([set next]) {
        NSLog(@"%@ %@ %@ %d %d", [set stringForColumn:@"device"], [set stringForColumn:@"brand"], [set stringForColumn:@"buttonKey"], [set intForColumn:@"userCode"], [set intForColumn:@"dataCode"]);
    }
    NSLog(@"+++++ code end ++++++");
    [db close];


}
+(void) deleteTableData{
    [db executeUpdate:@"drop table DEVICE"];
    [db executeUpdate:@"drop table BRAND"];
    [db executeUpdate:@"drop table CODE"];
    [db executeUpdate:@"delete from DEVICE"];
    [db executeUpdate:@"delete from BRAND"];
    [db executeUpdate:@"delete from CODE"];
    
}
+(void) createTable{
    NSString *DeviceTable = @"create table if not exists DEVICE(name text primary key, imageName text)";
    if (![db executeUpdate:DeviceTable]) {
        NSLog(@"Could not creatDeviceTable!");
       // return;
    }
    
    NSString *BrandTable = @"create table if not exists BRAND(device text, brandEnglishName text, brandChineseName text)";
    if (![db executeUpdate:BrandTable]) {
        NSLog(@"Could not creatBrandTable!");
       // return;
    }
    
    
    NSString *DeviceAndBrandAndButtonKeyTable = @"create table if not exists CODE(device text, brand text, buttonKey text, userCode integer, dataCode integer)";
    if (![db executeUpdate:DeviceAndBrandAndButtonKeyTable]) {
        NSLog(@"Could not createCodeTable!");
       // return;
    }
    
    
}
+(void) insertDeviceData{
 
    NSString * insertDevieTable = @"insert into DEVICE(name, imageName) values(?,?)";
    
    if (![db executeUpdate:insertDevieTable, @"TV", @"img_device_tv"]) {
        NSLog(@"Could not insertDevieTable");
       // return;
    }
    
    if (![db executeUpdate:insertDevieTable, @"DVD", @"img_device_dvd"]) {
        NSLog(@"Could not insertDevieTable");
       // return;
    }
    if (![db executeUpdate:insertDevieTable, @"LIGHT", @"img_device_light"]) {
        NSLog(@"Could not insertDevieTable");
       // return;
    }
 

}
+(void) insertBrandData{
    
    NSString * insertBrandTable = @"insert into BRAND(device, brandEnglishName, brandChineseName) values(?,?,?)";
    
    if (![db executeUpdate:insertBrandTable, @"TV", @"AUX", @"奥克斯"]) {
        NSLog(@"Could not insertBrandTable");
        // return;
    }
    
    if (![db executeUpdate:insertBrandTable, @"TV", @"AUX2", @"img_device_dvd"]) {
        NSLog(@"Could not insertBrandTable");
        //return;
    }
    if (![db executeUpdate:insertBrandTable, @"DVD", @"XUX", @"img_device_light"]) {
        NSLog(@"Could not insertBrandTable");
        // return;
    }
    
    if (![db executeUpdate:insertBrandTable, @"DVD", @"AUX", @"img_device_light"]) {
        NSLog(@"Could not insertBrandTable");
        // return;
    }
}
+(void) insertCodeData{
    
    
    NSString *insertCodeTable = @"insert into CODE(device, brand, buttonKey, userCode, dataCode) values(?,?,?,?,?)";
    if (![db executeUpdate:insertCodeTable, @"TV",@"AUX",@"UP", [NSNumber numberWithInt:0], [NSNumber numberWithInt:0]]) {
        NSLog(@"Coud not insertCodeTable");
        // return;
    }
    
    if (![db executeUpdate:insertCodeTable, @"TV2",@"AUX2",@"UP", [NSNumber numberWithInt:0], [NSNumber numberWithInt:0]]) {
        NSLog(@"Coud not insertCodeTable");
        // return;
    }
    
    if (![db executeUpdate:insertCodeTable, @"TV3",@"AUX3",@"UP", [NSNumber numberWithInt:0], [NSNumber numberWithInt:0]]) {
        NSLog(@"Coud not insertCodeTable");
        // return;
    }
    

}
+(NSMutableArray *)getDevice {
    NSString *fileName = [self dataFilePath];
    db = [FMDatabase databaseWithPath:fileName];
    if (![db open]) {
        NSLog(@"Could not open db in get!");
        return nil;
    }
    NSString *selectDevice = @"select * from DEVICE";
    FMResultSet *set = [db executeQuery:selectDevice];
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    while ([set next]) {
        NSString *name = [set stringForColumn:@"name"];
        NSString *imageName = [set stringForColumn:@"imageName"];
        [ret addObject: [DeviceItem initWithName:name andImageName:imageName]];
    }
    [db close];
    return ret;
}
+(NSMutableArray *) getBrandWithDevice:(NSString *)device{
    NSString *fileName = [self dataFilePath];
    db = [FMDatabase databaseWithPath:fileName];
    if (![db open]) {
        NSLog(@"Could not open db!");
        return nil;
    }
    NSMutableArray *ret = [[NSMutableArray alloc] init];
    NSMutableArray *brandItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < 26; i++) {
        [brandItems removeAllObjects];
        //NSString *selectBrand = [NSString stringWithFormat:@"select * from BRAND"];
        NSString *selectBrand = [NSString stringWithFormat:@"select * from BRAND where device == '%@' and brandEnglishName like '%c%%'", device, 'A' +i];
        //NSLog(selectBrand);
        FMResultSet *set = [db executeQuery:selectBrand];
        while ([set next]) {
            NSString *englishName = [set stringForColumn:@"brandEnglishName"];
            NSString *chineseName = [set stringForColumn:@"brandChineseName"];
            [brandItems addObject:[BrandItem initWithEnglishName:englishName andChineseName:chineseName]];
        }
        if (brandItems.count != 0) {
            [ret addObject: [BrandItemGroup initWithName: [NSString stringWithFormat:@"%c", 'A'+i] andBrandItems: brandItems]];
        }
    }
    return ret;
}
+(TwoCode *) getCodeWithDevice:(NSString *)device andBrand:(NSString *)brand andButtonKey:(NSString *)buttonKey{
    NSString *fileName = [self dataFilePath];
    db = [FMDatabase databaseWithPath:fileName];
    if (![db open]) {
        NSLog(@"Could not open db!");
        return nil;
    }
    
    NSString *selectCode = [NSString stringWithFormat:@"select * from CODE where device == '%@' and brand == '%@' and buttonKey == '%@'", device, brand, buttonKey];
    FMResultSet *set = [db executeQuery:selectCode];
    TwoCode * ret = nil;
    if ([set next]) {
        ret = [TwoCode initWithUserCode:[set intForColumn:@"userCode"] andDataCode:[set intForColumn:@"dataCode"]];
    }else {
        NSLog(@"no data for device = %@ brand = %@ buttonKey = %@", device, brand, buttonKey);
    }
    return ret;
}

@end


