//
//  ResultViewController.m
//  YuGiOh Card Database
//
//  Created by Jack on 4/5/16.
//  Copyright © 2016 Jack. All rights reserved.
//

#import "ResultViewController.h"

@interface ResultViewController ()
@property NSMutableArray *result;
@end

@implementation ResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _result=[[NSMutableArray alloc] init];
}

-(void)viewDidAppear:(BOOL)animated{
    [_result removeAllObjects];
    sqlite3 *db;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documents = [paths objectAtIndex:0];
    NSString *database_path = [documents stringByAppendingPathComponent:@"OcgData.sqlite3"];
    //NSLog(@"%@",database_path);
    
    if (sqlite3_open([database_path UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSLog(@"数据库打开失败");
    }
    
    sqlite3_stmt * statement;
    //_sqlStatement=[_sqlStatement stringByAppendingFormat:@" limit %ld,20",(_page-1)*20];
    
    if (sqlite3_prepare_v2(db, [_sqlStatement UTF8String], -1, &statement, nil) == SQLITE_OK) {
        while (sqlite3_step(statement) == SQLITE_ROW) {
            int cardID=sqlite3_column_int(statement, 0);
            
            char *tmp = (char*)sqlite3_column_text(statement, 3);
            NSString *scName = [[NSString alloc]initWithUTF8String:tmp];
            	
            tmp = (char*)sqlite3_column_text(statement, 2);
            NSString *jpName = [[NSString alloc]initWithUTF8String:tmp];
            
            NSMutableDictionary *card=[[NSMutableDictionary alloc] init];
            
            [card setValue:[NSNumber numberWithInt:cardID]  forKey:@"id"];
            [card setValue:scName forKey:@"scName"];
            [card setValue:jpName forKey:@"jpName"];
            
            [_result addObject:card];
            
            //NSLog(@"id:%d  中文名:%@  日文名:%@",cardID,scName, jpName);
        }
    }
    sqlite3_close(db);
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//warning Incomplete implementation, return the number of rows
    return _result.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    NSMutableDictionary *card=[_result objectAtIndex:indexPath.row];
    cell.textLabel.text=[card valueForKey:@"scName"];
    // Configure the cell...
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
