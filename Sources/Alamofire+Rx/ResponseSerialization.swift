import Foundation
import Alamofire
import RxSwift

public protocol ResponseResultConvertible {
    associatedtype Success
    associatedtype Failure: Error
    var result: Result<Success, Failure> { get }
}

extension AFDataResponse: ResponseResultConvertible { }
extension AFDownloadResponse: ResponseResultConvertible { }

public extension PrimitiveSequenceType where Element: ResponseResultConvertible, Trait == SingleTrait {
    func value() -> Single<Element.Success> {
        flatMap { element in
            switch element.result {
            case .success(let value):
                return .just(value)
            case .failure(let error):
                return .error(error)
            }
        }
    }
}

public extension PrimitiveSequenceType where Element: DataRequest, Trait == SingleTrait {
    func response(queue: DispatchQueue = .main) -> Single<AFDataResponse<Data?>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.response(queue: queue) { response in
                    callback(.success(response))
                }
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
    
    func response<Serializer: DataResponseSerializerProtocol>(queue: DispatchQueue = .main,
                                                              responseSerializer: Serializer) -> Single<AFDataResponse<Serializer.SerializedObject>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.response(queue: queue,
                                                    responseSerializer: responseSerializer) { response in
                    callback(.success(response))
                }
                
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
    
    func responseData(queue: DispatchQueue = .main,
                      dataPreprocessor: DataPreprocessor = DataResponseSerializer.defaultDataPreprocessor,
                      emptyResponseCodes: Set<Int> = DataResponseSerializer.defaultEmptyResponseCodes,
                      emptyRequestMethods: Set<HTTPMethod> = DataResponseSerializer.defaultEmptyRequestMethods) -> Single<AFDataResponse<Data>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.responseData(queue: queue,
                                                        dataPreprocessor: dataPreprocessor,
                                                        emptyResponseCodes: emptyResponseCodes,
                                                        emptyRequestMethods: emptyRequestMethods) { response in
                    callback(.success(response))
                }
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
    
    func responseString(queue: DispatchQueue = .main,
                        dataPreprocessor: DataPreprocessor = StringResponseSerializer.defaultDataPreprocessor,
                        encoding: String.Encoding? = nil,
                        emptyResponseCodes: Set<Int> = StringResponseSerializer.defaultEmptyResponseCodes,
                        emptyRequestMethods: Set<HTTPMethod> = StringResponseSerializer.defaultEmptyRequestMethods) -> Single<AFDataResponse<String>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.responseString(queue: queue,
                                                          dataPreprocessor: dataPreprocessor,
                                                          encoding: encoding,
                                                          emptyResponseCodes: emptyResponseCodes,
                                                          emptyRequestMethods: emptyRequestMethods) { response in
                    callback(.success(response))
                }
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
    
    func responseJSON(queue: DispatchQueue = .main,
                      dataPreprocessor: DataPreprocessor = JSONResponseSerializer.defaultDataPreprocessor,
                      emptyResponseCodes: Set<Int> = JSONResponseSerializer.defaultEmptyResponseCodes,
                      emptyRequestMethods: Set<HTTPMethod> = JSONResponseSerializer.defaultEmptyRequestMethods,
                      options: JSONSerialization.ReadingOptions = .allowFragments) -> Single<AFDataResponse<Any>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.responseJSON(queue: queue,
                                                        dataPreprocessor: dataPreprocessor,
                                                        emptyResponseCodes: emptyResponseCodes,
                                                        emptyRequestMethods: emptyRequestMethods,
                                                        options: options) { response in
                    callback(.success(response))
                }
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
    
    func responseDecodable<T: Decodable>(of type: T.Type = T.self,
                                         queue: DispatchQueue = .main,
                                         dataPreprocessor: DataPreprocessor = DecodableResponseSerializer<T>.defaultDataPreprocessor,
                                         decoder: Alamofire.DataDecoder = JSONDecoder(),
                                         emptyResponseCodes: Set<Int> = DecodableResponseSerializer<T>.defaultEmptyResponseCodes,
                                         emptyRequestMethods: Set<HTTPMethod> = DecodableResponseSerializer<T>.defaultEmptyRequestMethods) -> Single<AFDataResponse<T>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.responseDecodable(of: type,
                                                             queue: queue,
                                                             dataPreprocessor: dataPreprocessor,
                                                             decoder: decoder,
                                                             emptyResponseCodes: emptyResponseCodes,
                                                             emptyRequestMethods: emptyRequestMethods) { response in
                    callback(.success(response))
                }
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
    
