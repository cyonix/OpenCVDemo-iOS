//
//  OCVImageProcessor.m
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

#import "OCVImageProcessor.h"

#import "OCVImage.h"

#import "opencv.hpp"
#import "imgproc.hpp"
#import "imgcodecs/ios.h"

@implementation OCVImageProcessor

+ (OCVImage *)process:(OCVImage *)image withType:(ProcessorType)type
{
    const auto srcMat = image.mat;

    cv::Mat destMat;

    switch (type)
    {
        case ProcessorTypeCannyEdgeDetection:
            cv::Canny(srcMat, destMat, 200, 250);
            break;

        case ProcessorTypeBlur:

            break;

        case ProcessorTypeInvert:
            cv::bitwise_not(srcMat, destMat);
            break;

        default:
            assert(false);
            break;
    }

    return [OCVImage imageWithMat:destMat];
}

+ (OCVImage *)mask:(OCVImage *)image withMask:(OCVImage *)imageMask
{
    cv::Mat destMat;

    image.mat.copyTo(destMat, imageMask.mat);

    return [OCVImage imageWithMat:destMat];
}

+ (OCVImage *)convert:(OCVImage *)image withType:(ConverterType)type
{
    const auto srcMat = image.mat;

    cv::Mat destMat;

    switch (type)
    {
        case ConverterTypeGrayscale:
            cv::cvtColor(srcMat, destMat, CV_RGB2GRAY);
            break;

        case ConverterTypeHSV:
            cv::cvtColor(srcMat, destMat, CV_RGB2HSV);
            break;

        default:
            assert(false);
            break;
    }

    return [OCVImage imageWithMat:destMat];
}

@end
