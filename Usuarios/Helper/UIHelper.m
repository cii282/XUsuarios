//
//  UIHelper.m
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import "UIHelper.h"
#import <SVProgressHUD/SVProgressHUD.h>

@implementation UIHelper

+ (UIHelper *)sharedInstance {
    
    static UIHelper *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[UIHelper alloc] init];
    });
    
    return _sharedManager;
}

+(NSData *)imageToNSData:(UIImage *)image
{
    NSData *imageData = UIImagePNGRepresentation(image);
    return imageData;
}

+(void)showProgress{
    
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD show];
    
}

+(void)hideProgress{
    
    [SVProgressHUD dismiss];
}

- (void)mostrarAlerta:(NSString *)titulo mensagem:(NSString *)mensagem delegate:(id)delegate {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:titulo message:mensagem delegate:delegate cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alertView show];
}

-(int)sizeText:(UILabel *)label{
    CGSize constraint = CGSizeMake(label.frame.size.width, CGFLOAT_MAX);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    return size.height;
}

@end
