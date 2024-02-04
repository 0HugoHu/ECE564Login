//
//  DukeStatsViewModel.swift
//  Hugo
//
//  Created by Hugooooo on 10/1/23.
//

import Foundation

struct ChartData: Identifiable {
    let id = UUID()
    let key: String
    let value: Double
}

class DukeStatsViewModel: ObservableObject {
    var dataModel: [DukePersonTA] = []
    
    init(dataModel: [DukePersonTA]) {
        self.dataModel = dataModel
    }
    
    var totalPeople: Int {
        return dataModel.count
    }
    
    
    var totalProfessors: Int {
        return dataModel.filter { $0.role == .Professor }.count
    }
    
    
    var totalTAs: Int {
        return dataModel.filter { $0.role == .TA }.count
    }
    
    
    var totalStudents: Int {
        return dataModel.filter { $0.role == .Student }.count
    }
    
    var genders: [String: Int] {
        let genderCounts = dataModel.reduce(into: [String: Int]()) { (result, person) in
            let genderName = person.gender.rawValue
            result[genderName, default: 0] += 1
        }
        return genderCounts
    }
    
    var programs: [String: Int] {
//        let programCounts = dataModel.reduce(into: [String: Int]()) { (result, person) in
//            let program = person.program.rawValue.lowercased()
//            if program.contains("a&s") || program.contains("ms") || program.contains("science") {
//                result["M.S.", default: 0] += 1
//            } else if program.contains("ece") || program.contains("engr") || program.contains("engineer") || program.contains("e.") {
//                result["M.Eng.", default: 0] += 1
//            } else {
//                result["Other", default: 0] += 1
//            }
//        }
//        return programCounts
        let genderCounts = dataModel.reduce(into: [String: Int]()) { (result, person) in
            let genderName = person.program.rawValue
            result[genderName, default: 0] += 1
        }
        return genderCounts
    }

    
    var plans: [String: Int] {
//        let planCounts = dataModel.reduce(into: [String: Int]()) { (result, person) in
//            let plan = person.plan.rawValue.lowercased() + person.program.rawValue.lowercased()
//            if plan.contains("fin") {
//                result["FinTech", default: 0] += 1
//            } else if plan.contains("econ") {
//                result["EconCS", default: 0] += 1
//            } else if plan.contains("cs") || plan.contains("computer science") {
//                result["CS", default: 0] += 1
//            } else if plan.contains("ece") || plan.contains("elec") || plan.contains("egr") || plan.contains("engineer") {
//                result["ECE", default: 0] += 1
//            } else {
//                result["Other", default: 0] += 1
//            }
//        }
//        return planCounts
        let genderCounts = dataModel.reduce(into: [String: Int]()) { (result, person) in
            let genderName = person.plan.rawValue
            result[genderName, default: 0] += 1
        }
        return genderCounts
    }

    
    var languages: [String: Int] {
        let languageCounts = dataModel.reduce(into: [String: Int]()) { (result, person) in
            if let personLanguages = person.languages {
                for language in personLanguages {
                    // Special case
                    var newLanguage = language
                    newLanguage.replace("and ", with: "")
                    let normalizedLanguage = newLanguage.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
                    let individualLanguages = normalizedLanguage.components(separatedBy: ",")
                    
                    for individualLanguage in individualLanguages {
                        let trimmedLanguage = individualLanguage.trimmingCharacters(in: .whitespacesAndNewlines)
                        result[trimmedLanguage.capitalized, default: 0] += 1
                    }
                }
            }
        }
        return languageCounts
    }

    var totalImageSize: String {
        let totalSizeInBytes = dataModel.reduce(0) { $0 + $1.picture.count }
        
        if totalSizeInBytes < 1000 {
            return "\(totalSizeInBytes) B"
        } else if totalSizeInBytes < 1000000 {
            let totalSizeInKB = Double(totalSizeInBytes) / 1000.0
            return String(format: "%.2f KB", totalSizeInKB)
        } else {
            let totalSizeInMB = Double(totalSizeInBytes) / 1000000.0
            return String(format: "%.2f MB", totalSizeInMB)
        }
    }


    var largestImageSizeOwner: String {
        guard let person = dataModel.max(by: { $0.picture.count < $1.picture.count }) else {
            return "N/A"
        }
        let totalSizeInKB = Double(person.picture.count) / 1000.0
        if totalSizeInKB >= 1000 {
            return "\(String(format: "%.2f MB", totalSizeInKB / 1000.0))$\(person.fName) \(person.lName)"
        }
        return "\(String(format: "%.2f KB", totalSizeInKB))$\(person.fName) \(person.lName)"
    }

    var smallestImageSizeOwner: String {
        guard let person = dataModel.min(by: { $0.picture.count < $1.picture.count }) else {
            return "N/A"
        }
        let totalSizeInKB = Double(person.picture.count) / 1000.0
        return "\(String(format: "%.2f KB", totalSizeInKB))$\(person.fName) \(person.lName)"
    }

}
