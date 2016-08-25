#if os(Linux)
import Glibc
#else
import Darwin
#endif

struct JSONCreator {
    func generateJSON() -> [String: Any] {

        var finalJSON = [String: Any]()

        for i in 1...10 {
            let randomNumber = Int(arc4random_uniform(UInt32(1000)))
            finalJSON["Test Number \(i)"] = randomNumber
        }

        return finalJSON
    }
}
