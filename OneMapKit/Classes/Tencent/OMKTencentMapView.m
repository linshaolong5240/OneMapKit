//
//  OMKTencentMapView.m
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/4.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import "OMKTencentMapView.h"
#import <QMapKit/QMapKit.h>
#import <QMapKit/QMSSearchKit.h>
//Annotation
#import "OMKQBubbleAnnotationView.h"
#import "OMKQCustomerLocationAnnotationView.h"
#import "OMKQEmployeeLocationAnnotationView.h"

QUserTrackingMode QUserTrackingModeFromOMKUserTrackingMode(OMKUserTrackingMode mode) {
    switch (mode) {
        case OMKMapUserTrackingModeNone:
            return QUserTrackingModeNone;
            break;
        case OMKMapUserTrackingModeFollow:
            return QUserTrackingModeFollow;
            break;
        case OMKMapUserTrackingModeFollowWithHeading:
            return QUserTrackingModeFollowWithHeading;
            break;
    }
}

OMKUserTrackingMode OMKUserTrackingModeFromQUserTrackingMode(QUserTrackingMode mode) {
    switch (mode) {
        case QUserTrackingModeNone:
            return OMKMapUserTrackingModeNone;
            break;
        case QUserTrackingModeFollow:
            return OMKMapUserTrackingModeFollow;
            break;
        case QUserTrackingModeFollowWithHeading:
            return OMKMapUserTrackingModeFollowWithHeading;
            break;
    }
}

@interface OMKTencentMapView () <QMapViewDelegate, QMSSearchDelegate>

@property(nonatomic, strong) QMapView *mapView;
@property (nonatomic, strong) QPointAnnotation *userLocationAnnotation;
@property (nonatomic, strong) QMSSearcher *searcher;

@end

@implementation OMKTencentMapView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _mapView = [[QMapView alloc] initWithFrame:self.bounds];
        _mapView.delegate = self;
        _searcher = [[QMSSearcher alloc] initWithDelegate:self];
        [self setupView];
    }
    return self;
}

- (void)setupView {
    [self addSubview:self.mapView];
}

#pragma mark - QMapViewDelegate - Location

