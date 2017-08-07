//
//  ViewController.swift
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

import UIKit

fileprivate typealias `Self` = CameraPreviewViewController

// MARK: CameraPreviewViewController -
final class CameraPreviewViewController: UIViewController {

    private var previewViewModel: PreviewViewModel = CameraPreviewViewModel()
    private var previewRenderer = CameraPreviewRenderer()

    @IBOutlet weak var cameraImageView: UIImageView!

    override func viewDidLoad() {

        super.viewDidLoad()

        previewRenderer.view.frame = view.bounds

        view.insertSubview(previewRenderer.view, at: 0)

        previewViewModel.frameDidUpdate = previewRenderer.updateCallback
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func didTapMenu(_ sender: UIButton) {

        let actionController = UIAlertController(title: Self.alertControllerTitle, message: nil, preferredStyle: .actionSheet)

        previewViewModel.filters.forEach {

            let filter = $0
            let action = UIAlertAction(title: filter, style: .default) { [weak self] (_: UIAlertAction) in

                self?.previewViewModel.applyFilter(filter: filter)
            }

            actionController.addAction(action)
        }

        present(actionController, animated: true, completion: nil)
    }
}

// MARK: - Constants -
extension CameraPreviewViewController {

    fileprivate static let alertControllerTitle = "OpenCV Filters"
}

// MARK: - Storyboards -
extension CameraPreviewViewController {

    fileprivate static let storyboard = "CameraPreview"
    fileprivate static let identifier = "CameraPreviewViewController"

    static func fromStoryBoard() -> CameraPreviewViewController? {

        let storyboard = UIStoryboard(name: Self.storyboard, bundle: nil)

        let controller = storyboard.instantiateViewController(withIdentifier: Self.identifier) as? CameraPreviewViewController

        return controller
    }
}
