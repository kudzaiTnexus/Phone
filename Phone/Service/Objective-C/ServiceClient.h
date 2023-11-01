//
//  ServiceClient.h
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

#import <Foundation/Foundation.h>

typedef void (^ServiceClientCompletion)(id _Nullable responseObject, NSError * _Nullable error);

NS_ASSUME_NONNULL_BEGIN

@interface ServiceClient : NSObject

- (void)getWithURLString:(NSString *)urlString completion:(ServiceClientCompletion)completion;

@end

NS_ASSUME_NONNULL_END
