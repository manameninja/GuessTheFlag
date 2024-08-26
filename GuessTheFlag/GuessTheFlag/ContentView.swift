//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Даниил Павленко on 25.08.2024.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var trueScore = 0
    @State private var falseScore = 0
    @State private var failFlag = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.cyan, .indigo], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Tap on the flag of")
                        .foregroundStyle(.white)
                    Text(countries[correctAnswer])
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                        .shadow(radius: 50)
                }
                ForEach(0..<3) { number in
                    Button {
                        flagTapped(number)
                    } label: {
                        Image(countries[number])
                            .cornerRadius(20)
                            .shadow(radius: 20)
                    }
                }
                VStack{
                    Text("Correct answers:")
                        .foregroundStyle(.white)
                        .fontWeight(.ultraLight)
                    Text("\(trueScore)")
                        .foregroundStyle(.green.gradient)
                }
                
                VStack {
                    Text("Wrong answers:")
                        .foregroundStyle(.white)
                        .fontWeight(.ultraLight)
                    Text("\(falseScore)")
                        .foregroundStyle(.red.gradient)
                }
            
            }
        } .alert("Your answer is \(scoreTitle) This is flag of \(failFlag)",  isPresented: $showingScore) {
            Button("Next question!", action: askQuestion)
        } message: {
            Text("Your score is \(trueScore)")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "correct!"
            trueScore += 1
            failFlag = countries[correctAnswer]
        } else {
            scoreTitle = "wrong!"
            falseScore += 1
            failFlag = countries[number]
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
