//
//  OMKImage.m
//  OneMapKit
//
//  Created by Sauron on 2022/11/16.
//

#import "OMKImage.h"

@implementation OMKImage

+ (UIImage *)bundleImage:(NSString *)imageName {
    static NSBundle *resourceBundle = nil;
    if (resourceBundle == nil) {
        NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"OneMapKit" ofType:@"bundle"];
        resourceBundle = [NSBundle bundleWithPath:bundlePath];
    }
    return [UIImage imageNamed:imageName inBundle:resourceBundle compatibleWithTraitCollection:nil];
}

+ (UIImage *)imageNamed:(NSString *)name {
    return [self bundleImage:name];
}

@end
