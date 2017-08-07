//
//  CannyEdgeDetectorProcessor.swift
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

import Foundation

class CannyEdgeDetectorProcessor: Processor {

    weak var consumer: FrameConsumer?

    func didProduce(_ frame: OCVImage) {

        let edgeMask = frame.process(with: .cannyEdgeDetection)
                            .process(with: .invert)

        let processedImage = frame.mask(with: edgeMask) //.replace(pixel: 0, with: 255)

        consumer?.didProduce(processedImage)
    }
}
