//
//  CameraSource.swift
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

import AVFoundation
import Foundation

// MARK: CameraSource -
class CameraSource: NSObject {

    /// Public Properties
    static let shared: CameraSource = CameraSource()
    weak var consumer: FrameConsumer?

    /// Private Properties
    fileprivate var captureSession: AVCaptureSession!
    fileprivate var captureDevice: AVCaptureDevice!
    fileprivate var captureVideoDataOutput : AVCaptureVideoDataOutput!
    fileprivate var captureLockQueue = DispatchQueue(label: "CameraSourceLockQueue")

    /// Private Methods
    private override init() {
        super.init()

        captureSession = AVCaptureSession()
        captureSession.sessionPreset = AVCaptureSessionPresetHigh

        chooseCaptureDevice()

        addInputSource()

        configureDataOutput()
    }
}

// MARK: - Source -
extension CameraSource: Source {

    func start() {
        captureLockQueue.sync { [unowned self] in
            self.captureSession.startRunning()
        }
    }

    func stop() {
        captureLockQueue.sync { [unowned self] in
            self.captureSession.stopRunning()
        }
    }
}

// MARK: - Device Discovery -
extension CameraSource {

    fileprivate func chooseCaptureDevice() {
        let discoverySession = AVCaptureDeviceDiscoverySession(
            deviceTypes: [ .builtInWideAngleCamera ],
            mediaType: AVMediaTypeVideo,
            position: .unspecified
        )

        guard let deviceList = discoverySession?.devices else {
            preconditionFailure()
        }

        // Use the back camera by default
        for device in deviceList where device.position == .back {
            captureDevice = device
        }
    }

    fileprivate func addInputSource() {

        guard let captureDeviceInput = try? AVCaptureDeviceInput(device: captureDevice), captureSession.canAddInput(captureDeviceInput) else {
            preconditionFailure()
        }

        captureSession.addInput(captureDeviceInput)
    }
}

// MARK: - Device Output Config -
extension CameraSource {

    fileprivate  func configureDataOutput() {
        captureVideoDataOutput = AVCaptureVideoDataOutput()

        captureVideoDataOutput.videoSettings = [
            kCVPixelBufferPixelFormatTypeKey as AnyHashable: kCVPixelFormatType_32BGRA
        ]

        do {
            try captureDevice.lockForConfiguration()
            captureDevice.activeVideoMinFrameDuration = CMTimeMake(1, 30)
            captureDevice.unlockForConfiguration()
        }
        catch {
            preconditionFailure("Failed to configure capture device. Error: \(error)")
        }

        captureVideoDataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "CameraSourceQueue"))
        captureVideoDataOutput.alwaysDiscardsLateVideoFrames = true

        guard captureSession.canAddOutput(captureVideoDataOutput) else {
            preconditionFailure("Unable to add video output")
        }

        captureSession.addOutput(captureVideoDataOutput)

        captureVideoDataOutput.connections.forEach {
            guard let captureConnection = $0 as? AVCaptureConnection, captureConnection.isVideoOrientationSupported else {
                return
            }
            captureConnection.videoOrientation = .portrait
        }
    }
}

// MARK: - Device Output Buffer Processing -
extension CameraSource: AVCaptureVideoDataOutputSampleBufferDelegate {

    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputSampleBuffer sampleBuffer: CMSampleBuffer!, from connection: AVCaptureConnection!) {

        guard let image = sampleBuffer.asImage else {
            return
        }

        let ocvImage = OCVImage(uiImage: image)

        consumer?.didProduce(ocvImage)
    }
}
