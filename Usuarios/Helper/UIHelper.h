//
//  UIHelper.h
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIHelper : NSObject

+ (UIHelper *)sharedInstance;

-(int)sizeText:(UILabel *)label;

+ (void)showProgress;

+ (void)hideProgress;

+(NSString *)imageToNSString:(UIImage *)image;

@end
