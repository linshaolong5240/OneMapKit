//
//  OMKAMapView.m
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/4.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import "OMKAMapView.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

//Annotation
#import "OMKABubbleAnnotationView.h"
#import "OMKACustomerLocationAnnotationView.h"
#import "OMKAEmployeeLocationAnnotationView.h"

MAUserTrackingMode MAUserTrackingModeFromOMKUserTrackingMode(OMKUserTrackingMode mode) {
    switch (mode) {
        case OMKMapUserTrackingModeNone:
            return MAUserTrackingModeNone;
            break;
        case OMKMapUserTrackingModeFollow:
            return MAUserTrackingModeFollow;
            break;
        case OMKMapUserTrackingModeFollowWithHeading:
            return MAUserTrackingModeFollowWithHeading;
            break;
    }
}

OMKUserTrackingMode OMKUserTrackingModeFromMAUserTrackingMode(MAUserTrackingMode mode) {
    switch (mode) {
        case MAUserTrackingModeNone:
            return OMKMapUserTrackingModeNone;
            break;
        case MAUserTrackingModeFollow:
            return OMKMapUserTrackingModeFollow;
            break;
        case MAUserTrackingModeFollowWithHeading:
            return OMKMapUserTrackingModeFollowWithHeading;
            break;
    }
}


@interface OMKAMapView () <MAMapViewDelegate, AMapSearchDelegate>

@property(nonatomic, strong) MAMapView *mapView;
@property(nonatomic, strong) AMapSearchAPI *search;

@end

@implementation OMKAMapView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _mapView = [[MAMapView alloc] initWithFrame:self.bounds];
        _mapView.delegate = self;
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
        
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.mapView];
}

#pragma mark - MAMapViewDelegate - Location

/**
 * @brief 在地图View将要启动定位时，会调用此函数
 * @param mapView 地图View
 */
- (void)mapViewWillStartLocatingUser:(MAMapView *)mapView {
    
}

/**
 * @brief 在地图View停止定位后，会调用此函数
 * @param mapView 地图View
 */
- (void)mapViewDidStopLocatingUser:(MAMapView *)mapView {
    
}

/**
 * @brief 位置或者设备方向更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 用户定位信息(包括位置与设备方向等数据)
 * @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    //    if (!_userLocationAnnotation) {
    //        _userLocationAnnotation = [[MAPointAnnotation alloc] init];
    //        _userLocationAnnotation.title = @"title";
    //        _userLocationAnnotation.subtitle = @"subtitle";
    //        [mapView addAnnotation:_userLocationAnnotation];
    //    }
    //    self.userLocationAnnotation.coordinate = userLocation.coordinate;
}

/**
 *  @brief 当plist配置NSLocationAlwaysUsageDescription或者NSLocationAlwaysAndWhenInUseUsageDescription，并且[CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined，会调用代理的此方法。
 此方法实现调用后台权限API即可（ 该回调必须实现 [locationManager requestAlwaysAuthorization] ）; since 6.8.0
 *  @param locationManager  地图的CLLocationManager。
 */
- (void)mapViewRequireLocationAuth:(CLLocationManager *)locationManager {
    
}

/**
 * @brief 定位失败后，会调用此函数
 * @param mapView 地图View
 * @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    
}

#pragma mark - AMapSearchDelegate


/**
 * @brief 当请求发生错误时，会调用代理的此方法.
 * @param request 发生错误的请求.
 * @param error   返回的错误.
 */
- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error {
#if DEBUG
    NSLog(@"%s %@", __PRETTY_FUNCTION__, error);
#endif
}

