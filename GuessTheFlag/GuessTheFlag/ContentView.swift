//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Saad Anis on 20/02/2024.
//

import SwiftUI

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var showingGameOver = false
    
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    
    @State private var gameOverMessage = ""
    
    @State private var currentScore = 0
    
    @State private var currentQuestion = 1
    private let totalQuestions = 8
    
    @State private var selectedFlag = -1
    @State private var animationAmount = 0.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
                .ignoresSafeArea()
            VStack {
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                Text("\(currentQuestion)/\(totalQuestions)")
                    .font(.subheadline)
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of") 
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                                flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(RoundedRectangle(cornerRadius: 10.0))
                                .shadow(radius: 5)
                                .rotation3DEffect(
                                    .degrees(
                                        number == selectedFlag ? 360 : 0
                                    ), axis: (x: 0, y: 1, z: 0)
                                )
                                .animation(.default, value: selectedFlag)
                                .opacity(selectedFlag == -1 || number == selectedFlag ? 1 : 0.5)
                                .animation(.bouncy, value: selectedFlag)
                                .saturation(selectedFlag == -1 || number == selectedFlag ? 1 : 0.2)
                        }
                    }
                }
//                .frame(maxWidth: .infinity)
                .padding(20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Text("Score: \(currentScore)")
                    .foregroundStyle(.white)
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game Over", isPresented: $showingGameOver) {
            Button("Reset", action: reset)
        } message: {
            Text("Your final score is \(currentScore).")
        }
    }
    
    func flagTapped(_ number: Int) {
        
        selectedFlag = number
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            currentScore += 10
            scoreMessage = "Your current score is \(currentScore)."
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That's the flag of \(countries[number])."
        }

        showingScore = true
    }
    
    func askQuestion() {
        selectedFlag = -1
        if currentQuestion == 8 {
            showingGameOver = true
        } else {
            currentQuestion += 1
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    }
    
    func reset() {
        currentQuestion = 1
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        currentScore = 0
        selectedFlag = -1
    }
}

#Preview {
    ContentView()
}
