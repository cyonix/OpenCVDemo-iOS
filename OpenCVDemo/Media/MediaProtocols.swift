//
//  MediaProtocols.swift
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

import Foundation

protocol FrameConsumer: class {
    func didProduce(_ frame: OCVImage)
}

protocol Source: class {

    weak var consumer: FrameConsumer? { get set }

    func start()
    func stop()
}

protocol Processor: FrameConsumer {

    weak var consumer: FrameConsumer? { get set }
}
