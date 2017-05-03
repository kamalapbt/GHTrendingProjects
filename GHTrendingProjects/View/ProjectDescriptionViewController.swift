//
//  ProjectDescriptionViewController.swift
//  xapo
//
//  Created by Kamala Tennakoon on 3/5/17.
//  Copyright © 2017 Kamala Tennakoon. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class ProjectDescriptionViewController: UIViewController {
    @IBOutlet weak var profilePhotoImage: UIImageView!
    @IBOutlet weak var usernameLable: UILabel!
    @IBOutlet weak var projeceDescriptionLabel: UILabel!
    @IBOutlet weak var readmeWebview: UIWebView!
    @IBOutlet weak var interactionStepper: UISegmentedControl!
    var projectDetailVM: ProjectDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = projectDetailVM.project?.name
        self.profilePhotoImage.layer.borderColor = UIColor.white.cgColor
        let tmpCornerSize = self.profilePhotoImage.frame.size.height / 2
        self.profilePhotoImage.layer.cornerRadius = CGFloat(tmpCornerSize)
        self.profilePhotoImage.layer.masksToBounds = true
        
        self.readmeWebview.backgroundColor = UIColor.clear
        
        self.usernameLable.text = projectDetailVM.project?.username
        self.projeceDescriptionLabel.text = projectDetailVM.project?.description
        self.interactionStepper.setTitle(projectDetailVM.getSegmentTitle(section:0), forSegmentAt: 0)
        self.interactionStepper.setTitle(projectDetailVM.getSegmentTitle(section:1), forSegmentAt: 1)
        
        self.projectDetailVM.avatarFromServerURL(urlString: (self.projectDetailVM.project?.avatar)!) { (data) in
            DispatchQueue.main.async {
                self.profilePhotoImage.image = data
            }
        }
        self.projectDetailVM.fetchReadme(repositoryUrl: (self.projectDetailVM.project?.repositoryUrl)!) { (readmeContent) in
            DispatchQueue.main.async {
                self.readmeWebview.loadHTMLString(readmeContent!, baseURL: nil)
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.topItem!.title = "Back"
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

