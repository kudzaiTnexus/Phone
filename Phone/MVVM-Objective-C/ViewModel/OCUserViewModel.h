//
//  OCUserViewModel.h
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import "NetworkService.h"

NS_ASSUME_NONNULL_BEGIN

// Declare a protocol for the ViewModel's delegate to handle updates
@protocol UserViewModelDelegate <NSObject>
- (void)userViewModelDidUpdateLogin:(RootResponse * _Nullable)loginResponse;
- (void)userViewModelDidUpdateEmployees:(NSArray * _Nullable)employees;
- (void)userViewModelDidUpdateTeamMembers:(NSArray * _Nullable)teamMembers;
- (void)userViewModelDidUpdateColors:(NSArray * _Nullable)colors;
- (void)userViewModelDidFailWithError:(NSError * _Nullable)error;
@end

@interface OCUserViewModel : NSObject

@property (nonatomic, weak) id<UserViewModelDelegate> delegate;

- (instancetype)initWithNetworkService:(id<NetworkService>)service;

- (void)loginWithUsername:(NSString *)username password:(NSString *)password;
- (void)fetchEmployees;
- (void)fetchTeamMembers;
- (void)fetchColors;

@end

NS_ASSUME_NONNULL_END
