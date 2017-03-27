//
//  UsersResponse.h
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Pagination.h"
#import "User.h"

@protocol User;
@protocol Pagination;

@interface UsersResponse : JSONModel

@property(nonatomic, strong) Pagination *pagination;
@property(nonatomic, strong) NSArray<User> *results;

@end
