import Foundation
import Alamofire
import RxSwift

public extension PrimitiveSequenceType where Element: DataRequest, Trait == SingleTrait {
    func validate(_ validation: @escaping DataRequest.Validation) -> Single<DataRequest> {
        map { $0.validate(validation) }
    }
    
    func validate<S: Sequence>(statusCode acceptableStatusCodes: S) -> Single<DataRequest> where S.Iterator.Element == Int {
        map { $0.validate(statusCode: acceptableStatusCodes) }
    }
    
    func validate<S: Sequence>(contentType acceptableContentTypes: @escaping @autoclosure () -> S) -> Single<DataRequest> where S.Iterator.Element == String {
        map { $0.validate(contentType: acceptableContentTypes()) }
    }
    
    //default validation
    func validate() -> Single<DataRequest> {
        map { $0.validate() }
    }
}

public extension PrimitiveSequenceType where Element: DataStreamRequest, Trait == SingleTrait {
    func validate(_ validation: @escaping DataStreamRequest.Validation) -> Single<DataStreamRequest> {
        map { $0.validate(validation) }
    }
    
    func validate<S: Sequence>(statusCode acceptableStatusCodes: S) -> Single<DataStreamRequest> where S.Iterator.Element == Int {
        map { $0.validate(statusCode: acceptableStatusCodes) }
    }
    
    func validate<S: Sequence>(contentType acceptableContentTypes: @escaping @autoclosure () -> S) -> Single<DataStreamRequest> where S.Iterator.Element == String {
        map { $0.validate(contentType: acceptableContentTypes())}
    }
    
    //Default validation
    func validate() -> Single<DataStreamRequest> {
        map { $0.validate() }
    }
}

public extension PrimitiveSequenceType where Element: DownloadRequest, Trait == SingleTrait {
    func validate(_ validation: @escaping DownloadRequest.Validation) -> Single<DownloadRequest> {
        map { $0.validate(validation) }
    }
    
    func validate<S: Sequence>(statusCode acceptableStatusCodes: S) -> Single<DownloadRequest> where S.Iterator.Element == Int {
        map { $0.validate(statusCode: acceptableStatusCodes) }
    }
    
    func validate<S: Sequence>(contentType acceptableContentTypes: @escaping @autoclosure () -> S) -> Single<DownloadRequest> where S.Iterator.Element == String {
        map { $0.validate(contentType: acceptableContentTypes())}
    }
    
    //Default validation
    func validate() -> Single<DownloadRequest> {
        map { $0.validate() }
    }
}
