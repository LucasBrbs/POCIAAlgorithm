
import Foundation

struct Iris: Decodable {
    var id: Int
    var sepalLenght: Double
    var sepalWidth: Double
    var petalLenght: Double
    var petalWidth: Double
    let species: Specie
    var vector: SIMD4<Double>? {
        return SIMD4(sepalLenght, sepalWidth, petalLenght, petalWidth)
    }

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case sepalLenght = "SepalLengthCm"
        case sepalWidth = "SepalWidthCm"
        case petalLenght = "PetalLengthCm"
        case petalWidth = "PetalWidthCm"
        case species = "Species"
    }

    static func loadData() -> [Iris] {
        guard let url = Bundle.main.url(forResource: "Iris", withExtension: "json") else { return [] }
        do {
            let binaryData = try Data(contentsOf: url)
            var irisData = try JSONDecoder().decode([Iris].self, from: binaryData)
            irisData.shuffle()
            return irisData
        }
        catch {
            print(error)
        }
        return []
    }


    static func fromSimd(id: Int, simd: SIMD4<Double>, species: String) -> Iris {
        return Iris(
            id: id,
            sepalLenght: simd.x,
            sepalWidth: simd.y,
            petalLenght: simd.z,
            petalWidth: simd.w,
            species: Specie(rawValue: species)!
        )
    }
}
