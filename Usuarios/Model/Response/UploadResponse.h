//
//  UploadResponse.h
//  Usuarios
//
//  Created by Patricia Carvalho on 28/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import <JSONModel/JSONModel.h>
@protocol UploadResponse
@end

@interface UploadResponse : JSONModel

@property (nonatomic, strong) NSNumber *ok;
@end
