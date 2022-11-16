//
//  OMKBPolyline.h
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/15.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "OMKPolylineOverlay.h"

NS_ASSUME_NONNULL_BEGIN

@interface OMKBPolyline : BMKPolyline <OMKPolylineOverlay>

@end

NS_ASSUME_NONNULL_END
