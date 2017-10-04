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
    
    QueryBuilder *qb=[[QueryBuilder alloc] init];
    [[qb select:@"*"] from:@"CardData"];
    if (![_SCCardNameText.text isEqualToString:@""]) {
        [qb andWhere:@"SCCardName like \"%:scname%\"" withParams: [NSDictionary dictionaryWithObjectsAndKeys:_SCCardNameText.text, @":scname", nil]];
    }
    if (![_JPCardName.text isEqualToString:@""]) {
        [qb andWhere:@"JPCardName like \"%:jpname%\"" withParams: [NSDictionary dictionaryWithObjectsAndKeys:_JPCardName.text, @":jpname", nil]];
    }
    //tempShua.sqlStatement = [NSString stringWithFormat:@"SELECT * FROM CardData %@", [qb getWhereStatement]];
    tempShua.sqlStatement = [qb getSQL];
    NSLog(@"%@", tempShua.sqlStatement);
    
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
