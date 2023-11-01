//
//  RootResponse.h
//  Phone
//
//  Created by KudzaisheMhou on 01/11/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RootResponse : NSObject
@property (nonatomic) NSInteger page;
@property (nonatomic) NSInteger perPage;
@property (nonatomic) NSInteger total;
@property (nonatomic) NSInteger totalPages;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSObject *support;
@end

@interface PhoneColorData : NSObject
@property (nonatomic) NSInteger identifier;
@property (nonatomic, strong) NSString *name;
@property (nonatomic) NSInteger year;
@property (nonatomic, strong) NSString *color;
@property (nonatomic, strong) NSString *pantoneValue;
@end

@interface PhoneSupport : NSObject
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSString *text;
@end

NS_ASSUME_NONNULL_END

