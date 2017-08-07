//
//  CameraPreviewViewModel.swift
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

import Foundation

private enum Filter: String {
    case none = "None"
    case grayscale = "Grayscale"
    case canny = "Canny Edge Detection"
    case hsv = "HSV"
}

fileprivate typealias `Self` = CameraPreviewViewModel

typealias FrameUpdateCallback = (OCVImage) -> ()

// MARK: CameraPreviewViewModel -
final class CameraPreviewViewModel: PreviewViewModel {

    /// Public properties
    var frameDidUpdate: FrameUpdateCallback?
    var filters: [String] {
        return Self.supportedFilters.map { $0.key.rawValue }
    }

    /// Private properties
    fileprivate var processorList: MediaProcessorList?

    /// Public methods
    init() {

        processorList = MediaProcessorList(with: CameraSource.shared, frameSink: self)
        processorList?.start()
    }

    func applyFilter(filter: String) {

        processorList?.clearProcessors()

        guard filter != Filter.none.rawValue else {
            return
        }

        guard let filterObject = Filter(rawValue: filter) else {
            preconditionFailure("Invalid filter string. Should not happen.")
        }

        guard let processor = Self.supportedFilters[filterObject] as? Processor else {
            preconditionFailure("Invalid processor. Should not happen.")
        }

        processorList?.add(processor)
    }
}

// MARK: - FrameConsumer Delegate -
extension CameraPreviewViewModel: FrameConsumer {

    func didProduce(_ frame: OCVImage) {
        frameDidUpdate?(frame)
    }
}

// MARK: - Supported Filters -
extension CameraPreviewViewModel {

    fileprivate static let supportedFilters: [Filter: AnyObject?] = [
        .none: nil,
        .grayscale: GrayscaleProcessor(),
        .canny: CannyEdgeDetectorProcessor(),
        .hsv: HSVProcessor()
    ]
}