    func responseDecodable<T: Decodable>(of type: T.Type = T.self,
                                         keyPath: String,
                                         queue: DispatchQueue = .main,
                                         dataPreprocessor: DataPreprocessor = DecodableResponseSerializer<T>.defaultDataPreprocessor,
                                         decoder: Alamofire.DataDecoder = JSONDecoder(),
                                         emptyResponseCodes: Set<Int> = DecodableResponseSerializer<T>.defaultEmptyResponseCodes,
                                         emptyRequestMethods: Set<HTTPMethod> = DecodableResponseSerializer<T>.defaultEmptyRequestMethods,
                                         jsonReadingOptions: JSONSerialization.ReadingOptions = .allowFragments) -> Single<AFDataResponse<T>> {
        return responseDecodable(of: type,
                                 queue: queue,
                                 dataPreprocessor: dataPreprocessor,
                                 decoder: NestedJSONDecoder(keyPath: keyPath, decoder: decoder, readingOptions: jsonReadingOptions),
                                 emptyResponseCodes: emptyResponseCodes,
                                 emptyRequestMethods: emptyRequestMethods)
    }
}

public extension PrimitiveSequenceType where Element: DownloadRequest, Trait == SingleTrait {
    func response(queue: DispatchQueue = .main) -> Single<AFDownloadResponse<URL?>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.response(queue: queue) { response in
                    callback(.success(response))
                }
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
    
    func response<Serializer: DownloadResponseSerializerProtocol>(queue: DispatchQueue = .main,
                                                                  responseSerializer: Serializer) -> Single<AFDownloadResponse<Serializer.SerializedObject>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.response(queue: queue,
                                                    responseSerializer: responseSerializer) { response in
                    callback(.success(response))
                }
                
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
    
    func responseURL(queue: DispatchQueue = .main) -> Single<AFDownloadResponse<URL>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.responseURL(queue: queue) { response in
                    callback(.success(response))
                }
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
    
    func responseData(queue: DispatchQueue = .main,
                      dataPreprocessor: DataPreprocessor = DataResponseSerializer.defaultDataPreprocessor,
                      emptyResponseCodes: Set<Int> = DataResponseSerializer.defaultEmptyResponseCodes,
                      emptyRequestMethods: Set<HTTPMethod> = DataResponseSerializer.defaultEmptyRequestMethods) -> Single<AFDownloadResponse<Data>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.responseData(queue: queue,
                                                        dataPreprocessor: dataPreprocessor,
                                                        emptyResponseCodes: emptyResponseCodes,
                                                        emptyRequestMethods: emptyRequestMethods) { response in
                    callback(.success(response))
                }
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
    
    func responseString(queue: DispatchQueue = .main,
                        dataPreprocessor: DataPreprocessor = StringResponseSerializer.defaultDataPreprocessor,
                        encoding: String.Encoding? = nil,
                        emptyResponseCodes: Set<Int> = StringResponseSerializer.defaultEmptyResponseCodes,
                        emptyRequestMethods: Set<HTTPMethod> = StringResponseSerializer.defaultEmptyRequestMethods) -> Single<AFDownloadResponse<String>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.responseString(queue: queue,
                                                          dataPreprocessor: dataPreprocessor,
                                                          encoding: encoding,
                                                          emptyResponseCodes: emptyResponseCodes,
                                                          emptyRequestMethods: emptyRequestMethods) { response in
                    callback(.success(response))
                }
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
    
    func responseJSON(queue: DispatchQueue = .main,
                      dataPreprocessor: DataPreprocessor = JSONResponseSerializer.defaultDataPreprocessor,
                      emptyResponseCodes: Set<Int> = JSONResponseSerializer.defaultEmptyResponseCodes,
                      emptyRequestMethods: Set<HTTPMethod> = JSONResponseSerializer.defaultEmptyRequestMethods,
                      options: JSONSerialization.ReadingOptions = .allowFragments) -> Single<AFDownloadResponse<Any>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.responseJSON(queue: queue,
                                                        dataPreprocessor: dataPreprocessor,
                                                        emptyResponseCodes: emptyResponseCodes,
                                                        emptyRequestMethods: emptyRequestMethods,
                                                        options: options) { response in
                    callback(.success(response))
                }
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
    
    func responseDecodable<T: Decodable>(of type: T.Type = T.self,
                                         queue: DispatchQueue = .main,
                                         dataPreprocessor: DataPreprocessor = DecodableResponseSerializer<T>.defaultDataPreprocessor,
                                         decoder: Alamofire.DataDecoder = JSONDecoder(),
                                         emptyResponseCodes: Set<Int> = DecodableResponseSerializer<T>.defaultEmptyResponseCodes,
                                         emptyRequestMethods: Set<HTTPMethod> = DecodableResponseSerializer<T>.defaultEmptyRequestMethods) -> Single<AFDownloadResponse<T>> {
        flatMap { request in
            Single.create { callback -> Disposable in
                let finalRequest = request.responseDecodable(of: type,
                                                             queue: queue,
                                                             dataPreprocessor: dataPreprocessor,
                                                             decoder: decoder,
                                                             emptyResponseCodes: emptyResponseCodes,
                                                             emptyRequestMethods: emptyRequestMethods) { response in
                    callback(.success(response))
                }
                finalRequest.resume()
                return Disposables.create {
                    finalRequest.cancel()
                }
            }
        }
    }
}
