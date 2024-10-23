//
//  APIError.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 23/10/24.
//

import Foundation

enum APIError: Error {
  case badRequest
  case authenticationFailure
  case forbidden
  case notFound
  case serverError
  case decodeError
  case urlSessionFailed
  case unknown(Int)
  
  init(code: Int) {
    switch code {
    case APIErrorCode.clientBadRequest:
      self = .badRequest
    case APIErrorCode.clientUnauthorized:
      self = .authenticationFailure
    case APIErrorCode.clientForbidden:
      self = .forbidden
    case APIErrorCode.clientNotFound:
      self = .notFound
    case APIErrorCode.serverBadGateway,
      APIErrorCode.serverTimeout, 
      APIErrorCode.serverUnavailable:
      self = .serverError
    default:
      self = .unknown(code)
    }
  }
  
  public var description: String {
    switch self {
    case .authenticationFailure:
      return "Don't allow access"
    case .badRequest:
      return "The request includes bad params"
    case .forbidden:
      return "No permission in this scope"
    case .serverError:
      return "Server is unavailable"
    default:
      return "Something's wrong"
    }
  }
}

enum APIErrorCode {
  static let clientBadRequest = 400
  static let clientUnauthorized = 401
  static let clientForbidden = 403
  static let clientNotFound = 404
  static let serverBadGateway = 500
  static let serverUnavailable = 503
  static let serverTimeout = 504
  static let noHTTPResponse = -1000
  static let unknownError = -1001
}
