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

- (void)mostrarAlerta:(NSString *)titulo mensagem:(NSString *)mensagem delegate:(id)delegate;

- (int)sizeText:(UILabel *)label;

+ (void)showProgress;

+ (void)hideProgress;

+(NSData *)imageToNSData:(UIImage *)image;

@end
