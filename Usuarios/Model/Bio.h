//
//  Bio.h
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol Bio
@end

@interface Bio : JSONModel
@property(nonatomic, strong) NSString *mini;
@property(nonatomic, strong) NSString *full;
@end
