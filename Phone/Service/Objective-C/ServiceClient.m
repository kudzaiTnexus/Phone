//
//  ServiceClient.m
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

#import "ServiceClient.h"

@implementation ServiceClient

- (void)getWithURLString:(NSString *)urlString completion:(ServiceClientCompletion)completion {
    // Create a NSURL from the string
    NSURL *url = [NSURL URLWithString:urlString];
    if (!url) {
        if (completion) {
            NSError *error = [NSError errorWithDomain:@"NetworkClientErrorDomain"
                                                 code:-1
                                             userInfo:@{NSLocalizedDescriptionKey: @"Invalid URL"}];
            completion(nil, error);
        }
        return;
    }
    
    // Create a NSURLSessionDataTask to perform the request
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:url
                                                             completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            if (completion) {
                completion(nil, error);
            }
            return;
        }
        
        NSError *jsonError;
        id responseObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        
        // Execute the completion handler on the main thread
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completion) {
                if (jsonError) {
                    completion(nil, jsonError);
                } else {
                    completion(responseObject, nil);
                }
            }
        });
    }];
    
    // Start the task
    [task resume];
}

@end
