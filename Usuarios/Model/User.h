//
//  User.h
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "Bio.h"
#import "Name.h"
#import "Picture.h"

@protocol User
@end

@protocol Bio;
@protocol Name;
@protocol Picture;

@interface User : JSONModel

@property(nonatomic, strong) NSNumber *avg_customer;
@property(nonatomic, strong) Bio *bio;
@property(nonatomic, strong) Picture *picture;
@property(nonatomic) NSInteger *user_id;
@property(nonatomic, strong) Name *name;
@property(nonatomic, strong) NSString *nat;

@end
