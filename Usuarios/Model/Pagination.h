//
//  Pagination.h
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol Pagination
@end
@interface Pagination : JSONModel


@property(nonatomic, strong) NSNumber *limit;
@property(nonatomic, strong) NSNumber *start;

@end
