//
//  OCVImage.swift
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

import Foundation

extension OCVImage {

    func process(with type: ProcessorType) -> OCVImage {
        return OCVImageProcessor.process(self, with: type)
    }

    func convert(with type: ConverterType) -> OCVImage {
        return OCVImageProcessor.convert(self, with: type)
    }

    func mask(with image: OCVImage) -> OCVImage {
        return OCVImageProcessor.mask(self, withMask: image)
    }
}
