//
//  OMKManager.h
//  OneMapKit
//
//  Created by Sauron on 2022/11/3.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OMKManager <NSObject>

+ (id <OMKManager>)sharesInstance;
- (void)setApiKey:(NSString *)apiKey;
- (void)setPrivacyAgreement:(BOOL)isAgree;

@end

NS_ASSUME_NONNULL_END
