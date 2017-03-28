//
//  APIClient.h
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import "UsersResponse.h"
#import "UploadImageRequest.h"
#import "UploadResponse.h"

@interface APIClient : AFHTTPSessionManager

+ (APIClient *)sharedManager;
- (NSURLSessionDataTask *)listUsers:(int)start andLimit:(int)limit completion:(void (^)(UsersResponse *response, NSString *errorMessage))completion;

- (NSURLSessionDataTask *)userDetail:(NSNumber *)userId completion:(void (^)(User *response, NSString *errorMessage))completion;

- (NSURLSessionDataTask *) sendImage:(NSData
                                      *)request completion:(void (^)(UploadResponse * response, NSString* errorMessage)) completion;

- (void)uploadImage:(UIImage*)image withImageName:(NSString*)imageName andParams:(NSDictionary*)paramsDict;
@end
