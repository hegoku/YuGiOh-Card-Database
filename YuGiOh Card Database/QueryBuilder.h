//
//  QueryBuilder.h
//  YuGiOh Card Database
//
//  Created by Jack on 04/10/2017.
//  Copyright © 2017 Jack. All rights reserved.
//
#import <Foundation/Foundation.h>

@interface QueryBuilder:NSObject
@property NSString *whereStatement;

- (instancetype)select:(NSString*) columns;
- (instancetype)from:(NSString*) table;
-(void)andWhere:(NSString*) condition withParams:(NSDictionary*) params;
- (NSString*)getWhereStatement;
- (NSString*)getSQL;
@end
