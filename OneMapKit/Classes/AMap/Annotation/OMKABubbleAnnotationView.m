//
//  OMKABubbleAnnotationView.m
//  ObjectiveCHelper
//
//  Created by Sauron on 2022/11/14.
//  Copyright © 2022 com.sauronpi. All rights reserved.
//

#import "OMKABubbleAnnotationView.h"

@implementation OMKABubbleAnnotationView

- (id)initWithAnnotation:(id <MAAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configureView];
    }
    return self;
}

- (void)configureView {
    self.image = [OMKImage imageNamed:@"omk_point_annotation_location"];
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = self.annotation.title;
    [titleLabel sizeToFit];
    UILabel *subtitleLabel = [[UILabel alloc] init];
    subtitleLabel.text = self.annotation.subtitle;
    [subtitleLabel sizeToFit];
    
    UIStackView *vstack = [[UIStackView alloc] init];
    vstack.backgroundColor = UIColor.orangeColor;
    vstack.axis = UILayoutConstraintAxisVertical;
    if (titleLabel.text) {
        [vstack addArrangedSubview: titleLabel];
    }
    if (subtitleLabel.text) {
        [vstack addArrangedSubview: subtitleLabel];
    }
    [self addSubview:vstack];
    CGFloat width = titleLabel.bounds.size.width > subtitleLabel.bounds.size.width ? titleLabel.bounds.size.width : subtitleLabel.bounds.size.width;
    [vstack mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_top).offset(- 10);
            make.centerX.equalTo(self);
            make.width.mas_equalTo(width);
    }];
}

@end
