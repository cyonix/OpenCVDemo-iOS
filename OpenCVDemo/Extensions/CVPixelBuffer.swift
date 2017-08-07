//
//  CVPixelBuffer.swift
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

import CoreMedia
import Foundation

extension CVPixelBuffer {

    var width: Int {
        return CVPixelBufferGetWidth(self)
    }

    var height: Int {
        return CVPixelBufferGetHeight(self)
    }

    func lock() {
        CVPixelBufferLockBaseAddress(self, .readOnly)
    }

    func unlock() {
        CVPixelBufferUnlockBaseAddress(self, .readOnly)
    }
}
