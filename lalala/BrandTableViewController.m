//
//  BrandTableViewController.m
//  lalala
//
//  Created by Rabbit.Meat on 15/5/1.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import "BrandTableViewController.h"
#import "BrandItem.h"
#import "BrandItemGroup.h"
#import "RemoteViewController.h"
#import "LalalaDataBase.h"

NSMutableArray *brandItems;

@interface BrandTableViewController () <UITableViewDataSource>


@end

@implementation BrandTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    
}

-(void) initData{
    brandItems = [LalalaDataBase getBrandWithDevice:self.information.device];
    
    NSLog(@"%d -----", brandItems.count);
    
    
   /* brandItems = [[NSMutableArray alloc] init];
    
    BrandItem *brandItem1 = [BrandItem initWithEnglishName:@"AUX" andChineseName:@"奥克斯"];
    BrandItem *brandItem2 = [BrandItem initWithEnglishName:@"AUX2" andChineseName:@"奥克斯2"];
    BrandItem *brandItem3 = [BrandItem initWithEnglishName:@"AUX3" andChineseName:@"奥克斯3"];
    BrandItemGroup *group1 = [BrandItemGroup initWithName:@"A" andBrandItems:[NSMutableArray arrayWithObjects:brandItem1,brandItem2,brandItem3,nil]];
    [brandItems addObject:group1];
    
    BrandItem *brandItem4 = [BrandItem initWithEnglishName:@"XUX" andChineseName:@"奥克斯"];
    BrandItem *brandItem5 = [BrandItem initWithEnglishName:@"XUX2" andChineseName:@"奥克斯2"];
    BrandItem *brandItem6 = [BrandItem initWithEnglishName:@"XUX3" andChineseName:@"奥克斯3"];
    BrandItemGroup *group2 = [BrandItemGroup initWithName:@"X" andBrandItems:[NSMutableArray arrayWithObjects:brandItem4,brandItem5,brandItem6,nil]];
    [brandItems addObject:group2];
    
    BrandItem *brandItem7 = [BrandItem initWithEnglishName:@"BUX" andChineseName:@"奥克斯"];
    BrandItem *brandItem8 = [BrandItem initWithEnglishName:@"BUX2" andChineseName:@"奥克斯2"];
    BrandItem *brandItem9 = [BrandItem initWithEnglishName:@"BUX3" andChineseName:@"奥克斯3"];
    BrandItemGroup *group3 = [BrandItemGroup initWithName:@"B" andBrandItems:[NSMutableArray arrayWithObjects:brandItem7,brandItem8,brandItem9,nil]];
    [brandItems addObject:group3];
    
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return brandItems.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    BrandItemGroup * group = brandItems[section];
    return group.brandItems.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"brandCellID" forIndexPath:indexPath];
    
    BrandItemGroup *group = brandItems[indexPath.section];
    BrandItem *brandItem = group.brandItems[indexPath.row];
    
    cell.textLabel.text = brandItem.englishName;
    cell.detailTextLabel.text = brandItem.chineseName;
    
    return cell;
}

//分组标题
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    BrandItemGroup *group = brandItems[section];
    return group.name;
    
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"remoteViewSegue"]) {
        RemoteViewController *destination = (RemoteViewController *)[segue destinationViewController];
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:sender];
        BrandItemGroup *group = brandItems[selectedIndexPath.section];
        BrandItem *brandItem = group.brandItems[selectedIndexPath.row];
        destination.information = [Information initWithDevice:self.information.device andBrand:brandItem.englishName andButtonKey: @""];
        NSLog(@"2 %@ %@",destination.information.device, destination.information.brand);
    }
}


@end
