//
//  OMKCircleOverlay.h
//  ObjectiveCHelper
//
//  Created by 林少龙 on 2022/11/14.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import "OMKOverlay.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OMKCircleOverlay <OMKOverlay>

/// 半径，单位：米
@property (nonatomic, assign) CLLocationDistance radius;

/**
 * @brief 根据中心点和半径生成圆
 * @param coord  中心点的经纬度坐标，无效坐标按照{0，0}处理
 * @param radius 半径，单位：米, 负数按照0处理
 * @return 新生成的圆
 */
+ (instancetype)circleWithCenterCoordinate:(CLLocationCoordinate2D)coord
                                    radius:(CLLocationDistance)radius;

/**
 * @brief 设置圆的中心点和半径. since 5.0.0
 * @param coord 中心点的经纬度坐标，无效坐标按照{0，0}处理
 * @param radius 半径，单位：米 负数按照0处理
 * @return 是否设置成功
 */
- (BOOL)setCircleWithCenterCoordinate:(CLLocationCoordinate2D)coord radius:(CLLocationDistance)radius;

@end

NS_ASSUME_NONNULL_END
