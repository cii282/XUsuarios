//
//  UploadImageRequest.h
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UploadImageRequest : JSONModel

@property(nonatomic, strong) NSString *image;
@end
