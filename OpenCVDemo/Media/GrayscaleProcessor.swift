//
//  GrayscaleProcessor.swift
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

import Foundation

final class GrayscaleProcessor: Processor {

    weak var consumer: FrameConsumer?

    func didProduce(_ frame: OCVImage) {
        let image = frame.convert(with: .grayscale)

        consumer?.didProduce(image)
    }
}
