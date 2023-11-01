//
//  NetworkService.m
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

#import "NetworkService.h"
#import "RootResponse.h"
#import "UserInfo.h"
#import "ServiceClient.h"

NSString * const BaseURLKey = @"BaseURL";
NSString * const LoginEndpointKey = @"LoginEndpoint";
NSString * const EmployeesEndpointKey = @"EmployeesEndpoint";
NSString * const ColorsEndpointKey = @"ColorEndpoint";
NSString * const TeamMembersEndpointKey = @"TeamMembersEndPoint";

@interface NetworkServiceImplementation : NSObject <NetworkService>

@property (strong, nonatomic) ServiceClient *networkClient;

@end

@implementation NetworkServiceImplementation

- (instancetype)initWithNetworkClient:(ServiceClient *)networkClient {
    self = [super init];
    if (self) {
        _networkClient = networkClient;
    }
    return self;
}

- (void)loginWithUsername:(NSString *)username
                 password:(NSString *)password
               completion:(nonnull LoginCompletion)completion {
    
    NSString *baseUrl = [self endpointForKey:BaseURLKey];
    NSString *loginEndpoint = [self endpointForKey:LoginEndpointKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseUrl, loginEndpoint];
    
    [self.networkClient getWithURLString:urlString completion:completion];
}

- (void)employeesWithCompletion:(nonnull UserCompletion)completion {

    NSString *baseUrl = [self endpointForKey:BaseURLKey];
    NSString *employeeEndpoint = [self endpointForKey:EmployeesEndpointKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseUrl, employeeEndpoint];
    
    [self.networkClient getWithURLString:urlString completion:completion];
}

- (void)teamMembersWithCompletion:(nonnull UserCompletion)completion {

    NSString *baseUrl = [self endpointForKey:BaseURLKey];
    NSString *teamMembersEndpoint = [self endpointForKey:TeamMembersEndpointKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseUrl, teamMembersEndpoint];
    
    [self.networkClient getWithURLString:urlString completion:completion];
}

- (void)colorsWithCompletion:(nonnull UserCompletion)completion {
    
    NSString *baseUrl = [self endpointForKey:BaseURLKey];
    NSString *colorsEndpoint = [self endpointForKey:ColorsEndpointKey];
    NSString *urlString = [NSString stringWithFormat:@"%@%@", baseUrl, colorsEndpoint];
    
    [self.networkClient getWithURLString:urlString completion:completion];
}

- (NSString *)endpointForKey:(NSString *)key {
    return [[NSBundle mainBundle] infoDictionary][key];
}

@end
