//
//  Cell01ViewController.swift
//  xapo
//
//  Created by Kamala Tennakoon on 3/5/17.
//  Copyright © 2017 Kamala Tennakoon. All rights reserved.
//

import UIKit
class CellProjectsView: UITableViewCell {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var primaryNoteLabel: UILabel!
    @IBOutlet var secondaryNoteLabel: UILabel!
    var viewModel: CellProjectsViewModel! {
        didSet {
            titleLabel.text = viewModel.name
            primaryNoteLabel.text = viewModel.stars
            secondaryNoteLabel.text = viewModel.description
        }
    }
}