/**
 * @brief 路径规划查询回调
 * @param request  发起的请求，具体字段参考 AMapRouteSearchBaseRequest 及其子类。
 * @param response 响应结果，具体字段参考 AMapRouteSearchResponse 。
 */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response {
#if DEBUG
    NSLog(@"%s", __PRETTY_FUNCTION__);
#endif
    if (response.route == nil) {
        return;
    }
    
    if (response.count <= 0) {
        return;
    }
    
    AMapPath *path = response.route.paths.firstObject;
    
    if (path == nil) {
        return;
    }
    
    NSInteger pointsCount = 0;
    
    for(AMapStep *step in path.steps) {
        NSLog(@"%@", step.polyline);
        NSArray<NSString *> *coordinates = [step.polyline componentsSeparatedByString:@";"];
        pointsCount += coordinates.count;
    }
    
    CLLocationCoordinate2D *coordinates = (CLLocationCoordinate2D*)malloc(pointsCount * sizeof(CLLocationCoordinate2D));
    
    NSInteger index = 0;
    for(AMapStep *step in path.steps) {
        NSLog(@"%@", step.polyline);
        NSArray<NSString *> *coordinatesString = [step.polyline componentsSeparatedByString:@";"];
        for(NSString *coordinateString in coordinatesString) {
            NSArray<NSString *> *coor= [coordinateString componentsSeparatedByString:@","];
            coordinates[index].longitude = [coor[0] doubleValue];
            coordinates[index].latitude = [coor[1] doubleValue];
            index++;
        }
    }
    
    OMKAPolyline *polyline = [OMKAPolyline polylineWithCoordinates:coordinates count:pointsCount];
    [self addOverlay:polyline];
    free(coordinates);
}


#pragma mark - QMapViewDelegate - Annotation

/**
 * @brief 根据anntation生成对应的View。
 
 注意：
 1、5.1.0后由于定位蓝点增加了平滑移动功能，如果在开启定位的情况先添加annotation，需要在此回调方法中判断annotation是否为MAUserLocation，从而返回正确的View。
 if ([annotation isKindOfClass:[MAUserLocation class]]) {
 return nil;
 }
 
 2、请不要在此回调中对annotation进行select和deselect操作，此时annotationView还未添加到mapview。
 
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation {
    if ([annotation isKindOfClass:[MAUserLocation class]]) {
        return nil;
    }
    else if ([annotation isKindOfClass:[OMKABubbleAnnotation class]]) {
        OMKABubbleAnnotation *omkAnnotation = (OMKABubbleAnnotation *)annotation;
        OMKABubbleAnnotationView *annotationView = (OMKABubbleAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:omkAnnotation.reuseIdentifier];
        if (annotationView == nil) {
            annotationView = [[OMKABubbleAnnotationView alloc] initWithAnnotation:omkAnnotation reuseIdentifier:omkAnnotation.reuseIdentifier];
        }
        return annotationView;
    }
    else if ([annotation isKindOfClass:[OMKACustomerLocationAnnotation class]]) {
        OMKACustomerLocationAnnotation *omkAnnotation = (OMKACustomerLocationAnnotation *)annotation;
        OMKAAnnotationView *annotationView = (OMKAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:omkAnnotation.reuseIdentifier];
        if (annotationView == nil) {
            annotationView = [[OMKACustomerLocationAnnotationView alloc] initWithAnnotation:omkAnnotation reuseIdentifier:omkAnnotation.reuseIdentifier];
        }
        return annotationView;
    }
    else if ([annotation isKindOfClass:[OMKAEmployeeLocationAnnotation class]]) {
        OMKAEmployeeLocationAnnotation *omkAnnotation = (OMKAEmployeeLocationAnnotation *)annotation;
        OMKAAnnotationView *annotationView = (OMKAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:omkAnnotation.reuseIdentifier];
        if (annotationView == nil) {
            annotationView = [[OMKAEmployeeLocationAnnotationView alloc] initWithAnnotation:omkAnnotation reuseIdentifier:omkAnnotation.reuseIdentifier];
        }
        return annotationView;
    }

    return nil;
}

/**
 * @brief 当选中一个annotation view时，调用此接口. 注意如果已经是选中状态，再次点击不会触发此回调。取消选中需调用-(void)deselectAnnotation:animated:
 * @param mapView 地图View
 * @param view 选中的annotation view
 */
- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)view {
    if (![self.delegate respondsToSelector:@selector(mapView:didSelectAnnotationView:)]) {
        return;
    }
    if (![view conformsToProtocol:@protocol(OMKAnnotationView)]) {
        return;
    }
    id <OMKAnnotationView> omkAnnotationView = (id <OMKAnnotationView>)view;
    [self.delegate mapView:self didSelectAnnotationView:omkAnnotationView];
    
    //OMKAMapPointAnnotationView一直响应 @selector(mapView:didSelectAnnotationView:)
    if ([view isKindOfClass:[OMKABubbleAnnotationView class]]) {
        [self.mapView deselectAnnotation:view.annotation animated:NO];
    }

}

/**
 * @brief 当取消选中一个annotation view时，调用此接口
 * @param mapView 地图View
 * @param view 取消选中的annotation view
 */
- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view {
    if (![self.delegate respondsToSelector:@selector(mapView:didDeselectAnnotationView:)]) {
        return;
    }
    if (![view conformsToProtocol:@protocol(OMKAnnotationView)]) {
        return;
    }
    id <OMKAnnotationView> omkAnnotationView = (id <OMKAnnotationView>)view;
    [self.delegate mapView:self didDeselectAnnotationView:omkAnnotationView];
}

#pragma mark - QMapViewDelegate - Overlay

/**
 * @brief 根据overlay生成对应的Renderer
 * @param mapView 地图View
 * @param overlay 指定的overlay
 * @return 生成的覆盖物Renderer
 */
- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay {
    if ([overlay isKindOfClass:[MACircle class]]) {
        MACircleRenderer *circleRenderer = [[MACircleRenderer alloc] initWithCircle:overlay];
        
        circleRenderer.lineWidth    = 5.f;
        circleRenderer.strokeColor  = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.8];
        circleRenderer.fillColor    = [UIColor colorWithRed:1.0 green:0.8 blue:0.0 alpha:0.8];
        return circleRenderer;
    }
    else if ([overlay isKindOfClass:[MAPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 8.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:0 green:1 blue:0 alpha:0.6];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}

/**
 * @brief 当userTrackingMode改变时，调用此接口
 * @param mapView 地图View
 * @param mode 改变后的mode
 * @param animated 动画
 */
- (void)mapView:(MAMapView *)mapView didChangeUserTrackingMode:(MAUserTrackingMode)mode animated:(BOOL)animated {
    if ([self.delegate respondsToSelector:@selector(mapView:didChangeUserTrackingMode:animated:)]) {
        [self.delegate mapView:self didChangeUserTrackingMode:OMKUserTrackingModeFromMAUserTrackingMode(mode) animated:animated];
    }
}

#pragma mark - OMKMapProvider

- (BOOL)showsUserLocation {
    return self.mapView.showsUserLocation;
}

- (void)setShowsUserLocation:(BOOL)showsUserLocation {
    self.mapView.showsUserLocation = showsUserLocation;
}

- (void)setUserTrackingMode:(OMKUserTrackingMode)userTrackingMode {
    _userTrackingMode = userTrackingMode;
    self.mapView.userTrackingMode = MAUserTrackingModeFromOMKUserTrackingMode(userTrackingMode);
}

- (void)addAnnotation:(id <OMKAnnotation, MAAnnotation>)annotation {
    [self.mapView addAnnotation:annotation];
}

- (void)addAnnotations:(NSArray<id <OMKAnnotation, MAAnnotation>> *)annotations {
    [self.mapView addAnnotations:annotations];
}

- (void)removeAnnotation:(id <OMKAnnotation, MAAnnotation>)annotation {
    [self.mapView removeAnnotation:annotation];
}

- (void)removeAnnotations:(NSArray *)annotations {
    [self.mapView removeAnnotations:annotations];
}

- (void)addOverlay:(id <OMKOverlay, MAOverlay>)overlay {
    [self.mapView addOverlay:overlay];
}

- (void)addOverlays:(NSArray<id <OMKOverlay, MAOverlay>> *)overlays {
    [self.mapView addOverlays:overlays];
}

- (void)removeOverlay:(id <OMKOverlay, MAOverlay>)overlay {
    [self.mapView  removeOverlay:overlay];
}

- (void)removeOverlays:(NSArray<id <OMKOverlay, MAOverlay>> *)overlays {
    [self.mapView  removeOverlays:overlays];
}

- (void)searchDrivingRouteFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to {
    AMapDrivingCalRouteSearchRequest *navi = [[AMapDrivingCalRouteSearchRequest alloc] init];
    
    navi.showFieldType = AMapDrivingRouteShowFieldTypeCost|AMapDrivingRouteShowFieldTypeTmcs|AMapDrivingRouteShowFieldTypeNavi|AMapDrivingRouteShowFieldTypeCities|AMapDrivingRouteShowFieldTypePolyline;
    /* 出发点. */
    navi.origin = [AMapGeoPoint locationWithLatitude:from.latitude
                                           longitude:from.longitude];
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:to.latitude
                                                longitude:to.longitude];
    [self.search AMapDrivingV2RouteSearch:navi];
}

@end
