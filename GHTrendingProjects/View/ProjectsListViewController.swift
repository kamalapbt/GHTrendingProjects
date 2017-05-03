//
//  ProjectsListViewController.swift
//  xapo
//
//  Created by Kamala Tennakoon on 3/5/17.
//  Copyright © 2017 Kamala Tennakoon. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift

class ProjectsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var projectsTblView: UITableView!
    private var projectsVM: ProjectsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.projectsTblView.dataSource = self
        self.projectsTblView.delegate = self
        self.projectsVM = ProjectsViewModel.init()
        self.projectsVM.fetchTrendedProjects {
            DispatchQueue.main.async {
                self.projectsTblView.reloadData()
            }
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = projectsVM.title
    }
    func numberOfSections(in: UITableView)-> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectsVM.getProjectsCount()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProjectCell")
            as! CellProjectsView
        cell.viewModel = projectsVM.createProjectCell(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vcProjectDescription: ProjectDescriptionViewController = self.storyboard?.instantiateViewController(withIdentifier: "idVCProjectDescrition") as! ProjectDescriptionViewController
        vcProjectDescription.projectDetailVM = ProjectDetailViewModel.init(project: self.projectsVM.getProjectForIndex(index: indexPath.row))
        self.navigationController?.navigationBar.backItem?.title = "Back"
        self.navigationController?.pushViewController(vcProjectDescription, animated: true)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

