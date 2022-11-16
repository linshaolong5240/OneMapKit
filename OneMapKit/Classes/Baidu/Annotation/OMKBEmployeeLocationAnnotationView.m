//
//  OMKBEmployeeLocationAnnotationView.m
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/14.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import "OMKBEmployeeLocationAnnotationView.h"

@implementation OMKBEmployeeLocationAnnotationView

- (instancetype)initWithAnnotation:(id <BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        self.canShowCallout = NO;
        [self configureView];
    }
    return self;
}

- (void)configureView {
    self.image = [OMKImage imageNamed:@"omk_employee_location_annotation_location"];
    UIImageView *bubbleImageView = [[UIImageView alloc] initWithImage:[OMKImage imageNamed:@"omk_employee_location_annotation_bubble"]];
    [self addSubview:bubbleImageView];

    [bubbleImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_top);
            make.centerX.equalTo(self);
    }];
}

@end
