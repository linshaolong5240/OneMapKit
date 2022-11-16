//
//  OMKMapViewController.h
//  OneMapKit
//
//  Created by Sauron on 2022/11/5.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OneMapKit/OneMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OMKMapViewController : UIViewController

@property(nonatomic, readonly) OMKMapType mapType;

- (instancetype)initWithMapType:(OMKMapType) mapType;

@end

NS_ASSUME_NONNULL_END
