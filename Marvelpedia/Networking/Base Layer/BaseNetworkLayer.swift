//
//  BaseNetworkLayer.swift
//  Marvelpedia
//
//  Created by Rana Moussa on 24/04/2022.
//

import Foundation
import RxSwift
import RxAlamofire

// implemented as an enum to handle different build settings (prod / preprod)
enum BaseUrl: String {
    case production = "https://gateway.marvel.com"
}

final class BaseNetworkLayer {
    static var shared = BaseNetworkLayer()
        
    private var baseUrl: BaseUrl
    private let plistParser = PlistParser(file: .marvelApi)
        
    private init() {
        // build settings can be configured here
        baseUrl = .production
    }
    
    func makeRequest<T: Codable>(request: APIRequest) -> Observable<T> {
        let method = request.method
        let urlString = "\(baseUrl.rawValue)\(request.path)"
        let parameters = request.parameters + getCommonParameters()
        
        let resultObservable = RxAlamofire.data(method, urlString, parameters: parameters)
        return resultObservable.map { result in
            try CustomJSONDecoder().decode(T.self, from: result)
        }
    }
    
    // MARK: private
    
    private func getCommonParameters() -> [String: Any] {
        let timestamp = Int(NSDate().timeIntervalSince1970)
        let publicKey: String = plistParser?.getValue(for: PlistKey.marvelPublicKey.rawValue) ?? ""
        let privateKey: String = plistParser?.getValue(for: PlistKey.marvelPrivateKey.rawValue) ?? ""
        let hash = "\(timestamp)\(privateKey)\(publicKey)".md5
        let params: [String: Any] = [
            "apikey": publicKey,
            "ts": timestamp,
            "hash": hash
        ]
        return params
    }
}
