//
//  OMKConfig.m
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/3.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import "OMKConfig.h"

@implementation OMKConfig

- (instancetype)init {
    self = [super init];
    if (self) {
        _aMapKey = @"";
        _baiduMapKey = @"";
        _tencentMapKey = @"";
    }
    return self;
}

- (nonnull id)copyWithZone:(nullable NSZone *)zone {
    id copy = [[self class] allocWithZone:zone];
    [copy setAMapKey:self.aMapKey];
    [copy setBaiduMapKey:self.baiduMapKey];
    [copy setTencentMapKey:self.tencentMapKey];
    return copy;
}

@end
