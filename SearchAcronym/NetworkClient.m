//
//  NetworkClient.m
//  SearchAcronym
//
//  Created by Chaitanya Kumar on 3/5/16.
//  Copyright © 2016 Chaitanya Kumar. All rights reserved.
//

#import "NetworkClient.h"

@implementation NetworkClient

+ (NetworkClient *) sharedInstance {
    static NetworkClient *sharedInstance = nil;
    static dispatch_once_t token;
    
    dispatch_once(&token, ^{
        sharedInstance = [[NetworkClient alloc] init];
    });
    
    return sharedInstance;
}

- (instancetype)init {
    
    self = [super init];
    if (!self) {
        return nil;
    }
    
    self.responseSerializer = [AFJSONResponseSerializer serializer];
    self.requestSerializer = [AFJSONRequestSerializer serializer];
    return self;
}

-(void)getResponseForURLString:(NSString *)urlString Parameters:(NSDictionary *)parameters success:(Success)success failure:(Failure)failure {
    self.responseSerializer.acceptableContentTypes = nil;
    
    [self GET:urlString parameters:parameters success:^(NSURLSessionDataTask *task, id responseObject){
       if (success) {
            success(task, [self parseResponseObject:responseObject]);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

-(Acronym *) parseResponseObject:(id) responseObject {
    
    if([responseObject isKindOfClass:[NSArray class]] && [responseObject count] > 0 ){
        for(NSDictionary* _dict in responseObject){
            
            // even though response object is of type array, we are just capturing 1st object as the response of this web service always has just one object for acronym and its corresponding meanings.
            
            Acronym* _acronym = [[Acronym alloc] init];
            [_acronym setAbbreviation:[_dict objectForKey:@"sf"]];
            [_acronym setMeanings:[self getMeanings:[_dict objectForKey:@"lfs"]]];
            return _acronym;
        }
        
    }
    return nil;
}

-(NSMutableArray *) getMeanings:(NSMutableArray *) responseArray {
    NSMutableArray* _meaningsArray = [NSMutableArray array];
    for(NSDictionary* _dict in responseArray){
        
        Meaning* _meaning = [[Meaning alloc] init];
        [_meaning setMeaning: [_dict objectForKey:@"lf"]] ;
        [_meaningsArray addObject:_meaning];
    }
    return _meaningsArray;
}

@end
