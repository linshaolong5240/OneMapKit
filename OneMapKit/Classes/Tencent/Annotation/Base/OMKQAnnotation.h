//
//  OMKQAnnotation.h
//  ObjectiveCHelper
//
//  Created by Apple on 2022/11/14.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <QMapKit/QMapKit.h>
#import "OMKAnnotation.h"

NS_ASSUME_NONNULL_BEGIN

@interface OMKQAnnotation : QPointAnnotation <OMKAnnotation>

@property (nonatomic, readonly,copy) NSString *reuseIdentifier;

@end

NS_ASSUME_NONNULL_END
