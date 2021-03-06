//
//  APIClient.m
//  Usuarios
//
//  Created by Patricia Carvalho on 27/03/17.
//  Copyright © 2017 Patricia Carvalho. All rights reserved.
//

#import "APIClient.h"


NSString *const APIBaseURL = @"https://testmobiledev.eokoe.com/";

NSString *const XAPIKey = @"d4735e3a265e16eee03f59718b9b5d03019c07d8b6c51f90da3a666eec13ab35";

int const kErrorUnauthorized = 401;

//Localized Strings
NSString *const serverDown = @"ServerDown";
NSString *const badCredentials = @"BadCredentials";

NSString *const APIMeusCupons = @"Cupom/ObterMeusCupons";

@implementation APIClient

- (instancetype)init {
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    self = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURL] sessionConfiguration:configuration];
    if(self){
        
        [self setRequestSerializer:[AFJSONRequestSerializer serializer]];
       // [self setResponseSerializer:[AFJSONRequestSerializer serializer]];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:XAPIKey forHTTPHeaderField:@"X-API-Key"];
        
    }
    return self;
    
}

-(NSURLSessionDataTask *)listUsers:(int)start andLimit:(int)limit completion:(void (^)(UsersResponse *response, NSString *errorMessage))completion{
    
    NSURLSessionDataTask *task = [self GETWithLogParams:[NSString stringWithFormat:@"%@?start=%d&limit=%d", @"users",start,limit] parameters:[NSDictionary new]
                                                success:^(NSURLSessionDataTask *task, id responseObject) {
                                                    NSError *error;
                                                    
                                                    UsersResponse *usersResponse = [[UsersResponse alloc] initWithDictionary:responseObject error:&error];
                                                    if (error)
                                                        completion(nil, NSLocalizedString(serverDown, nil));
                                                    else {
                                                        completion(usersResponse, nil);
                                                    }
                                                    
                                                } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                    
                                                    if (((NSHTTPURLResponse *) [task response]).statusCode == kErrorUnauthorized) {
                                                        completion(nil, NSLocalizedString(badCredentials, nil));
                                                    } else {
                                                        completion(nil, NSLocalizedString(serverDown, nil));
                                                    }
                                                }];
    
    return task;
    
}


- (NSURLSessionDataTask *)userDetail:(NSNumber *)userId completion:(void (^)(User *response, NSString *errorMessage))completion{
    
    NSURLSessionDataTask *task = [self GETWithLogParams:[NSString stringWithFormat:@"user/%@",userId] parameters:[NSDictionary new]
                                                 success:^(NSURLSessionDataTask *task, id responseObject) {
                                                     
                                                     NSError *error;
                                                     User *detailsResponse = [[User  alloc] initWithDictionary:responseObject error:&error];
                                                     
                                                     if (error)
                                                         completion(nil, NSLocalizedString(serverDown, nil));
                                                     else {

                                                         completion(detailsResponse, nil);
                                                     }
                                                     
                                                     
                                                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                                     
                                                     if (((NSHTTPURLResponse *) [task response]).statusCode == kErrorUnauthorized) {
                                                         completion(nil, NSLocalizedString(badCredentials, nil));
                                                     } else {
                                                         completion(nil, NSLocalizedString(serverDown, nil));
                                                     }
                                                 }];
    
    return task;
    
}


- (NSURLSessionDataTask *) sendImage:(NSData*)request completion:(void (^)(UploadResponse *response, NSString* errorMessage)) completion{
    
    
    //NSDictionary *parametros = [request toDictionary];
    NSDictionary *paramet = [NSDictionary new];
    id block = ^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:request
                                    name:@"image"
                                fileName:@"image.png"
                                mimeType:@"image/png"];
    };
    
    NSURLSessionDataTask *task = [self POST:@"upload" parameters:paramet constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSError *error;
        
        UploadResponse *uploadResponse = [[UploadResponse  alloc] initWithDictionary:responseObject error:&error];
        
        if (error)
            completion(nil, NSLocalizedString(serverDown, nil));
        else {
            
            completion(uploadResponse, nil);
        }
        
    }  failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (((NSHTTPURLResponse *) [task response]).statusCode == kErrorUnauthorized) {
            completion(nil, NSLocalizedString(badCredentials, nil));
        } else {
            completion(nil, NSLocalizedString(serverDown, nil));
        }
    }];
    
    return task;
}


+ (APIClient *)sharedManager {
    static APIClient *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        _sharedManager = [[APIClient alloc] initWithBaseURL:[NSURL URLWithString:APIBaseURL] sessionConfiguration:configuration];
        [self configClient:_sharedManager];
    });
    
    return _sharedManager;
}


+ (void)configClient:(APIClient *)_sharedManager {
    [_sharedManager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [_sharedManager setResponseSerializer:[AFJSONResponseSerializer serializer]];
    [_sharedManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [_sharedManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [_sharedManager.requestSerializer setValue:XAPIKey forHTTPHeaderField:@"X-API-Key"];
}





- (NSURLSessionDataTask *)POSTWithLogParams:(NSString *)URLString
                                 parameters:(NSDictionary *)parameters
                                    success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                    failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    NSURLSessionDataTask *task = [self POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
                                         
                                         NSLog(@"Response Dictionary :%@", responseObject);
                                         
                                         success(task, responseObject);
                                     } failure:^(NSURLSessionDataTask *task, NSError *error) {
                                         
                                         
#if DEBUG
                                         NSLog(@"%@", error);
#endif
                                         
                                         failure(task, error);
                                                                         }];
    
    return task;
    
}

- (NSURLSessionDataTask *)GETWithLogParams:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
                                   success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
                                   failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure {
    
    
    for (NSString *key in parameters.allKeys) {
        
        URLString = [URLString stringByAppendingString:[NSString stringWithFormat:@"/%@/%@", key, parameters[key]]];
        
    }
    
#if DEBUG
    NSError *errorAutentication;
    NSData *jsonDataAutentication = [NSJSONSerialization dataWithJSONObject:parameters options:0 error:&errorAutentication];
    if (!errorAutentication) {
        NSLog(@"GET URL :%@ >>>>>>>>>>>>> Json params:%@", URLString, [[NSString alloc] initWithData:jsonDataAutentication encoding:NSUTF8StringEncoding]);
    }
#endif
    
    NSURLSessionDataTask *task = [self GET:URLString parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"Response Dictionary :%@", responseObject);
        success(task, responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
#if DEBUG
        NSLog(@"%@", error);
#endif
        
        failure(task, error);
    }];
    
    return task;
    
}

//- (NSURLSessionDataTask *)POSTT:(NSString *)URLString
//                    parameters:(id)parameters
//     constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block
//                       success:(void (^)(NSURLSessionDataTask *task, id responseObject))success
//                       failure:(void (^)(NSURLSessionDataTask *task, NSError *error))failure
//{
//    NSError *serializationError = nil;
//    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:&serializationError];
//    if (serializationError) {
//        if (failure) {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wgnu"
//            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
//                failure(nil, serializationError);
//            });
//#pragma clang diagnostic pop
//        }
//        
//        return nil;
//    }
//    
//    __block NSURLSessionDataTask *task = [self uploadTaskWithStreamedRequest:request progress:nil completionHandler:^(NSURLResponse * __unused response, id responseObject, NSError *error) {
//        if (error) {
//            if (failure) {
//                failure(task, error);
//            }
//        } else {
//            if (success) {
//                success(task, responseObject);
//            }
//        }
//    }];
//    
//    [task resume];
//    
//    return task;
//}

@end
