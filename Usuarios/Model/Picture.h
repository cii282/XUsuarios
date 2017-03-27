//
//  Picture.h
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol Picture
@end

@interface Picture : JSONModel

@property(nonatomic, strong) NSString *large;
@property(nonatomic, strong) NSString *medium;
@property(nonatomic, strong) NSString *thumbnail;

@end
