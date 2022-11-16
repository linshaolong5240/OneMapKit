//
//  OMKImage.m
//  OneMapKit
//
//  Created by Sauron on 2022/11/16.
//

#import "OMKImage.h"

@implementation OMKImage

+ (UIImage *)bundleImage:(NSString *)imageName {
    NSBundle *targetBundle = [NSBundle bundleForClass:[self class]];
    return [UIImage imageNamed:imageName
                                inBundle:targetBundle
           compatibleWithTraitCollection:nil];
}

+ (UIImage *)imageNamed:(NSString *)name {
    return [self bundleImage:name];
}

@end
