//
//  OMKBAnnotation.h
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/14.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "OMKAnnotation.h"

NS_ASSUME_NONNULL_BEGIN

@interface OMKBAnnotation : BMKPointAnnotation <OMKAnnotation>

@property (nonatomic, readonly,copy) NSString *reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
