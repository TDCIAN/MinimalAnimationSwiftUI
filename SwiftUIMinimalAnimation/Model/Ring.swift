//
//  Ring.swift
//  SwiftUIMinimalAnimation
//
//  Created by JeongminKim on 2022/03/12.
//

import SwiftUI

// MARK: Progress Ring Model and Sample Data
struct Ring: Identifiable {
    var id = UUID().uuidString
    var progress: CGFloat
    var value: String
    var keyIcon: String
    var keyColor: Color
    var isText: Bool = false
}

var rings: [Ring] = [
    Ring(progress: 72, value: "Steps", keyIcon: "figure.walk", keyColor: Color.green),
    Ring(progress: 36, value: "Calories", keyIcon: "flame.fill", keyColor: Color.red),
    Ring(progress: 91, value: "Sleep time", keyIcon: "😴", keyColor: Color.purple, isText: true)
]

