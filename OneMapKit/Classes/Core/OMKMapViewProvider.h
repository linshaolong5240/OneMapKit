//
//  OCHMapSource.h
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/4.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMKAnnotationView.h"
#import "OMKOverlay.h"

typedef NS_ENUM(NSUInteger, OMKMapType) {
    OMKMapTypeAMap,
    OMKMapTypeBaidu,
    OMKMapTypeTencent,
    OMKMapTypeNumber,
};

typedef NS_ENUM(NSUInteger, OMKUserTrackingMode) {
    OMKMapUserTrackingModeNone,                 ///< 不追踪用户的location更新
    OMKMapUserTrackingModeFollow,               ///< 追踪用户的location更新
    OMKMapUserTrackingModeFollowWithHeading,    ///< 追踪用户的location与heading更新
};

NSString *NSStringFromOMKMapType(OMKMapType type);
NSString *NSStringFromOMKUserTrackingMode(OMKUserTrackingMode mode);

@protocol OMKMapViewProvider;

typedef UIView<OMKMapViewProvider> OMKMapView;

@protocol OMKMapViewDelegate <NSObject>

@required

@optional

/**
 * @brief  当选中一个annotation view时，调用此接口
 * @param mapView 地图View
 * @param view 选中的annotation view
 */
- (void)mapView:(OMKMapView *)mapView didSelectAnnotationView:(id <OMKAnnotationView>)view;

/**
 * @brief  当取消选中一个annotation view时，调用此接口
 * @param mapView 地图View
 * @param view 取消选中的annotation view
 */
- (void)mapView:(OMKMapView *)mapView didDeselectAnnotationView:(id <OMKAnnotationView>)view;

/**
 *  @brief 定位时的userTrackingMode 改变时delegate调用此函数
 *  @param mapView 地图View
 *  @param mode QMUserTrackingMode
 *  @param animated 是否有动画
 */
- (void)mapView:(OMKMapView *)mapView didChangeUserTrackingMode:(OMKUserTrackingMode)mode animated:(BOOL)animated;

@end

@protocol OMKMapViewProvider <NSObject>

@required
@property(nonatomic, weak) id <OMKMapViewDelegate> delegate;

@property(nonatomic, assign) BOOL showsUserLocation;
@property(nonatomic, assign) OMKUserTrackingMode userTrackingMode;

#pragma mark - Annotation

/**
 * @brief 向地图窗口添加标注，需要实现MAMapViewDelegate的-mapView:viewForAnnotation:函数来生成标注对应的View
 * @param annotation 要添加的标注
 */
- (void) addAnnotation:(id <OMKAnnotation>)annotation;

/**
 * @brief  向地图窗口添加一组标注，需要实现QMapViewDelegate的-mapView:viewForAnnotation:函数来生成标注对应的View
 * @param annotations 要添加的标注数组
 */
- (void)addAnnotations:(NSArray<id <OMKAnnotation>> *)annotations;

/**
 * @brief  移除标注
 * @param annotation 要移除的标注
 */
- (void) removeAnnotation:(id <OMKAnnotation>)annotation;

/**
 * @brief  移除一组标注
 * @param annotations 要移除的标注数组
 */
- (void)removeAnnotations:(NSArray<id <OMKAnnotation>> *)annotations;

#pragma mark - Overlay

/**
 * @brief  向地图窗口添加Overlay，需要实现QMapViewDelegate的-mapView:viewForOverlay:函数来生成标注对应的View
 * @param overlay 要添加的overlay
 */
- (void)addOverlay:(id <OMKOverlay>)overlay;

/**
 * @brief  批量向地图窗口添加Overlay，需要实现QMapViewDelegate的-mapView:viewForOverlay:函数来生成标注对应的View
 * @param overlays 要添加的overlay列表
 */
- (void)addOverlays:(NSArray<id <OMKOverlay>> *)overlays;

/**
 * @brief  移除Overlay
 * @param overlay 要移除的overlay
 */
- (void)removeOverlay:(id <OMKOverlay>)overlay;

/**
 * @brief  移除Overlay
 * @param overlays 要移除的overlay列表
 */
- (void)removeOverlays:(NSArray<id <OMKOverlay>> *)overlays;

#pragma mark - Router

- (void)searchDrivingRouteFrom:(CLLocationCoordinate2D)from to:(CLLocationCoordinate2D)to;

@optional

@end
