//
//  OCVImage.h
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

#ifdef __cplusplus
#import "opencv.hpp"
#endif

#import <CoreMedia/CoreMedia.h>
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface OCVImage : NSObject

@property (nonatomic, strong, readonly) UIImage *image;

+ (instancetype)imageWithUIImage:(UIImage *)image;

#ifdef __cplusplus
@property (nonatomic, assign, readonly) cv::Mat mat;

+ (instancetype)imageWithMat:(cv::Mat &)mat;
#endif

@end

NS_ASSUME_NONNULL_END
