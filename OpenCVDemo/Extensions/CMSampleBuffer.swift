//
//  CMSampleBuffer.swift
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

import CoreMedia
import Foundation
import UIKit

extension CMSampleBuffer {

    var asImage: UIImage? {

        guard let pixelBuffer = CMSampleBufferGetImageBuffer(self) else {
            return nil
        }

        pixelBuffer.lock()
        defer {
            pixelBuffer.unlock()
        }

        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let rect = CGRect(x: 0, y: 0, width: pixelBuffer.width, height: pixelBuffer.height)

        guard let cgImage = CIContext().createCGImage(ciImage, from: rect) else {
            return nil
        }

        return UIImage(cgImage: cgImage)
    }
}
