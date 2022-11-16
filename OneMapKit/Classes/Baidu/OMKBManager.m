//
//  OMKBManager.m
//  OneMapKit
//
//  Created by Sauron on 2022/11/16.
//

#import "OMKBManager.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BMKLocationkit/BMKLocationComponent.h>

@interface OMKBManager () <BMKLocationAuthDelegate, BMKGeneralDelegate>

@property (nonatomic, strong) BMKMapManager *mapManager; //主引擎类

@end

@implementation OMKBManager

+ (instancetype)sharesInstance {
    static OMKBManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[OMKBManager alloc] init];
    });
    
    return shared;
}

- (void)setApiKey:(nonnull NSString *)apiKey {
    // 初始化定位SDK
    [[BMKLocationAuth sharedInstance] checkPermisionWithKey:apiKey authDelegate:self];
    //要使用百度地图，请先启动BMKMapManager
    self.mapManager = [[BMKMapManager alloc] init];
    if ([BMKMapManager setCoordinateTypeUsedInBaiduMapSDK:BMK_COORDTYPE_COMMON]) {
#if DEBUG
        NSLog(@"百度地图 经纬度类型设置成功");
#endif
    } else {
#if DEBUG
        NSLog(@"百度地图 经纬度类型设置失败");
#endif
    }
    
    //启动引擎并设置AK并设置delegate
    if ([self.mapManager start:apiKey generalDelegate:self]) {
#if DEBUG
        NSLog(@"百度地图 启动引擎成功");
#endif
    } else {
#if DEBUG
        NSLog(@"百度地图 启动引擎失败");
#endif
    }

}

- (void)setPrivacyAgreement:(BOOL)isAgree {
    //从地图SDK6.5.1版本起增加隐私合规接口，开发者需要调用接口通知百度地图用户是否已经同意隐私政策。隐私政策官网链接： https://lbsyun.baidu.com/index.php?title=openprivacy
    [[BMKLocationAuth sharedInstance] setAgreePrivacy:isAgree];
}

#pragma mark - BMKLocationAuthDelegate
/**
 *@brief 返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKLocationAuthErrorCode
 */
- (void)onCheckPermissionState:(BMKLocationAuthErrorCode)iError {
    if (0 == iError) {
#if DEBUG
        NSLog(@"百度定位 授权成功");
#endif
    } else {
#if DEBUG
        NSLog(@"百度定位 授权失败：%ld", (long)iError);
#endif
    }
}

#pragma mark - BMKGeneralDelegate

/**
 *返回网络错误
 *@param iError 错误号
 */
- (void)onGetNetworkState:(int)iError {
    if (0 == iError) {
#if DEBUG
        NSLog(@"百度地图 授权成功");
#endif
    } else {
#if DEBUG
        NSLog(@"百度地图 授权失败：%d", iError);
#endif
    }
}

/**
 *返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
 */
- (void)onGetPermissionState:(int)iError {
    if (0 == iError) {
#if DEBUG
        NSLog(@"百度地图 联网成功");
#endif
    } else {
#if DEBUG
        NSLog(@"百度地图 联网失败：%d", iError);
#endif
    }
}

@end
