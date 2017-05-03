//
//  Projects.swift
//  xapo
//
//  Created by Kamala Tennakoon on 3/5/17.
//  Copyright © 2017 Kamala Tennakoon. All rights reserved.
//

import Foundation
import ReactiveSwift
import SwiftyJSON

struct Project {
    let avatar: String
    let name: String
    let username: String
    let description: String
    let stars: Int
    let forks: Int
    let repositoryUrl: String
}
