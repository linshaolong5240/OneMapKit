//
//  OMKConfig.h
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/3.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface OMKConfig : NSObject <NSCopying>

@property(nonatomic, copy) NSString *aMapKey;
@property(nonatomic, copy) NSString *baiduMapKey;
@property(nonatomic, copy) NSString *tencentMapKey;

@end

NS_ASSUME_NONNULL_END
