//
//  OMKTencentMapView.h
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/4.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMKMapViewProvider.h"
#import "OMKQManager.h"
//Annotation
#import "OMKQBubbleAnnotation.h"
#import "OMKQCustomerLocationAnnotation.h"
#import "OMKQEmployeeLocationAnnotation.h"
//Overlay
#import "OMKQCircle.h"
#import "OMKQPolyline.h"

NS_ASSUME_NONNULL_BEGIN

@interface OMKTencentMapView : UIView <OMKMapViewProvider>

@property(nonatomic, weak) id <OMKMapViewDelegate> delegate;

@property (nonatomic, assign) BOOL showsUserLocation;
@property(nonatomic, assign) OMKUserTrackingMode userTrackingMode;

@end

NS_ASSUME_NONNULL_END
