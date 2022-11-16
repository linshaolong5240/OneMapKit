//
//  OMKAManager.h
//  OneMapKit
//
//  Created by Sauron on 2022/11/16.
//

#import "OMKManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface OMKAManager : NSObject <OMKManager>

+ (id <OMKManager>)sharesInstance;
- (void)setApiKey:(NSString *)apiKey;
- (void)setPrivacyAgreement:(BOOL)isAgree;

@end

NS_ASSUME_NONNULL_END