// <QMapViewDelegate>中的定位回调函数
- (void)mapViewWillStartLocatingUser:(QMapView *)mapView
{
#if DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

- (void)mapViewDidStopLocatingUser:(QMapView *)mapView
{
#if DEBUG
    NSLog(@"%s", __FUNCTION__);
#endif
}

/**
 * @brief 用户位置更新后，会调用此函数
 * @param mapView 地图View
 * @param userLocation 新的用户位置
 * @param fromHeading 是否为heading 变化触发，如果为location变化触发,则为NO
 */
- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation fromHeading:(BOOL)fromHeading
{
#if DEBUG
    NSLog(@"%s fromHeading = %d, location = %@, heading = %@", __FUNCTION__, fromHeading, userLocation.location, userLocation.heading);
#endif
    
//    if (!self.userLocationAnnotation) {
//        self.userLocationAnnotation = [[QPointAnnotation alloc] init];
//        self.userLocationAnnotation.coordinate = userLocation.location.coordinate;
//        self.userLocationAnnotation.title = @"我的位置";
//        self.userLocationAnnotation.subtitle = @"我的位置";
//        [mapView addAnnotation:self.userLocationAnnotation];
//    }
}

/**
 * @brief  定位失败后，会调用此函数
 * @param mapView 地图View
 * @param error 错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(QMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
#if DEBUG
    NSLog(@"%s error = %@", __FUNCTION__, error);
#endif
}

#pragma mark - QMapViewDelegate - Annotation

/**
 * @brief 根据anntation生成对应的View
 * @param mapView 地图View
 * @param annotation 指定的标注
 * @return 生成的标注View
 */
- (QAnnotationView *)mapView:(QMapView *)mapView viewForAnnotation:(id <QAnnotation>)annotation {
    if ([annotation isKindOfClass:[OMKQBubbleAnnotation class]]) {
        OMKQBubbleAnnotation *omkAnnotation = (OMKQBubbleAnnotation *)annotation;
        OMKQAnnotationView *annotationView = (OMKQAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:omkAnnotation.reuseIdentifier];
        if (annotationView == nil) {
            annotationView = [[OMKQBubbleAnnotationView alloc] initWithAnnotation:omkAnnotation reuseIdentifier:omkAnnotation.reuseIdentifier];
        }
        return annotationView;
    }
    else if ([annotation isKindOfClass:[OMKQCustomerLocationAnnotation class]]) {
        OMKQCustomerLocationAnnotation *omkAnnotation = (OMKQCustomerLocationAnnotation *)annotation;
        OMKQAnnotationView *annotationView = (OMKQAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:omkAnnotation.reuseIdentifier];
        if (annotationView == nil) {
            annotationView = [[OMKQCustomerLocationAnnotationView alloc] initWithAnnotation:omkAnnotation reuseIdentifier:omkAnnotation.reuseIdentifier];
        }
        return annotationView;
    }
    else if ([annotation isKindOfClass:[OMKQEmployeeLocationAnnotation class]]) {
        OMKQEmployeeLocationAnnotation *omkAnnotation = (OMKQEmployeeLocationAnnotation *)annotation;
        OMKQAnnotationView *annotationView = (OMKQAnnotationView *)[self.mapView dequeueReusableAnnotationViewWithIdentifier:omkAnnotation.reuseIdentifier];
        if (annotationView == nil) {
            annotationView = [[OMKQEmployeeLocationAnnotationView alloc] initWithAnnotation:omkAnnotation reuseIdentifier:omkAnnotation.reuseIdentifier];
        }
        return annotationView;
    }
    
    return nil;
}

/**
 * @brief  当选中一个annotation view时，调用此接口
 * @param mapView 地图View
 * @param view 选中的annotation view
 */
- (void)mapView:(QMapView *)mapView didSelectAnnotationView:(QAnnotationView *)view {
    if (![self.delegate respondsToSelector:@selector(mapView:didSelectAnnotationView:)]) {
        return;
    }
    if (![view conformsToProtocol:@protocol(OMKAnnotationView)]) {
        return;
    }
    id <OMKAnnotationView> omkAnnotationView = (id <OMKAnnotationView>)view;
    [self.delegate mapView:self didSelectAnnotationView:omkAnnotationView];
    
    //OMKTencentPointAnnotationView一直响应 @selector(mapView:didSelectAnnotationView:)
    if ([view isKindOfClass:[OMKQBubbleAnnotationView class]]) {
        [self.mapView deselectAnnotation:view.annotation animated:NO];
    }
}

/**
 * @brief  当取消选中一个annotation view时，调用此接口
 * @param mapView 地图View
 * @param view 取消选中的annotation view
 */
- (void)mapView:(QMapView *)mapView didDeselectAnnotationView:(QAnnotationView *)view {
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

- (QOverlayView *)mapView:(QMapView *)mapView viewForOverlay:(id <QOverlay>)overlay {
    if ([overlay isKindOfClass:[OMKQCircle class]]) {
        QCircleView *circleView = [[QCircleView alloc] initWithCircle:overlay];
        circleView.lineWidth   = 3;
        circleView.strokeColor = [UIColor colorWithRed:.2 green:.1 blue:.1 alpha:.8];
        circleView.fillColor   = [[UIColor blueColor] colorWithAlphaComponent:0.2];
        
        return circleView;
    }
    else if ([overlay isKindOfClass:[QPolyline class]]) {
            QPolylineView *polylineRender = [[QPolylineView alloc] initWithPolyline:overlay];
            // 设置线宽
            polylineRender.lineWidth   = 8;
            // 设置线段颜色
            polylineRender.strokeColor = [UIColor colorWithRed:0 green:0 blue:1 alpha:0.2];
            // 设置边框宽度
            polylineRender.borderWidth = 2;
            // 设置边框颜色
            polylineRender.borderColor = [UIColor grayColor];
            
            return polylineRender;
    }
    
    return nil;
}

/**
 * @brief 定位时的userTrackingMode 改变时delegate调用此函数
 * @param mapView 地图View
 * @param mode QMUserTrackingMode
 * @param animated 是否有动画
 */
- (void)mapView:(QMapView *)mapView didChangeUserTrackingMode:(QUserTrackingMode)mode animated:(BOOL)animated {
    if (![self.delegate respondsToSelector:@selector(mapView:didChangeUserTrackingMode:animated:)]) {
        return;
    }
    [self.delegate mapView:self didChangeUserTrackingMode:OMKUserTrackingModeFromQUserTrackingMode(mode) animated:animated];
}

- (void)searchWithSearchOption:(QMSSearchOption *)searchOption didFailWithError:(NSError *)error {
#if DEBUG
    NSLog(@"%s, error: %@", __PRETTY_FUNCTION__, error);
#endif
}

- (void)searchWithDrivingRouteSearchOption:(QMSDrivingRouteSearchOption *)drivingRouteSearchOption didRecevieResult:(QMSDrivingRouteSearchResult *)drivingRouteSearchResult {
#if DEBUG
    NSLog(@"Result: %@", drivingRouteSearchResult);
#endif
    // 从每段路线规划结果中得到polyline的相关信息
    for (QMSRoutePlan *plan in drivingRouteSearchResult.routes) {
        CLLocationCoordinate2D coords[plan.polyline.count];
        
        for (int i = 0; i < plan.polyline.count; i++) {
            
            CLLocationCoordinate2D coordinate = [self getCoordinate:[plan.polyline objectAtIndex:i]];
            
            coords[i].latitude  = coordinate.latitude;
            coords[i].longitude = coordinate.longitude;
        }
        
        NSArray<QMSRouteStep *> *steps = plan.steps;
        NSMutableArray<QSegmentText *> *segs = [NSMutableArray array];
        for (QMSRouteStep *step in steps) {
            NSString *name = step.road_name;
            if (name.length > 0) {
                int start = [step.polyline_idx.firstObject intValue];
                int end = [step.polyline_idx.lastObject intValue];
                QSegmentText *s1 = [[QSegmentText alloc] init];
                s1.startIndex = start;
                s1.endIndex = end;
                s1.name = name;
                [segs addObject:s1];
            }
        }
        
        QTextStyle *style = [[QTextStyle alloc] init];
        style.textColor = [UIColor blackColor];
        style.strokeColor = [UIColor whiteColor];
        style.fontSize = 12;
        
        QText *route = [[QText alloc] initWithSegments:segs];
        route.style = style;
        
        OMKQPolyline *polyline = [[OMKQPolyline alloc] initWithCoordinates:coords count:plan.polyline.count];
        [self.mapView addOverlay:polyline];
    }
}

// 解析返回结果里polyline的坐标
- (CLLocationCoordinate2D)getCoordinate:(NSValue *)obj
{
    CLLocationCoordinate2D coordinate;
    
    if ([obj isKindOfClass:[[NSValue valueWithBytes:&coordinate objCType:@encode(CLLocationCoordinate2D)] class]]) {
        
        [obj getValue:(void *)&coordinate];
    }
    
    return CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
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
    switch (userTrackingMode) {
        case OMKMapUserTrackingModeNone:
            self.mapView.userTrackingMode = QUserTrackingModeNone;
            break;
        case OMKMapUserTrackingModeFollow:
            self.mapView.userTrackingMode = QUserTrackingModeFollow;
            break;
        case OMKMapUserTrackingModeFollowWithHeading:
            self.mapView.userTrackingMode = QUserTrackingModeFollowWithHeading;
            break;
    }
}

- (void)addAnnotation:(id <OMKAnnotation, QAnnotation>)annotation {
    [self.mapView addAnnotation:annotation];
}

- (void)addAnnotations:(NSArray<id <OMKAnnotation, QAnnotation>> *)annotations {
    [self.mapView addAnnotations:annotations];
}

- (void)removeAnnotation:(id <OMKAnnotation, QAnnotation>)annotation {
    [self.mapView removeAnnotation:annotation];
}

- (void)removeAnnotations:(NSArray<id <OMKAnnotation, QAnnotation>> *)annotations {
    [self.mapView removeAnnotations:annotations];
}

- (void)addOverlay:(id <OMKOverlay, QOverlay>)overlay {
    [self.mapView addOverlay:overlay];
}

- (void)addOverlays:(NSArray<id <OMKOverlay, QOverlay>> *)overlays {
    [self.mapView addOverlays:overlays];
}

- (void)removeOverlay:(id <OMKOverlay, QOverlay>)overlay {
    [self.mapView removeOverlay:overlay];
}

- (void)removeOverlays:(NSArray<id <OMKOverlay, QOverlay>> *)overlays {
    [self.mapView removeOverlays:overlays];
}

- (void)searchDrivingRouteFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to {
    NSString *fromString = [NSString stringWithFormat:@"%f,%f",from.latitude, from.longitude];
    NSString *toString = [NSString stringWithFormat:@"%f,%f",to.latitude, to.longitude];
    QMSDrivingRouteSearchOption *drivingOpt = [[QMSDrivingRouteSearchOption alloc] init];
    [drivingOpt setPolicyWithType:QMSDrivingRoutePolicyTypeLeastTime];
    [drivingOpt setFrom:fromString];
    [drivingOpt setTo:toString];
    [self.searcher searchWithDrivingRouteSearchOption:drivingOpt];
}

@end
