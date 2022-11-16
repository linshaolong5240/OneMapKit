//
//  OMKAAnnotation.h
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/14.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <MAMapKit/MAPointAnnotation.h>
#import "OMKAnnotation.h"

NS_ASSUME_NONNULL_BEGIN

@interface OMKAAnnotation : MAPointAnnotation <OMKAnnotation>

@property (nonatomic, readonly,copy) NSString *reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
