//
//  MainViewController.m
//  YuGiOh Card Database
//
//  Created by Jack on 4/5/16.
//  Copyright © 2016 Jack. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *searchBtn;
@property (weak, nonatomic) IBOutlet UITextField *SCCardNameText;
@property (weak, nonatomic) IBOutlet UITextField *JPCardName;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)search:(id)sender {
    UINavigationController *temp = (UINavigationController *)[super.tabBarController.viewControllers objectAtIndex:1];
    ResultViewController *tempShua = (ResultViewController *)temp.topViewController;
    tempShua.sqlStatement = @"SELECT * FROM CardData";
    
    [self.tabBarController setSelectedIndex:1];
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
