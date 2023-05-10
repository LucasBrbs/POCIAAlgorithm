
import Foundation

protocol Classifier {
    var splitedDataset: ([Iris], [Iris]) { get }
    func train()
    func predict(_ testInstace: SIMD4<Double>) -> String
}
