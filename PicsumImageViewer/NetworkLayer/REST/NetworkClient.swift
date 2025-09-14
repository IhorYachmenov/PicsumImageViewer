//
//  NetworkClient.swift
//  NetworkLayer
//
//  Created by user on 21.03.2023.
//

import Foundation

struct CertificateHandler {
    
    static func listFilesInBundle(withIdentifier bundleIdentifier: String) {
//        guard let bundle = Bundle.allBundles.first(where: { $0.bundleIdentifier == bundleIdentifier }) else {
//            print("Bundle with identifier \(bundleIdentifier) not found.")
//            return
//        }
//        
//        guard let bundleURL = bundle.bundleURL as NSURL? else {
//            print("Could not access bundle URL.")
//            return
//        }
        
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: Bundle.main.bundleURL , includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                print(fileURL.lastPathComponent)
            }
        } catch {
            print("Error reading contents of bundle: \(error)")
        }
    }

    static let certificates: [Data] = {
        CertificateHandler.listFilesInBundle(withIdentifier: "com.board.business-community.dev.fake")
//        let url = Bundle.main.url(forResource: "picsum.photos", withExtension: "cer")!
        let url = Bundle.main.url(forResource: "run.mocky.io", withExtension: "cer")!
        print("URL", url)
        let data = try! Data(contentsOf: url)
        print("URL Data", data)
        return [data]
        
    }()
}

public final class NetworkClient: NSObject {
    
    
    public override init() {
        
    }
   
    
    public func downloadImages(page: Int, completion: @escaping (Result<[NetworkModel.Image], Error>) ->()) {
//        if let url = URL(string: "https://picsum.photos/v2/list?page=\(page)&limit=20") {
        if let url = URL(string: "https://run.mocky.io/v3/5886c75d-00be-4aef-b628-b65205405714") {
            let session = URLSession.shared
            let sslSession = NetworkManager().urlSession
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
//            let task = sslSession.dataTask(with: request) { (data, response, error) in
            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(NSError.error(msg: "No Data")))
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let model = try decoder.decode([NetworkModel.Image].self, from: data)
                    
                    completion(.success(model))
//                    completion(.success([]))
                } catch {
                    completion(.failure(error))
                }
            }
            
            task.resume()
        } else {
            completion(.failure(NSError.error(msg: "Invalid URL")))
        }
    }
}

final class NetworkManager {
    let urlSession: URLSession
    
    init() {
        urlSession = URLSession(configuration: .default,
                                delegate: UrlSessionDelegateHandler(),
                                delegateQueue: nil)
    }
}

final class UrlSessionDelegateHandler: NSObject, URLSessionDelegate {
    func urlSession(_ session: URLSession,
                    didReceive challenge: URLAuthenticationChallenge,
                    completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        let bundle = Bundle(identifier: "com.board.business-community.dev.fake")
//        guard let path = bundle?.path(forResource: "WE1", ofType: "der") else {
//                    print("File not found")
//                    return
//                }
        let currentClassBundle = Bundle(for: type(of: self))
        print("Current Class Bundle Identifier: \(currentClassBundle.bundleIdentifier ?? "No Identifier")")
        
        // Check for certificates count in serverTrust if it's >0 then only proceed
        guard let trust = challenge.protectionSpace.serverTrust, SecTrustGetCertificateCount(trust) > 0 else {
            completionHandler(.performDefaultHandling, nil)
            print("!1")
            return
        }
        
        // Get the certificates from SecTrustCopyCertificateChain and extract first certificate
        guard let certificates = SecTrustCopyCertificateChain(trust) as? [SecCertificate],
              let certificate = certificates.first else {
            completionHandler(.performDefaultHandling, nil)
            print("!2")
            return
        }
        
        // Convert certificate to Data
        let data = SecCertificateCopyData(certificate) as Data
        
        // Check if our certificate list contains data
        if CertificateHandler.certificates.contains(data) {
            completionHandler(.useCredential, URLCredential(trust: trust))
            print("!3")
            return
        } else {
            // Cancel the Authentication Challenge
            completionHandler(.cancelAuthenticationChallenge, nil)
            print("!4")
            return
        }
    }
}
