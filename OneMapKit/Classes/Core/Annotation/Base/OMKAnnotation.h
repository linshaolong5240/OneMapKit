//
//  OMKAnnotation.h
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/10.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OMKAnnotation <NSObject>

@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;


@optional
@property (nonatomic, readonly,copy) NSString *reuseViewIdentifier;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

- (void)setCoordinate:(CLLocationCoordinate2D)newCoordinate;

@end

NS_ASSUME_NONNULL_END
