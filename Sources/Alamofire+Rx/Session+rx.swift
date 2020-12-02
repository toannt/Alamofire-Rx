import Foundation
import Alamofire
import RxSwift

extension Session: ReactiveCompatible {}

//MARK:- DataRequest
public extension Reactive where Base: Session {
    func request(_ convertible: URLConvertible,
                 method: HTTPMethod = .get,
                 parameters: Parameters? = nil,
                 encoding: ParameterEncoding = URLEncoding.default,
                 headers: HTTPHeaders? = nil,
                 interceptor: RequestInterceptor? = nil,
                 requestModifier: Session.RequestModifier? = nil) -> Single<DataRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.request(convertible,
                                          method: method,
                                          parameters: parameters,
                                          encoding: encoding,
                                          headers: headers,
                                          interceptor: interceptor,
                                          requestModifier: requestModifier)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func request<Parameters: Encodable>(_ convertible: URLConvertible,
                                        method: HTTPMethod = .get,
                                        parameters: Parameters? = nil,
                                        encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
                                        headers: HTTPHeaders? = nil,
                                        interceptor: RequestInterceptor? = nil,
                                        requestModifier: Session.RequestModifier? = nil) -> Single<DataRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.request(convertible,
                                          method: method,
                                          parameters: parameters,
                                          encoder: encoder,
                                          headers: headers,
                                          interceptor: interceptor,
                                          requestModifier: requestModifier)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func request(_ convertible: URLRequestConvertible,
                 interceptor: RequestInterceptor? = nil) -> Single<DataRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.request(convertible,
                                          interceptor: interceptor)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
}


