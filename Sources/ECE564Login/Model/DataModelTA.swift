//
//  DataModel.swift
//  DukePeople
//
//  Created by Hugooooo on 9/5/23.
//

import Foundation
import SwiftUI

// Duke Person Data Model
struct DukePersonTA : CustomStringConvertible, Codable {
    let DUID: Int
    var netID: String?
    var fName: String
    var lName: String
    var from: String
    var gender: Gender
    var role: Role
    var program: Program
    var plan: Plan
    var hobby: String?
    var languages: [String]?
    var moviegenre: String?
    var team: String?
    var picture: String
    
    
    // Custom description
    var description: String {
        return " "
    }
    
    init(DUID: Int) {
        self.DUID = DUID
        self.fName = ""
        self.lName = ""
        self.from = ""
        self.gender = .Unknown
        self.role = .Unknown
        self.program = .NotApplicable
        self.plan = .NotApplicable
        self.picture = ""
        self.hobby = ""
        self.languages = [String]()
        self.moviegenre = ""
        self.team = ""
        self.netID = ""
    }
    
    init(DUID: Int, netid: String, fName: String, lName: String, email: String, from: String, gender: Gender, role: Role, program: String, plan: String, picture: String, hobby: String, languages: [String], moviegenre: String, team: String) {
        self.DUID = DUID
        self.fName = fName
        self.lName = lName
        self.from = from
        self.gender = gender
        self.role = role
        self.program = Program(rawValue: program)!
        self.plan = Plan(rawValue: plan)!
        self.picture = picture
        self.hobby = hobby
        self.languages = languages
        self.moviegenre = moviegenre
        self.team = team
        self.netID = netid
    }
}


// Duke Person Dictionary
class DukePersonDictTA : NSObject, URLSessionDownloadDelegate, ObservableObject {
    
    // A dictionary to store DukePerson objects
    @Published var people: [Int : DukePersonTA]
    @Published var downloadProgress: Double = 0.0
    @Published var isDownloading: Bool = false
    @Published var isUploading: Bool = false
    
    var errorFlag: Bool = true
    var errorMessage = ""
    var replaceFlag = true
    var replaceDUIDFlag = false
    var downloadReplace = false
    var uploadDone = 0
    
