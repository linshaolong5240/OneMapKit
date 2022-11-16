//
//  OMKQAnnotation.m
//  ObjectiveCHelper
//
//  Created by Apple on 2022/11/14.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import "OMKQAnnotation.h"

@implementation OMKQAnnotation

-(NSString *)reuseViewIdentifier {
    return NSStringFromClass([self class]);
}

@end
