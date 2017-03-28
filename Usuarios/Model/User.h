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
#import "Location.h"
#import "Profile.h"

@protocol User
@end

@protocol Bio;
@protocol Name;
@protocol Picture;
@protocol Location;
@protocol Profile;

@interface User : JSONModel

@property(nonatomic, strong) NSNumber *avg_customer;
@property(nonatomic, strong) Bio *bio;
@property(nonatomic, strong) Picture *picture;
@property(nonatomic, strong) NSNumber *userId;
@property(nonatomic, strong) Name *name;
@property(nonatomic, strong) NSString *nat;
@property(nonatomic, strong) NSString *cell;
@property(nonatomic, strong) NSString *email;
@property(nonatomic, strong) Location *location;
@property(nonatomic, strong) Profile *profile;

@end
