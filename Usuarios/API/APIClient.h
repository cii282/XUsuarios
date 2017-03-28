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

@interface APIClient : AFHTTPSessionManager

+ (APIClient *)sharedManager;
- (NSURLSessionDataTask *)listUsers:(int)start andLimit:(int)limit completion:(void (^)(UsersResponse *response, NSString *errorMessage))completion;

- (NSURLSessionDataTask *)userDetail:(NSNumber *)userId completion:(void (^)(User *response, NSString *errorMessage))completion;

- (NSURLSessionDataTask *) sendImage:(UploadImageRequest*)request completion:(void (^)(NSString* errorMessage)) completion;

@end
