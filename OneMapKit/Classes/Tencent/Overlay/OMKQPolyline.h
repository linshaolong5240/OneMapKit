//
//  OMKQPolyline.h
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/15.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <QMapKit/QMapKit.h>
#import "OMKPolylineOverlay.h"

NS_ASSUME_NONNULL_BEGIN

@interface OMKQPolyline : QPolyline <OMKPolylineOverlay>

@end

NS_ASSUME_NONNULL_END
