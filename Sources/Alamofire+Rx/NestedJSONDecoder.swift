import Foundation
import Alamofire

//This is a convenience decoder, actually it's not very good in performance point of view, but it's very handy
public class NestedJSONDecoder: DataDecoder {
    public enum DecodingError: Error {
        case nilData(keyPath: String)
        case invalidJSON(keyPath: String, object: Any)
    }
    
    public let keyPath: String
    public let readingOptions: JSONSerialization.ReadingOptions
    public let decoder: DataDecoder
    
    public init(keyPath: String,
                decoder: DataDecoder,
                readingOptions: JSONSerialization.ReadingOptions) {
        self.keyPath = keyPath
        self.readingOptions = readingOptions
        self.decoder = decoder
    }
    
    public func decode<D: Decodable>(_ type: D.Type, from data: Data) throws -> D {
        let json = try JSONSerialization.jsonObject(with: data, options: readingOptions)
     
        guard let nestedJson = (json as AnyObject).value(forKeyPath: keyPath) else {
            throw DecodingError.nilData(keyPath: keyPath)
        }
        
        guard JSONSerialization.isValidJSONObject(nestedJson) else {
            throw DecodingError.invalidJSON(keyPath: keyPath, object: nestedJson)
        }
        
        let nestedData = try JSONSerialization.data(withJSONObject: nestedJson)
        return try decoder.decode(type, from: nestedData)
    }
}
