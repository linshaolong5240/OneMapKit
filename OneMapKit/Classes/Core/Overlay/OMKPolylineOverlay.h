//
//  OMKPolylineOverlay.h
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/15.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import "OMKOverlay.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OMKPolylineOverlay <OMKOverlay>

/**
 * @brief 根据经纬度坐标数据生成多段线
 * @param coords 经纬度坐标数据,coords对应的内存会拷贝,调用者负责该内存的释放
 * @param count  经纬度坐标个数
 * @return 生成的多段线
 */
+ (instancetype)polylineWithCoordinates:(CLLocationCoordinate2D *)coords count:(NSUInteger)count;

@end

NS_ASSUME_NONNULL_END
