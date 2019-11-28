//
//  LoadableProtocol.swift
//  TopMusic
//
//  Created by Jon-Martin Heiberg on 27/11/2019.
//  Copyright © 2019 JMHeiberg. All rights reserved.
//

import Foundation

protocol Loadable {
    var strArtist: String { get }
    var strName: String { get }
    var strThumb: String? { get }
}
