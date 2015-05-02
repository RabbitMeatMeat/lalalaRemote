//
//  DeviceTableViewController.m
//  lalala
//
//  Created by Rabbit.Meat on 15/5/1.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import "DeviceTableViewController.h"
#import "BrandTableViewController.h"
#import "Information.h"
#import "LalalaDataBase.h"
#import "DeviceItem.h"
#define dTopBottomMargins 20

NSString * const dIconName = @"IconName";
NSString * const dIconDescription = @"IconDescription";
NSString * const dIconCellHeight = @"dIconCellHeight";

@interface DeviceTableViewController ()
@property (nonatomic, strong) NSMutableArray * deviceIcons;
@end

@implementation DeviceTableViewController

- (void) addData{
    self.deviceIcons = [LalalaDataBase getDevice];
    NSLog(@"%d +++++", self.deviceIcons.count);
    /*
    self.deviceIcons = @[
                         @{  dIconName: @"img_device_tv",
                             dIconDescription: @"TV",
                             dIconCellHeight: @(60)},
                         
                         @{  dIconName: @"img_device_dvd",
                             dIconDescription: @"DVD",
                             dIconCellHeight: @(60)},
                         
                         @{  dIconName: @"img_device_air_condition",
                             dIconDescription: @"Air Condition",
                             dIconCellHeight: @(60)},
                         
                             ];
     */
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self addData];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Table view data source
/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 0;
}
*/

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60 + dTopBottomMargins;
}
//UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.deviceIcons.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"deviceCellID" forIndexPath:indexPath];
    cell.detailTextLabel.numberOfLines = 0;
    cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    DeviceItem * deviceItem = [self.deviceIcons objectAtIndex:indexPath.row];
    
    NSString *iconName = deviceItem.imageName;
    NSString *iconPath = [[NSBundle mainBundle] pathForResource:iconName ofType:@"png"];
    cell.imageView.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:iconPath] scale: 1];
    cell.textLabel.text = deviceItem.name;
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"brandTableViewSegue"]) {
        BrandTableViewController *destination = (BrandTableViewController *)[segue destinationViewController];
        NSIndexPath *selectedIndexPath = [self.tableView indexPathForCell:sender];
        DeviceItem *devieItem = [self.deviceIcons objectAtIndex:selectedIndexPath.row];
        destination.information = [Information initWithDevice: devieItem.name andBrand:@"" andButtonKey:@""];
        NSLog(@"1 %@",destination.information.device);
    }
}


@end
