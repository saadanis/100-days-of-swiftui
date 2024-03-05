//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Saad Anis on 04/03/2024.
//

import SwiftUI

struct ContentView: View {
    
    let choices = ["🪨", "📄", "✂️"]
    let handGestures = ["✊", "✋", "✌️"]
    
    @State var currentQuestion = 1
    let maxQuestions = 10
    
    @State var computerChoice = Int.random(in: 0...2)
    @State var shouldWin = Bool.random()
    @State var score = 0
    
    @State var showingAlert = false
    
    var body: some View {
        VStack {
            Text("question \(currentQuestion)/\(maxQuestions), score \(score)/\(maxQuestions).")
                .foregroundStyle(.secondary)
                .padding()
//                .background(.thinMaterial)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
            Text("i have chosen \(choices[computerChoice]). your job is to \(shouldWin ? "win" : "lose").")
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            HStack {
                ForEach(0..<3) { i in
                    Button(handGestures[i]) {
                        checkChoice(i)
                    }
                    .font(.largeTitle)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight: .infinity)
        .background(.pink)
        .alert("game over", isPresented: $showingAlert) {
            Button {
                resetGame()
            } label: {
                Text("retry")
            }

        } message: {
            Text("you scored \(Int(Double(score)/Double(maxQuestions)*100))%. retry?")
        }
    }
    
    func checkChoice(_ userChoice: Int) {
        
        if choices[userChoice] == choices[(computerChoice + (shouldWin ? 1 : 2)) % 3] {
            score += 1
        } else {
            if score > 0 {
                score -= 1
            }
        }
        
        if currentQuestion == maxQuestions {
            showingAlert = true
        } else {
            currentQuestion += 1
        }
        
        computerChoice = Int.random(in: 0...2)
        shouldWin.toggle()
    }
    
    func resetGame() {
        score = 0
        currentQuestion = 1
    }
}

#Preview {
    ContentView()
}
