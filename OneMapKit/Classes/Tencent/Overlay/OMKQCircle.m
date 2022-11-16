//
//  OMKQCircle.m
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/15.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import "OMKQCircle.h"

@implementation OMKQCircle

- (BOOL)setCircleWithCenterCoordinate:(CLLocationCoordinate2D)coord radius:(CLLocationDistance)radius {
    self.coordinate = coord;
    self.radius = radius;
    
    return YES;
}

@end
