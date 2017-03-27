//
//  APIClient.h
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//
#import <AFNetworking/AFNetworking.h>
#import "UsersResponse.h"

@interface APIClient : AFHTTPSessionManager

+ (APIClient *)sharedManager;
- (NSURLSessionDataTask *)listUsers:(int)start andLimit:(int)limit completion:(void (^)(UsersResponse *response, NSString *errorMessage))completion;

@end
