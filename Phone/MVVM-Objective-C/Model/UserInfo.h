//
//  UserInfo.h
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo : NSObject
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger perPage;
@property (nonatomic) NSInteger total;
@property (nonatomic) NSInteger totalPages;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSObject *support;
@end

@interface UserInfoData : NSObject
@property (nonatomic) NSInteger identifier;
@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSURL *avatar;
@end

NS_ASSUME_NONNULL_END
