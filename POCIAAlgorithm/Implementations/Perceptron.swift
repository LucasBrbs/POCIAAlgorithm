//
//  Perceptron.swift
//  POCIAAlgorithm
//
//  Created by Lucas Barbosa de Oliveira on 09/05/23.
//

import Foundation

class PerceptronEu : RedeNeural{

    //entrada de dados com os pesos
    var entradas: [Double]
    var pesos: [Double]

    init(entradas: [Double], pesos: [Double]) {
        self.entradas = entradas
        self.pesos = pesos
    }

    //Comparador para saber se é maior que zero
//    func comparador() -> Int{
//
//    }

    //somatoria dos valores e dos pesos
    func somatoria(_ entrada:[Double], _ pesos:[Double]) -> Double {

        return 0.0
    }
}

protocol RedeNeural : ObservableObject{
    var entradas: [Double] {get set}
    var pesos: [Double] { get set}
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


