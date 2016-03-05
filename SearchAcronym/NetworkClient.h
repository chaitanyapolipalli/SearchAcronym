//
//  NetworkClient.h
//  SearchAcronym
//
//  Created by Chaitanya Kumar on 3/5/16.
//  Copyright © 2016 Chaitanya Kumar. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
#import "Meaning.h"
#import "Acronym.h"

typedef void (^Success)(NSURLSessionDataTask *task, Acronym *acronym);
typedef void (^Failure)(NSURLSessionDataTask *task, NSError *error);

@interface NetworkClient : AFHTTPSessionManager

+ (NetworkClient *) sharedInstance;

- (void)getResponseForURLString: (NSString *)urlString Parameters:(NSDictionary *) parameters success:(Success) success failure:(Failure) failure;

@end
