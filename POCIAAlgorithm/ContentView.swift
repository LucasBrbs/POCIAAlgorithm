//
//  ContentView.swift
//  POCIAAlgorithm
//
//  Created by Lucas Barbosa de Oliveira on 02/05/23.
//

import SwiftUI
import Numerics
import RealModule
import ComplexModule
import Accelerate


struct ContentView: View {

    @StateObject private var viewModel = ViewModel()



    var body: some View {
        VStack {
//            Text("Prediction: \(viewModel.prediction)")
            Button {
                viewModel.printKNN()

            } label: {
                Text("KNN")
                Image(systemName: "plus")
            }
            Text("\(viewModel.resultKNN)")
            Button {
                viewModel.printDMC()
            } label: {
                Text("DMC")
                Image(systemName: "plus")
            }
            Text("\(viewModel.resultDMC)")

        }
        .padding()

    }
}

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
//        @Published var prediction: Int = -1
//        let inputs = [[0.0, 0.0], [0.0, 1.0], [1.0, 0.0], [1.0, 1.0]]
//        let labels = [0, 0, 0, 1]
//        let perceptron = Perceptron(learningRate: 0.1, inputSize: 2)
//
//        func trainAndPredict() {
//            perceptron.train(inputs: inputs, labels: labels, epochs: 10)
//            prediction = perceptron.predict([1.0, 1.0])
//        }

        @Published var resultDMC:String = "No result"
        @Published var resultKNN:String = "No result"

        @Published var dataset = DataUtility.splitDataset(Iris.loadData(), trainingFactor: 0.7)

//        print("Training dataset lenght: \(dataset.0.count)")
//        print("Test dataset lenght: \(dataset.1.count)")

        func printDMC(){
            var dmc = DMC(splitedDataset: dataset)

            print("Training dataset lenght: \(dataset.0.count)")
            print("Test dataset lenght: \(dataset.1.count)")

            print("Percent: \(Validator.validateClassifier(classifier: dmc, testDataset: dataset.1)) %\n")
            resultDMC = "Percent: \(Validator.validateClassifier(classifier: dmc, testDataset: dataset.1)) %\n"

        }

        func printKNN(){
            var knn = KNN(k: 3, splitedDataset: dataset)
            print("Training dataset lenght: \(dataset.0.count)")
            print("Test dataset lenght: \(dataset.1.count)")
            print("Percent: \(Validator.validateClassifier(classifier: knn, testDataset: dataset.1)) %\n")
            resultKNN = "Percent: \(Validator.validateClassifier(classifier: knn, testDataset: dataset.1)) %\n"
        }

    }
}

