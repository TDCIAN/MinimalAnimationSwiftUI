//
//  FitnessStepsGraphView.swift
//  SwiftUIMinimalAnimation
//
//  Created by JeongminKim on 2022/03/12.
//

import SwiftUI

struct FitnessStepsGraphView: View {
    var body: some View {
        VStack(spacing: 15) {
            Text("Steps by hours")
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)

            BarGraph(steps: steps)
            
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 25)
        .background {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(.ultraThinMaterial)
        }
    }
}

struct FitnessStepsGraphView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct BarGraph: View {
    var steps: [Step]
    var body: some View {
        GraphView()
            .padding(.top, 20)
    }
    
    @ViewBuilder
    func GraphView() -> some View {
        GeometryReader { proxy in
            ZStack {
                VStack(spacing: 0) {
                    ForEach(getGraphLines(), id: \.self) { line in
                        HStack(spacing: 8) {
                            Text("\(Int(line))")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .frame(height: 20)
                            
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 1)
                        }
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .offset(y: -15) // Removing the text size
                    }
                }
                
                HStack {
                    ForEach(steps) { step in
                        VStack(spacing: 0) {
                            VStack(spacing: 5) {
                                RoundedRectangle(cornerRadius: 5, style: .continuous)
                                    .fill(step.color)
                            }
                            .padding(.horizontal, 5)
                            .frame(height: getBarHeight(point: step.value, size: proxy.size))
                            
                            Text(
                                step.key
                                    .replacingOccurrences(of: " AM", with: "")
                                    .replacingOccurrences(of: " PM", with: "")
                            )
                            .font(.caption)
                            .frame(height: 25, alignment: .bottom)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                    }
                }
                .padding(.leading, 30)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
        }
        .frame(height: 190) // Fixed Height
    }
    
    func getBarHeight(point: CGFloat, size: CGSize) -> CGFloat {
        let max = getMax()
        // 25 Text Height
        // 5 Spacing
        let height = (point / max) * (size.height - 37)
        return height
    }
    
    // Getting Sample Graph Lines based on max Value
    func getGraphLines() -> [CGFloat] {
        let max = getMax()
        var lines: [CGFloat] = []
        
        lines.append(max)
        
        for index in 1...4 {
            // dividing the max by 4 and iterating as index for graph lines...
            let progress = max / 4
            
            lines.append(max - (progress * CGFloat(index)))
        }
        
        return lines
    }
    
    
    // Getting Max
    func getMax() -> CGFloat {
        let max = steps.max { first, second in
            return second.value > first.value
        }?.value ?? 0
        
        return max
    }
}