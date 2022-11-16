//
//  OMKOverlay.h
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/12.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OMKOverlay <NSObject>

@optional

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end

NS_ASSUME_NONNULL_END