    private lazy var urlSession: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config, delegate: self, delegateQueue: nil)
    }()
    
    
    override init() {
        self.people = [Int : DukePersonTA]()
        super.init()
    }
    
    
    
    /*
     If the "newPerson.DUID" is not already in the database, add newPerson to the
     database and return true. Otherwise return false.
     */
    func add(_ newPerson: DukePersonTA) -> Bool {
        if people[newPerson.DUID] != nil {
            return false
        }
        people[newPerson.DUID] = newPerson
        return true
    }
    
    
    /*
     Looks for the "updatedPerson.DUID" in the database. If found, replaces that entry, and returns
     true. If not found, then adds "updatedPerson" to database and returns false.
     */
    func update(_ updatedPerson: DukePersonTA) -> Bool {
        let existingPerson = people[updatedPerson.DUID] != nil
        if !existingPerson {
            people[updatedPerson.DUID] = updatedPerson
            return false
        }
        // Update properties based on non-nil and non-empty values in updatedPerson
        if !updatedPerson.fName.isEmpty {
            people[updatedPerson.DUID]!.fName = updatedPerson.fName
        }
        
        if !updatedPerson.lName.isEmpty {
            people[updatedPerson.DUID]!.lName = updatedPerson.lName
        }
        
        if !updatedPerson.from.isEmpty {
            people[updatedPerson.DUID]!.from = updatedPerson.from
        }
        
        if updatedPerson.gender != .Unknown {
            people[updatedPerson.DUID]!.gender = updatedPerson.gender
        }
        
        if updatedPerson.role != .Unknown {
            people[updatedPerson.DUID]!.role = updatedPerson.role
        }
        
        if let netid = updatedPerson.netID, !netid.isEmpty {
            people[updatedPerson.DUID]!.netID = netid
        }
        
        people[updatedPerson.DUID]!.program = updatedPerson.program
        
        people[updatedPerson.DUID]!.plan = updatedPerson.plan
        
        if !updatedPerson.picture.isEmpty {
            people[updatedPerson.DUID]!.picture = updatedPerson.picture
        }
        
        if let hobby = updatedPerson.hobby, !hobby.isEmpty {
            people[updatedPerson.DUID]!.hobby = hobby
        }
        
        if let languages = updatedPerson.languages, !languages.isEmpty {
            people[updatedPerson.DUID]!.languages = languages
        }
        
        if let moviegenre = updatedPerson.moviegenre, !moviegenre.isEmpty {
            people[updatedPerson.DUID]!.moviegenre = moviegenre
        }
        
        if let team = updatedPerson.team, !team.isEmpty {
            people[updatedPerson.DUID]!.team = team
        }
        
        return true
    }
    
    
    
    /*
     Searches for an entry with "DUID". If found, returns the info as an Optional DukePerson.
     If not found, returns nil.
     */
    func find(_ DUID: Int) -> DukePersonTA? {
        return people[DUID]
    }
    
    
    func find(netID: String) -> Int? {
        for (duid, person) in people {
            if person.netID == netID {
                return duid
            }
        }
        return nil
    }
    
    
    func getUserType(netID: String) -> Role? {
        for (_, person) in people {
            if person.netID == netID {
                return person.role
            }
        }
        return nil
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        if let d = try? Data(contentsOf: location) {
            do {
                let decoder = JSONDecoder()
                var dukePeopleArray = try decoder.decode([DukePersonTA].self, from: d)
                
                for i in 0..<dukePeopleArray.count {
                    if dukePeopleArray[i].hobby == nil {
                        dukePeopleArray[i].hobby = ""
                    }
                    if dukePeopleArray[i].languages == nil {
                        dukePeopleArray[i].languages = [String]()
                    }
                    if dukePeopleArray[i].team == nil {
                        dukePeopleArray[i].team = ""
                    }
                    if dukePeopleArray[i].moviegenre == nil {
                        dukePeopleArray[i].moviegenre = ""
                    }
                    if dukePeopleArray[i].netID == nil {
                        dukePeopleArray[i].netID = ""
                    }
                }
                DispatchQueue.main.async {
                    if (self.downloadReplace) {
                        self.people = [Int: DukePersonTA]()
                    }
                    for dukePerson in dukePeopleArray {
                        self.people[dukePerson.DUID] = dukePerson
                    }
                    self.errorFlag = false
                }
            } catch {
                self.errorFlag = true
                self.errorMessage = "Error Decoding from Asset!"
            }
        } else {
            self.errorFlag = true
            self.errorMessage = "Error Downloading to Asset!"
        }
        self.replaceDUIDFlag = false;
    }
    
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        DispatchQueue.main.async {
            self.downloadProgress = Double(totalBytesWritten)/Double(totalBytesExpectedToWrite)
//            print(self.downloadProgress)
        }
    }
    
    
    /*
     Uploads the data model to the specified website.
     */
    func upload(website: String, auth: String, update: Bool, id: String, duid: Int) -> Bool {
        self.isUploading = true
        self.errorFlag = false
        self.uploadDone = 0
        let urlString = website + (update ? "/\(id)" : "/create")
        guard let url = URL(string: urlString) else {
            errorFlag = true
            self.uploadDone = -1
            errorMessage = "Invalid URL!"
            return false
        }
        print("Upload: \(urlString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = update ? "PUT" : "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let base64Auth = auth.data(using: .utf8)!.base64EncodedString()
        let authValue = "Basic \(base64Auth)"
        request.setValue(authValue, forHTTPHeaderField: "Authorization")
        
        do {
            let jsonData: Data = try JSONEncoder().encode(self.find(duid)!)
            request.httpBody = jsonData
            
            let httpTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        self.isUploading = false
                        self.errorFlag = true
                        self.uploadDone = -2
                        print("1: Error uploading data: \(error!)")
                    } else if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            self.isUploading = false
                            self.uploadDone = 1
                        } else {
                            self.isUploading = false
                            self.errorFlag = true
                            print("2: Error uploading data: \(httpResponse.statusCode)")
                        }
                    }
                }
            }
            httpTask.resume()
        } catch {
            DispatchQueue.main.async {
                self.isUploading = false
                self.errorFlag = true
                self.uploadDone = -2
                print("3: Error uploading data: \(error)")
            }
        }
        
        return !self.errorFlag
    }
    
    
    func changePassword(netID: String, auth: String, newPassword: String) -> Bool {
        self.isUploading = true
        self.errorFlag = false
        self.uploadDone = 0
        let urlString = changePasswordUrlString
        guard let url = URL(string: urlString) else {
            errorFlag = true
            self.uploadDone = -1
            errorMessage = "Invalid URL!"
            return false
        }
        print("Change Password: \(urlString)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let base64Auth = auth.data(using: .utf8)!.base64EncodedString()
        let authValue = "Basic \(base64Auth)"
        request.setValue(authValue, forHTTPHeaderField: "Authorization")
        
        do {
            let role = self.getUserType(netID: netID) ?? Role.Other
            let userType: UserType
            switch role {
            case .Student:
                userType = .Student
            case .TA:
                userType = .TA
            case .Professor:
                userType = .Professor
            default:
                userType = .Other
            }
            var userAuth: UserAuth = UserAuth(username: netID, userType: userType)
            userAuth.password = newPassword
            
            let jsonData: Data = try JSONEncoder().encode(userAuth)
            print(jsonData.base64EncodedString())
            request.httpBody = jsonData
            
            let httpTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                DispatchQueue.main.async {
                    if error != nil {
                        self.isUploading = false
                        self.errorFlag = true
                        self.uploadDone = -2
                        print("1: Error changing password: \(error!)")
                    } else if let httpResponse = response as? HTTPURLResponse {
                        if httpResponse.statusCode == 200 {
                            self.isUploading = false
                            self.uploadDone = 1
                        } else {
                            self.isUploading = false
                            self.errorFlag = true
                            print("2: Error changing password: \(httpResponse.statusCode)")
                        }
                    }
                }
            }
            httpTask.resume()
        } catch {
            DispatchQueue.main.async {
                self.isUploading = false
                self.errorFlag = true
                self.uploadDone = -2
                print("3: Error changing password: \(error)")
            }
        }
        
        return !self.errorFlag
    }
    
    
    
    /*
     Downloads the data model from the specified website.
     */
    func download(website: String = defaultUrlString, auth: String = fakeAuth) -> Bool {
        self.downloadProgress = 0.0
        self.isDownloading = true
        self.errorFlag = false
        let url = URL(string: website + "/all")
        var req = URLRequest(url: url!)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let base64Auth = auth.data(using: .utf8)!.base64EncodedString()
        let authValue = "Basic \(base64Auth)"
        req.setValue(authValue, forHTTPHeaderField: "Authorization")
        
        let task = urlSession.downloadTask(with: req)
        task.resume()
        
        return !self.errorFlag
    }
    
    
}