//MARK:- DownloadRequest
public extension Reactive where Base: Session {
    func download(_ convertible: URLConvertible,
                  method: HTTPMethod = .get,
                  parameters: Parameters? = nil,
                  encoding: ParameterEncoding = URLEncoding.default,
                  headers: HTTPHeaders? = nil,
                  interceptor: RequestInterceptor? = nil,
                  requestModifier: Session.RequestModifier? = nil,
                  to destination: DownloadRequest.Destination? = nil) -> Single<DownloadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.download(convertible,
                                           method: method,
                                           parameters: parameters,
                                           encoding: encoding,
                                           headers: headers,
                                           interceptor: interceptor,
                                           requestModifier: requestModifier,
                                           to: destination)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func download<Parameters: Encodable>(_ convertible: URLConvertible,
                                         method: HTTPMethod = .get,
                                         parameters: Parameters? = nil,
                                         encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
                                         headers: HTTPHeaders? = nil,
                                         interceptor: RequestInterceptor? = nil,
                                         requestModifier: Session.RequestModifier? = nil,
                                         to destination: DownloadRequest.Destination? = nil) -> Single<DownloadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.download(convertible,
                                           method: method,
                                           parameters: parameters,
                                           encoder: encoder,
                                           headers: headers,
                                           interceptor: interceptor,
                                           requestModifier: requestModifier,
                                           to: destination)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func download(_ convertible: URLRequestConvertible,
                  interceptor: RequestInterceptor? = nil,
                  to destination: DownloadRequest.Destination? = nil) -> Single<DownloadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.download(convertible,
                                           interceptor: interceptor,
                                           to: destination)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func download(resumingWith data: Data,
                  interceptor: RequestInterceptor? = nil,
                  to destination: DownloadRequest.Destination? = nil) -> Single<DownloadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.download(resumingWith: data,
                                           interceptor: interceptor,
                                           to: destination)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

//MARK:- UploadRequest
public extension Reactive where Base: Session {
    func upload(_ data: Data,
                to convertible: URLConvertible,
                method: HTTPMethod = .post,
                headers: HTTPHeaders? = nil,
                interceptor: RequestInterceptor? = nil,
                fileManager: FileManager = .default,
                requestModifier: Session.RequestModifier? = nil) -> Single<UploadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.upload(data,
                                         to: convertible,
                                         method: method,
                                         headers: headers,
                                         interceptor: interceptor,
                                         fileManager: fileManager,
                                         requestModifier: requestModifier)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func upload(_ data: Data,
                with convertible: URLRequestConvertible,
                interceptor: RequestInterceptor? = nil,
                fileManager: FileManager = .default) -> Single<UploadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.upload(data,
                                         with: convertible,
                                         interceptor: interceptor,
                                         fileManager: fileManager)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func upload(_ fileURL: URL,
                to convertible: URLConvertible,
                method: HTTPMethod = .post,
                headers: HTTPHeaders? = nil,
                interceptor: RequestInterceptor? = nil,
                fileManager: FileManager = .default,
                requestModifier: Session.RequestModifier? = nil) -> Single<UploadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.upload(fileURL,
                                         to: convertible,
                                         method: method,
                                         headers: headers,
                                         interceptor: interceptor,
                                         fileManager: fileManager,
                                         requestModifier: requestModifier)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func upload(_ fileURL: URL,
                with convertible: URLRequestConvertible,
                interceptor: RequestInterceptor? = nil,
                fileManager: FileManager = .default) -> Single<UploadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.upload(fileURL,
                                         with: convertible,
                                         interceptor: interceptor,
                                         fileManager: fileManager)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func upload(_ stream: InputStream,
                to convertible: URLConvertible,
                method: HTTPMethod = .post,
                headers: HTTPHeaders? = nil,
                interceptor: RequestInterceptor? = nil,
                fileManager: FileManager = .default,
                requestModifier: Session.RequestModifier? = nil) -> Single<UploadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.upload(stream,
                                         to: convertible,
                                         method: method,
                                         headers: headers,
                                         interceptor: interceptor,
                                         fileManager: fileManager,
                                         requestModifier: requestModifier)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func upload(_ stream: InputStream,
                with convertible: URLRequestConvertible,
                interceptor: RequestInterceptor? = nil,
                fileManager: FileManager = .default) -> Single<UploadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.upload(stream,
                                         with: convertible,
                                         interceptor: interceptor,
                                         fileManager: fileManager)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func upload(multipartFormData: @escaping (MultipartFormData) -> Void,
                to url: URLConvertible,
                usingThreshold encodingMemoryThreshold: UInt64 = MultipartFormData.encodingMemoryThreshold,
                method: HTTPMethod = .post,
                headers: HTTPHeaders? = nil,
                interceptor: RequestInterceptor? = nil,
                fileManager: FileManager = .default,
                requestModifier: Session.RequestModifier? = nil) -> Single<UploadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.upload(multipartFormData: multipartFormData,
                                         to: url,
                                         usingThreshold: encodingMemoryThreshold,
                                         method: method,
                                         headers: headers,
                                         interceptor: interceptor,
                                         fileManager: fileManager,
                                         requestModifier: requestModifier)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func upload(multipartFormData: @escaping (MultipartFormData) -> Void,
                with request: URLRequestConvertible,
                usingThreshold encodingMemoryThreshold: UInt64 = MultipartFormData.encodingMemoryThreshold,
                interceptor: RequestInterceptor? = nil,
                fileManager: FileManager = .default) -> Single<UploadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.upload(multipartFormData: multipartFormData,
                                         with: request,
                                         usingThreshold: encodingMemoryThreshold,
                                         interceptor: interceptor,
                                         fileManager: fileManager)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func upload(multipartFormData: MultipartFormData,
                to url: URLConvertible,
                usingThreshold encodingMemoryThreshold: UInt64 = MultipartFormData.encodingMemoryThreshold,
                method: HTTPMethod = .post,
                headers: HTTPHeaders? = nil,
                interceptor: RequestInterceptor? = nil,
                fileManager: FileManager = .default,
                requestModifier: Session.RequestModifier? = nil) -> Single<UploadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.upload(multipartFormData: multipartFormData,
                                         to: url,
                                         usingThreshold: encodingMemoryThreshold,
                                         method: method,
                                         headers: headers,
                                         interceptor: interceptor,
                                         fileManager: fileManager,
                                         requestModifier: requestModifier)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
    
    func upload(multipartFormData: MultipartFormData,
                with request: URLRequestConvertible,
                usingThreshold encodingMemoryThreshold: UInt64 = MultipartFormData.encodingMemoryThreshold,
                interceptor: RequestInterceptor? = nil,
                fileManager: FileManager = .default) -> Single<UploadRequest> {
        Single.create { [session = base] callback -> Disposable in
            let request = session.upload(multipartFormData: multipartFormData,
                                         with: request,
                                         usingThreshold: encodingMemoryThreshold,
                                         interceptor: interceptor,
                                         fileManager: fileManager)
            callback(.success(request))
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
