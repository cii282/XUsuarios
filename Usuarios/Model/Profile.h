//
//  Profile.h
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Profile
@end

@interface Profile : JSONModel

@property(nonatomic, strong) NSString *background_image;
@end
