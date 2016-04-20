//
//  ResultViewController.h
//  YuGiOh Card Database
//
//  Created by Jack on 4/5/16.
//  Copyright © 2016 Jack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface ResultViewController : UITableViewController
@property NSString *sqlStatement;
@property NSInteger page;
@end
