//
//  OMKAMapView.h
//  OneMapKit
//
//  Created by Sauron on 2022/11/4.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMKMapViewProvider.h"
#import "OMKAManager.h"
//Annotation
#import "OMKABubbleAnnotation.h"
#import "OMKACustomerLocationAnnotation.h"
#import "OMKAEmployeeLocationAnnotation.h"
//Overlay
#import "OMKACircle.h"
#import "OMKAPolyline.h"

NS_ASSUME_NONNULL_BEGIN

@interface OMKAMapView : UIView <OMKMapViewProvider>

@property(nonatomic, weak) id <OMKMapViewDelegate> delegate;

@property (nonatomic, assign) CLLocationCoordinate2D centerCoordinate;
@property (nonatomic, assign) CGFloat zoomLevel;
@property (nonatomic, assign) CGFloat minZoomLevel;
@property (nonatomic, assign) CGFloat maxZoomLevel;
@property (nonatomic, assign) BOOL showsUserLocation;
@property(nonatomic, assign) OMKUserTrackingMode userTrackingMode;

@end

NS_ASSUME_NONNULL_END
