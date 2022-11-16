//
//  OMKQManager.m
//  OneMapKit
//
//  Created by Sauron on 2022/11/16.
//

#import "OMKQManager.h"
#import <QMapKit/QMapKit.h>//腾讯地图
#import <QMapKit/QMSSearchKit.h>

@implementation OMKQManager

+ (instancetype)sharesInstance {
    static OMKQManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[OMKQManager alloc] init];
    });
    
    return shared;
}

- (void)setApiKey:(nonnull NSString *)apiKey {
    //在使用地图SDK时，需要对应用做Key机制验证，如果地图不添加key，地图将显示鉴权失败,请检查你的Key的错误信息，控制台也同时会显示key 鉴权失败:xxx的错误日志和原因。
    [QMapServices sharedServices].APIKey = apiKey;
    [[QMSSearchServices sharedServices] setApiKey:apiKey];
}

- (void)setPrivacyAgreement:(BOOL)isAgree {
    //隐私合规接口, 必须在地图初始化前调用, 默认为false
    //在构造QMapView之前，开发者应向用户展示授权弹窗，并提示用户授权前请仔细阅读腾讯位置服务隐私协议内容: https://lbs.qq.com/userAgreements/agreements/privacy，如果用户拒绝授权则无法正常显示地图页面。
    [[QMapServices sharedServices] setPrivacyAgreement:isAgree];
}

@end
