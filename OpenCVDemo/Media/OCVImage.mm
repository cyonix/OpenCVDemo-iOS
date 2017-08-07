//
//  OCVImage.m
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

#import "OCVImage.h"

#import "imgcodecs/ios.h"

@interface OCVImage ()
{
    cv::Mat _mat;
    UIImage * _image;
}
@end

@implementation OCVImage

+ (instancetype)imageWithMat:(cv::Mat &)mat
{
    auto ocvImage = [[OCVImage alloc] init];
    ocvImage->_mat = mat;
    return ocvImage;
}

+ (instancetype)imageWithUIImage:(UIImage *)image
{
    auto ocvImage = [[OCVImage alloc] init];
    ocvImage->_image = image;
    return ocvImage;
}

- (UIImage *)image
{
    if (!_image)
    {
        _image = MatToUIImage(_mat);
    }
    return _image;
}

- (cv::Mat)mat
{
    if (_mat.empty())
    {
        UIImageToMat(_image, _mat);
    }
    return _mat;
}

@end
