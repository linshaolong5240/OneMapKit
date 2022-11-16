//
//  OMKAnnotationView.h
//  OneMapKit
//
//  Created by Sauron on 2022/11/10.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "OMKAnnotation.h"
#import "OMKImage.h"

NS_ASSUME_NONNULL_BEGIN

@protocol OMKAnnotationView <NSObject>

@property (nonatomic, strong) UIImage *image;

@property (nonatomic) BOOL canShowCallout;

@end

NS_ASSUME_NONNULL_END
