//
//  CameraPreviewRenderer.swift
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

import Foundation
import UIKit

// MARK: CameraPreviewRenderer -
final class CameraPreviewRenderer {

    /// Public properties
    var view: UIView

    fileprivate(set) var updateCallback: FrameUpdateCallback!

    /// Private properties
    fileprivate var imageView: UIImageView

    /// Public methods
    init() {

        view = UIView()

        imageView = UIImageView(frame: view.frame)
        imageView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]

        view.addSubview(imageView)

        updateCallback = { [weak self] (ocvImage: OCVImage) -> () in

            guard let strongSelf = self else {
                return
            }

            // Render the image onto a simple image view
            DispatchQueue.main.async {
                strongSelf.imageView.image = ocvImage.image
            }
        }
    }
}
