//
//  OCUserViewModel.m
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

#import "OCUserViewModel.h"

@interface OCUserViewModel ()
@property (nonatomic, strong) id<NetworkService> networkService;
@end

@implementation OCUserViewModel

- (instancetype)initWithNetworkService:(id<NetworkService>)service {
    self = [super init];
    if (self) {
        _networkService = service;
    }
    return self;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    [self.networkService loginWithUsername:username password:password completion:^(RootResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            [self.delegate userViewModelDidUpdateLogin:response];
        } else {
            [self.delegate userViewModelDidFailWithError:error];
        }
    }];
}

- (void)fetchEmployees {
    [self.networkService employeesWithCompletion:^(UserInfo * _Nullable response, NSError * _Nullable error) {
        if (response) {
            [self.delegate userViewModelDidUpdateEmployees:response.data];
        } else {
            [self.delegate userViewModelDidFailWithError:error];
        }
    }];
}

- (void)fetchTeamMembers {
    [self.networkService teamMembersWithCompletion:^(UserInfo * _Nullable response, NSError * _Nullable error) {
        if (response) {
            [self.delegate userViewModelDidUpdateTeamMembers:response.data];
        } else {
            [self.delegate userViewModelDidFailWithError:error];
        }
    }];
}

- (void)fetchColors {
    [self.networkService colorsWithCompletion:^(RootResponse * _Nullable response, NSError * _Nullable error) {
        if (response) {
            [self.delegate userViewModelDidUpdateColors:response.data];
        } else {
            [self.delegate userViewModelDidFailWithError:error];
        }
    }];
}

@end
