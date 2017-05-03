//
//  ProjectsClient.swift
//  xapo
//
//  Created by Kamala Tennakoon on 3/5/17.
//  Copyright © 2017 Kamala Tennakoon. All rights reserved.
//

import UIKit
import SwiftyJSON

class ProjectsClient: NSObject {
    func fetchProject(onCompletion: @escaping ([Project]?) -> ()) {
        let request = NSMutableURLRequest(url: URL(string: "https://api.github.com/search/repositories?sort=stars&order=desc&q=language:java")!)
        let session = URLSession.shared
        let requestUrl = request as URLRequest
        let task = session.dataTask(with: requestUrl, completionHandler: {data, response, error -> Void in
            if error != nil {
                onCompletion(nil)
                return
            } else {
                var json:JSON?
                var tmpProjects: [Project]? = nil
                if(data != nil) {
                    json = JSON(data: data!)
                    if let items = json?["items"].arrayValue {
                        for i in 0 ..< items.count {
                            let tmpData = items[i]
                            let tmpname = tmpData["full_name"].stringValue
                            let tmpavatar = tmpData["owner"]["avatar_url"].stringValue
                            let tmpusername = tmpData["owner"]["login"].stringValue
                            let tmpdescription = tmpData["description"].stringValue
                            let tmpstars = tmpData["stargazers_count"].intValue
                            let tmpforks = tmpData["forks_count"].intValue
                            let tmprepositoryurl = tmpData["url"].stringValue
                            
                            let formattedData: Project = Project(avatar: tmpavatar, name: tmpname, username: tmpusername, description: tmpdescription, stars: tmpstars, forks: tmpforks, repositoryUrl: tmprepositoryurl)
                            
                            if (tmpProjects != nil) {
                                tmpProjects!.append(formattedData)
                            } else {
                                tmpProjects = [formattedData]
                            }
                        }
                        onCompletion(tmpProjects)
                    }
                } else {
                    onCompletion(nil)
                }
                return
            }
        })
        task.resume()
    }
}
