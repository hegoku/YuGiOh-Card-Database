//
//  QueryBuilder.m
//  YuGiOh Card Database
//
//  Created by Jack on 04/10/2017.
//  Copyright © 2017 Jack. All rights reserved.
//
#import "QueryBuilder.h"

@interface QueryBuilder ()
@property NSString *columns;
@property NSString *table;
@end

@implementation QueryBuilder
- (instancetype)init{
    self = [super init];
    if (self) {
        _whereStatement=@"";
        _columns=@"*";
    }
    return self;
}

- (void)andWhere:(NSString*) condition withParams:(NSDictionary*) params {
    if (params!=nil) {
        for (id key in params) {
            condition=[condition stringByReplacingOccurrencesOfString:key withString:[params objectForKey:key]];
        }
    }
    if ([_whereStatement isEqualToString:@""]) {
        _whereStatement=[_whereStatement stringByAppendingFormat:@"(%@)", condition];
    } else {
        _whereStatement=[_whereStatement stringByAppendingFormat:@" AND (%@)", condition];
    }
}

- (NSString*)getWhereStatement {
    if ([_whereStatement isEqualToString:@""]) {
        return @"";
    } else {
       return [NSString stringWithFormat:@" WHERE %@", _whereStatement];
    }
}

- (instancetype)select:(NSString*) columns {
    _columns=columns;
    return self;
}

- (instancetype)from:(NSString*) table {
    _table=table;
    return self;
}

- (NSString*)getSQL {
    return [NSString stringWithFormat:@"SELECT %@ FROM %@ %@", _columns, _table, [self getWhereStatement]];
}

@end
