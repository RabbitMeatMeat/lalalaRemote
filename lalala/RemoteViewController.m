//
//  RemoteViewController.m
//  lalala
//
//  Created by Rabbit.Meat on 15/5/1.
//  Copyright (c) 2015年 Rabbit.Meat. All rights reserved.
//

#import "RemoteViewController.h"
#import "DCPathButton.h"
#import "TwoCode.h"
#import "LalalaDataBase.h"
#import "WaveService.h"
#import "GUAAlertView.h"
@interface RemoteViewController ()

@end

@implementation RemoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    DCPathButton *dcPathButton = [[DCPathButton alloc]
                                  initDCPathButtonWithSubButtons:5
                                  totalRadius:100
                                  centerRadius:40
                                  subRadius:40
                                  centerImage:@"home_selected"
                                  centerBackground:nil
                                  subImages:^(DCPathButton *dc){
                                      [dc subButtonImage:@"up_selected" withTag:0];
                                      [dc subButtonImage:@"down_selected" withTag:1];
                                      [dc subButtonImage:@"left_selected" withTag:2];
                                      [dc subButtonImage:@"power_selected" withTag:3];
                                      [dc subButtonImage:@"right_selected" withTag:4];
                                      //[dc subButtonImage:@"custom_1" withTag:5];
                                  }
                                  subImageBackground:nil
                                  inLocationX:0 locationY:0 toParentView:self.view];
    
    
    dcPathButton.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//显示提示框
-(void) showAlter{
    
    
    GUAAlertView *v = [GUAAlertView alertViewWithTitle:@"lalala"
                                               message:@"没有数据 好饿"
                                           buttonTitle:@"额"
                                   buttonTouchedAction:^{
                                       NSLog(@"button touched");
                                   } dismissAction:^{
                                       NSLog(@"dismiss");
                                   }];
    [v show];
    /*
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"No Dtad" message:@"sorry!!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    
    [alter show];
   // [alter release];
    */
}
- (void)button_0_action{
    self.information.buttonkey = @"UP";
    TwoCode *twoCode = [LalalaDataBase getCodeWithDevice:self.information.device andBrand:self.information.brand andButtonKey:self.information.buttonkey];
    if (twoCode != nil) {
        [WaveService playSoundWithUserCode:twoCode.userCode andDataCode: twoCode.dataCode];
    } else {
        [self showAlter];
    }
    
   // NSLog(@"Button Press Tag %@ %@ %@ %d %d!!",self.information.device, self.information.brand, self.information.buttonkey, twoCode.userCode, twoCode.dataCode);
    
    
    
}

- (void)button_1_action{
    self.information.buttonkey = @"DOWN";
    TwoCode *twoCode = [LalalaDataBase getCodeWithDevice:self.information.device andBrand:self.information.brand andButtonKey:self.information.buttonkey];
    
    if (twoCode != nil) {
        [WaveService playSoundWithUserCode:twoCode.userCode andDataCode: twoCode.dataCode];
    } else {
        [self showAlter];
    }

    //NSLog(@"Button Press Tag %@ %@ %@!!",self.information.device, self.information.brand, self.information.buttonkey);
}

- (void)button_2_action{
    self.information.buttonkey = @"LEFT";
    TwoCode *twoCode = [LalalaDataBase getCodeWithDevice:self.information.device andBrand:self.information.brand andButtonKey:self.information.buttonkey];
    
    if (twoCode != nil) {
        [WaveService playSoundWithUserCode:twoCode.userCode andDataCode: twoCode.dataCode];
    } else {
        [self showAlter];
    }

    //NSLog(@"Button Press Tag %@ %@ %@!!",self.information.device, self.information.brand, self.information.buttonkey);

}

- (void)button_3_action{
    self.information.buttonkey = @"POWER";
    TwoCode *twoCode = [LalalaDataBase getCodeWithDevice:self.information.device andBrand:self.information.brand andButtonKey:self.information.buttonkey];
    if (twoCode != nil) {
        [WaveService playSoundWithUserCode:twoCode.userCode andDataCode: twoCode.dataCode];
    } else {
        [self showAlter];
    }

    // NSLog(@"Button Press Tag %@ %@ %@!!",self.information.device, self.information.brand, self.information.buttonkey);

}

- (void)button_4_action{
    self.information.buttonkey = @"RIGHT";
    TwoCode *twoCode = [LalalaDataBase getCodeWithDevice:self.information.device andBrand:self.information.brand andButtonKey:self.information.buttonkey];
    if (twoCode != nil) {
        [WaveService playSoundWithUserCode:twoCode.userCode andDataCode: twoCode.dataCode];
    } else {
        [self showAlter];
    }

    //NSLog(@"Button Press Tag %@ %@ %@!!",self.information.device, self.information.brand, self.information.buttonkey);

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
