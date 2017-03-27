//
//  Name.h
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@protocol Name
@end

@interface Name : JSONModel

@property(nonatomic, strong) NSString *first;
@property(nonatomic, strong) NSString *last;
@property(nonatomic, strong) NSString *title;
@end
