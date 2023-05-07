//
//  ContentView.swift
//  POCIAAlgorithm
//
//  Created by Lucas Barbosa de Oliveira on 02/05/23.
//

import SwiftUI

struct ContentView: View {

    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            Text("Prediction: \(viewModel.prediction)")
            Button {
                viewModel.trainAndPredict()
            } label: {
                Image(systemName: "plus")
            }
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .padding()

    }
}

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var prediction: Int = -1
        let inputs = [[0.0, 0.0], [0.0, 1.0], [1.0, 0.0], [1.0, 1.0]]
        let labels = [0, 0, 0, 1]
        let perceptron = Perceptron(learningRate: 0.1, inputSize: 2)

        func trainAndPredict() {
            perceptron.train(inputs: inputs, labels: labels, epochs: 10)
            prediction = perceptron.predict([1.0, 1.0])
        }

    }
}

class Perceptron {
    var learningRate: Double
    var weights: [Double]



    init(learningRate: Double , inputSize: Int = 0 ){
        self.learningRate = learningRate
        self.weights = [Double](repeating: 0.0, count: inputSize)
    }

    func activationFunction(_ input: Double) -> Int {
        return input > 0 ? 1 : 0
    }

    func predict(_ inputs: [Double]) -> Int {
            var sum = 0.0
            for i in 0..<inputs.count {
                sum += inputs[i] * weights[i]
            }
            let output = activationFunction(sum)
            return output
    }

    func train(inputs: [[Double]], labels: [Int], epochs: Int) {
        for epoch in 0..<epochs {
            for i in 0..<inputs.count {
                let prediction = predict(inputs[i])
                let error = Double(labels[i] - prediction)
                for j in 0..<weights.count {
                    weights[j] += learningRate * error * inputs[i][j]
                }
            }
        }
    }




}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
