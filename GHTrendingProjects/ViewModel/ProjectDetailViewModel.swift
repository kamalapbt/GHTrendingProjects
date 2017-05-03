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

class ProjectDetailViewModel {
    var project : Project?
    init(project: Project?) {
        self.project = project
    }
    func getSegmentTitle(section: Int) -> String {
        if let tmpProject = project {
            switch section {
            case 1:
                return "⑂ \(tmpProject.forks) Forks"
            default:
                return "★ \(tmpProject.stars) Stars"
            }
        }
        return ""
    }
    public func avatarFromServerURL(urlString: String, complition: @escaping (UIImage?) ->()) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error?.localizedDescription ?? "Error")
                return
            } else {
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data!)
                    complition(image)
                })
            }
            
        }).resume()
    }
    public func fetchReadme(repositoryUrl: String, complition: @escaping (String?) ->()) {
        URLSession.shared.dataTask(with: NSURL(string: "\(repositoryUrl)/readme")! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error?.localizedDescription ?? "Error")
                return
            } else {
                if(data != nil) {
                    let json = JSON(data: data!)
                    let contentBase64 = json["content"].stringValue
                    let decodedData = NSData(base64Encoded: contentBase64, options:[NSData.Base64DecodingOptions.ignoreUnknownCharacters])
                    let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)
                    let readmecontent = decodedString! as String
                    DispatchQueue.main.async(execute: { () -> Void in
                        complition(readmecontent)
                    })
                }
            }
        }).resume()
    }
}





