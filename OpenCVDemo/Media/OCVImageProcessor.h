//
//  OCVImageProcessor.h
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

#ifdef __cplusplus
#import "opencv.hpp"
#endif

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, ConverterType)
{
    ConverterTypeGrayscale = 0,
    ConverterTypeHSV
};

typedef NS_ENUM(NSInteger, ProcessorType)
{
    ProcessorTypeCannyEdgeDetection = 0,
    ProcessorTypeBlur,
    ProcessorTypeInvert
};

@class OCVImage;

NS_ASSUME_NONNULL_BEGIN

@interface OCVImageProcessor : NSObject

+ (OCVImage *)process:(OCVImage *)image withType:(ProcessorType)type;
+ (OCVImage *)mask:(OCVImage *)image withMask:(OCVImage *)imageMask;
+ (OCVImage *)convert:(OCVImage *)image withType:(ConverterType)type;

@end

NS_ASSUME_NONNULL_END
