//
//  User.m
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import "User.h"

@implementation User
+(JSONKeyMapper*)keyMapper
{
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                       @"bio": @"bio",
                                                       @"picture": @"picture",
                                                       @"userId": @"id",
                                                       @"name":@"name",
                                                       @"nat":@"nat",
                                                       @"avg_customer":@"avg_customer"
                                                       }];
    
}
@end
