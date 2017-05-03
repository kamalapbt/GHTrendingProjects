//
//  ProjectsViewModel.swift
//  xapo
//
//  Created by Kamala Tennakoon on 3/5/17.
//  Copyright © 2017 Kamala Tennakoon. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import SwiftyJSON
import Result

class ProjectsViewModel {
    let title: String = "Github Trends"
    var projects : [Project]?
    var clientProjects: ProjectsClient!
    
    init() {
        self.clientProjects = ProjectsClient()
    }
    func fetchTrendedProjects(onCompletion: @escaping () ->()) {
        clientProjects.fetchProject { (prjcts) in
            self.projects = prjcts
            onCompletion()
        }
    }
    func getProjectsCount() -> Int {
        if let prjCounts: Int = projects?.count {
            return prjCounts
        }
        return 0
    }
    func getProjectForIndex(index: Int) -> Project {
        return projects![index]
    }
    func createProjectCell(index: Int)-> CellProjectsViewModel {
        let tmpProject: Project = projects![index]
        return CellProjectsViewModel.init(withProject: tmpProject)
    }
    func showProjectDetails(index: Int) {
        
    }
}
struct CellProjectsViewModel {
    let name: String
    let stars: String
    let description: String
    init(withProject project: Project) {
        self.name = project.name
        self.stars = "\(project.stars) stars"
        self.description = project.description
    }
}
