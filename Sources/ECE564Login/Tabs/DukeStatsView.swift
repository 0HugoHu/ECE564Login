//
//  StatsView.swift
//  Hugo
//
//  Created by Hugooooo on 10/1/23.
//

import SwiftUI
import Charts

struct DukeStatsView: View {
    @EnvironmentObject var dataModel: DukePersonDictTA
    var peopleList: [DukePersonTA] {
        return Array(dataModel.people.values)
    }
    var viewModel: DukeStatsViewModel {
        return DukeStatsViewModel(dataModel: peopleList)
    }
    
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading) {
                ZStack{
                    LinearGradient(gradient: Gradient(colors: [Color(red: 240/255.0, green: 222/255.0, blue: 219/255.0), Color(red: 217/255.0, green: 233/255.0, blue: 244/255.0)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea()
                    
                    VStack (alignment: .leading) {
                        Text("ECE 564.01.Sp24\nMobile Development")
                            .font(.title)
                        
                        Grid(alignment: .leading, horizontalSpacing: 32) {
                            GridRow {
                                Text("Total People:  \(viewModel.totalPeople)")
                                Text("Total Professor:  \(viewModel.totalProfessors)")
                            }
                            GridRow {
                                Text("Total TA:  \(viewModel.totalTAs)")
                                Text("Total Students:  \(viewModel.totalStudents)")
                            }
                        }
                        .padding(.top, 8)
                        
                        Text(junkString)
                            .foregroundColor(.clear)
                            .frame(height: 0)
                    }
                    .padding()
                }
                .frame(height: 180)
                .background(Color.white)
                .cornerRadius(10)
                .padding([.leading, .trailing], 16)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
                
                // Bar charts
                // Gender
                VStack {
                    GroupBox("Gender") {
                        let genderData: [ChartData] = viewModel.genders.map { (gender, count) in
                            return ChartData(key: gender, value: Double(count))
                        }
                        
                        Chart(genderData.sorted{ $0.value > $1.value }) { genderCount in
                            let gender = genderCount.key
                            let count = genderCount.value
                            
                            BarMark(
                                x: .value("Count", count),
                                y: .value("Gender", gender)
                            )
                            .foregroundStyle(Color(red: 201/255.0, green: 74/255.0, blue: 99/255.0))
                            .annotation(position: .trailing, alignment: .trailing, spacing: 5) {
                                Text("\(gender): \(Int(count))")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        .chartXAxis(.hidden)
                        .chartYAxis(.hidden)
                    }
                    .frame(height: 150)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
                }
                .padding([.leading, .trailing], 16)
                .padding([.top, .bottom], 8)
                
                
                // Program
                VStack {
                    GroupBox("Program") {
                        let programData: [ChartData] = viewModel.programs.map { (gender, count) in
                            return ChartData(key: gender, value: Double(count))
                        }
                        
                        Chart(programData.sorted{ $0.value > $1.value }) { genderCount in
                            let gender = genderCount.key
                            let count = genderCount.value
                            
                            BarMark(
                                x: .value("Count", count),
                                y: .value("Gender", gender)
                            )
                            .foregroundStyle(Color(red: 74/255.0, green: 150/255.0, blue: 201/255.0))
                            .annotation(position: .trailing, alignment: .trailing, spacing: 5) {
                                Text("\(gender): \(Int(count))")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        .chartXAxis(.hidden)
                        .chartYAxis(.hidden)
                    }
                    .frame(height: 200)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
                }
                .padding([.leading, .trailing], 16)
                .padding([.top, .bottom], 8)
                
                
                // Plan
                VStack {
                    GroupBox("Plan") {
                        let programData: [ChartData] = viewModel.plans.map { (gender, count) in
                            return ChartData(key: gender, value: Double(count))
                        }
                        
                        Chart(programData.sorted{ $0.value > $1.value }) { genderCount in
                            let gender = genderCount.key
                            let count = genderCount.value
                            
                            BarMark(
                                x: .value("Count", count),
                                y: .value("Gender", gender)
                            )
                            .foregroundStyle(Color(red: 97/255.0, green: 180/255.0, blue: 207/255.0))
                            .annotation(position: .trailing, alignment: .trailing, spacing: 5) {
                                Text("\(gender): \(Int(count))")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        .chartXAxis(.hidden)
                        .chartYAxis(.hidden)
                    }
                    .frame(height: 200)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
                }
                .padding([.leading, .trailing], 16)
                .padding([.top, .bottom], 8)
                
                
                // From
                VStack {
                    GroupBox("Programming Language") {
                        let programData: [ChartData] = viewModel.languages.map { (gender, count) in
                            return ChartData(key: gender, value: Double(count))
                        }
                        
                        Chart(programData.sorted{ $0.value > $1.value }) { genderCount in
                            let gender = genderCount.key
                            let count = genderCount.value
                            
                            BarMark(
                                x: .value("Count", count),
                                y: .value("Gender", gender)
                            )
                            .foregroundStyle(Color(red: 201/255.0, green: 150/255.0, blue: 201/255.0))
                            .annotation(position: .trailing, alignment: .trailing, spacing: 5) {
                                Text("\(gender): \(Int(count))")
                                    .font(.footnote)
                                    .foregroundColor(.gray)
                            }
                        }
                        .chartXAxis(.hidden)
                        .chartYAxis(.hidden)
                    }
                    .frame(height: 400)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
                }
                .padding([.leading, .trailing], 16)
                .padding([.top, .bottom], 8)
                
                VStack (alignment: .leading) {
                    HStack {
                        Text("Total Image Size:")
                            .foregroundColor(.primary)
                        Text("\(viewModel.totalImageSize)")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .bold()
                    }
                    .padding([.top, .bottom], 8)
                    
                    HStack {
                        Text("Largest Image:")
                            .foregroundColor(.primary)
                        let content = viewModel.largestImageSizeOwner.split(separator: "$")
                        Text("\(String(content[0]))")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .bold()
                        Text("- \(String(content[1]))")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                            .bold()
                    }
                    .padding([.top, .bottom], 8)
                    
                    HStack {
                        Text("Smallest Image:")
                            .foregroundColor(.primary)
                        let content = viewModel.smallestImageSizeOwner.split(separator: "$")
                        Text("\(String(content[0]))")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .bold()
                        Text("- \(String(content[1]))")
                            .font(.headline)
                            .foregroundColor(.accentColor)
                            .bold()
                    }
                    .padding([.top, .bottom], 8)
                
                    
                    Text(junkString)
                        .foregroundColor(.clear)
                        .frame(height: 0)
                }
                .padding()
                .frame(height: 160)
                .background(Color.white)
                .cornerRadius(10)
                .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 3)
                .padding([.leading, .trailing], 16)
            }
            Spacer()
        }
    }
}



struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        
        DukeStatsView()
            .environmentObject(DukePersonDictTA())
    }
}
