//
//  APIClientImp.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 23/10/24.
//

import Foundation

final class APIClientImp: IAPIClient {
  
  private let enviroment: APIEnvironment
  private let urlSession: URLSession
  private let queue = DispatchQueue(label: "githubadmin-networking-client", qos: .background)
  
  init(enviroment: APIEnvironment, urlSession: URLSession) {
    self.enviroment = enviroment
    self.urlSession = urlSession
  }
  
  func excute<R: GPARequest>(request: R, completion: @escaping APICompletionSingleResult, failure: @escaping APIFailureHandler) {
    guard let urlRequest = request.asUrlRequest(baseURL: enviroment.baseURL, headerDefault: enviroment.headerDefault) else {
      return failure(APIError.badRequest)
    }
    self.request(urlRequest, failure: failure) { (data: Data?) in
      let decoder = JSONDecoder()
      do {
        let response = try decoder.decode(R.Response.self, from: data!)
        completion(response)
      } catch {
        failure(APIError.decodeError)
      }
    }
  }
  
  func excuteCollection<R: GPARequest>(request: R, completion: @escaping APICompletionCollectionResult, failure: @escaping APIFailureHandler) {
    guard let urlRequest = request.asUrlRequest(baseURL: enviroment.baseURL, headerDefault: enviroment.headerDefault) else {
      return failure(APIError.badRequest)
    }
    self.request(urlRequest, failure: failure) { (data: Data?) in
      let decoder = JSONDecoder()
      do {
        let response = try decoder.decode([R.Response].self, from: data!)
        completion(response)
      } catch {
        failure(APIError.decodeError)
      }
    }
  }
  
  private func request(_ urlRequest: URLRequest,
                       failure: @escaping (APIError) -> Void,
                       completion: @escaping (Data?) -> Void) {
    let sessionTask = urlSession.dataTask(with: urlRequest) {[unowned self] data, response, error in
      guard let response = response as? HTTPURLResponse else {
        failure(APIError.unknown(APIErrorCode.noHTTPResponse))
        return
      }
      if (200..<300).contains(response.statusCode) {
        completion(data)
      } else if let error = error {
        let apiError = self.handleError(error)
        failure(apiError)
      } else {
        failure(APIError(code: response.statusCode))
      }
    }
    sessionTask.resume()
  }
  
  private func handleError(_ error: Error) -> APIError {
    switch error {
    case is Swift.DecodingError:
      return APIError.badRequest
    case is URLError:
      return APIError.urlSessionFailed
    case let nsError as NSError:
      return APIError(code: nsError.code)
    default:
      return APIError.unknown(APIErrorCode.unknownError)
    }
  }
}
