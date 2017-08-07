//
//  MediaProcessorList.swift
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

import Foundation

class MediaProcessorList {

    fileprivate var source: Source!
    fileprivate var processorList: [Processor] = []
    fileprivate var frameSink: FrameConsumer!
    fileprivate var lockQueue = DispatchQueue(label: "MediaEngineProcessQueueLock")

    init(with source: Source, frameSink: FrameConsumer) {
        self.source = source
        self.frameSink = frameSink

        self.source.consumer = frameSink
    }

    func add(_ processor: Processor) {
        lockQueue.sync { [weak self] in
            self?.doAdd(processor)
        }
    }

    func clearProcessors() {
        lockQueue.sync { [weak self] in
            self?.doClear()
        }
    }

    func start() {
        source.start()
    }

    func stop() {
        source.stop()
    }
}

extension MediaProcessorList {

    fileprivate func doAdd(_ processor: Processor) {
        if processorList.isEmpty {
            source.consumer = processor
        }
        else {
            processorList.last?.consumer = processor
        }

        processor.consumer = frameSink
        
        processorList.append(processor)
    }

    fileprivate func doClear() {
        source.consumer = frameSink
        processorList.removeAll()
    }
}
