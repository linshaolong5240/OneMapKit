//
//  OMKImage.m
//  OneMapKit
//
//  Created by Sauron on 2022/11/16.
//

#import "OMKImage.h"

@implementation OMKImage

+ (NSBundle *)bundleWithName:(NSString *)bundleName {
    NSBundle *bundle = [NSBundle bundleForClass:[OMKImage class]];
    NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
  return [NSBundle bundleWithURL:url];
}

+ (UIImage *)bundleImage:(NSString *)imageName {
    NSBundle *targetBundle = [self bundleWithName:@"OneMapKit"];
    return [UIImage imageNamed:imageName
                                inBundle:targetBundle
           compatibleWithTraitCollection:nil];
}

+ (UIImage *)imageNamed:(NSString *)name {
    return [self bundleImage:name];
}

@end
