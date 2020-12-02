import Foundation
import Alamofire
import RxSwift

public extension PrimitiveSequenceType where Trait == SingleTrait, Element: DataRequest {
    func debugString(encoding: String.Encoding? = nil, debugClosure: @escaping (AFDataResponse<String>) -> Void) -> Single<DataRequest> {
        return map { $0.responseString(encoding: encoding, completionHandler: debugClosure) }
    }
    
    func debugJSON(options: JSONSerialization.ReadingOptions = .allowFragments, debugClosure: @escaping (AFDataResponse<Any>) -> Void) -> Single<DataRequest> {
        return map { $0.responseJSON(options: options, completionHandler: debugClosure) }
    }
    
    func debugData(_ debugClosure: @escaping (AFDataResponse<Data>) -> Void) -> Single<DataRequest> {
        return map { $0.responseData(completionHandler: debugClosure) }
    }
    
    func debugDecodable<T: Decodable>(of type: T.Type = T.self, decoder: Alamofire.DataDecoder = JSONDecoder(), debugClosure: @escaping (AFDataResponse<T>) -> Void) -> Single<DataRequest> {
        return map { $0.responseDecodable(of: type, decoder: decoder, completionHandler: debugClosure) }
    }
}
