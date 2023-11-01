//
//  NetworkService.h
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

#import <Foundation/Foundation.h>
#import "RootResponse.h"
#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^LoginCompletion)(RootResponse * _Nullable response, NSError * _Nullable error);
typedef void (^UserCompletion)(UserInfo * _Nullable response, NSError * _Nullable error);

extern NSString * const BaseURLKey;
extern NSString * const LoginEndpointKey;
extern NSString * const EmployeesEndpointKey;
extern NSString * const ColorsEndpointKey;
extern NSString * const TeamMembersEndpointKey;

@protocol NetworkService <NSObject>

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
               completion:(LoginCompletion)completion;

- (void)employeesWithCompletion:(UserCompletion)completion;

- (void)teamMembersWithCompletion:(UserCompletion)completion;

- (void)colorsWithCompletion:(LoginCompletion)completion;

@end

NS_ASSUME_NONNULL_END
