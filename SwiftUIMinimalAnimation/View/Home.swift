//
//  Home.swift
//  SwiftUIMinimalAnimation
//
//  Created by JeongminKim on 2022/03/12.
//

import SwiftUI

struct Home: View {
    // MARK: UI Properties
    @State var currentWeek: [Date] = []
    @State var currentDay: Date = Date()
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Current Week")
                    .font(.title)
                    .fontWeight(.bold)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title3)
                })
            }
            .foregroundColor(.white)
            
            // MARK: Current Week View
            HStack(spacing: 10) {
                ForEach(currentWeek, id: \.self) { date in
                    Text(extractDate(date: date))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity)
                }
            }
            
        }
        .padding()
        .onAppear(perform: extractCurrentWeek)
    }
    
    // MARK: Extracting Current Week
    func extractCurrentWeek() {
        let calendar = Calendar.current
        let week = calendar.dateInterval(of: .weekOfMonth, for: Date())
        
        guard let firstDay = week?.start else {
            return
        }
        
        (0..<7).forEach { day in
            if let weekDay = calendar.date(byAdding: .day, value: day, to: firstDay) {
                currentWeek.append(weekDay)
//                print("weekDay: \(weekDay), currentWeek: \(currentWeek)")
            }
        }
    }
    
    // MARK: Extracting Custom Date Components
    func extractDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        return formatter.string(from: date)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
