//
//  OMKAManager.m
//  OneMapKit
//
//  Created by Sauron on 2022/11/16.
//

#import "OMKAManager.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <MAMapKit/MAMapKit.h>

@implementation OMKAManager

+ (instancetype)sharesInstance {
    static OMKAManager *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[OMKAManager alloc] init];
    });
    
    return shared;
}

- (void)setApiKey:(NSString *)apiKey {
    [[AMapServices sharedServices] setApiKey:apiKey];
}

- (void)setPrivacyAgreement:(BOOL)isAgree {
    //在构造MAMapView（MAOfflineMap，MAOfflineMapViewController,MATraceManager等）之前必须进行合规检查，设置接口之前保证隐私政策合规
    [MAMapView updatePrivacyShow:AMapPrivacyShowStatusDidShow privacyInfo:AMapPrivacyInfoStatusDidContain];
    [MAMapView updatePrivacyAgree:isAgree ? AMapPrivacyAgreeStatusDidAgree : AMapPrivacyAgreeStatusNotAgree];
}

@end
