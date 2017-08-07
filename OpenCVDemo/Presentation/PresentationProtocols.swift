//
//  PresentationProtocols.swift
//  OpenCVDemo
//
//  Created by Austin Ugbeme on 8/5/17.
//  Copyright © 2017 Waado Labs, Inc. All rights reserved.
//

import Foundation


// MARK: ViewModel protocol
protocol PreviewViewModel: class {

    var frameDidUpdate: ((OCVImage) -> ())? { get set }

    var filters: [String] { get }

    func applyFilter(filter: String)
}
