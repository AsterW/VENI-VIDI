//
//  BookInfoModel.swift
//  VENI VIDI
//
//  Created by MonAster on 2021/3/15.
//

import Foundation

enum BookError: Error {
    case noDataAvailable
    case failProcessData
}

struct BookRequest {
    let resourceURL: URL
    
    init(with word: String) {
        let urlString = "https://www.googleapis.com/books/v1/volumes?q=\(word)"
        guard let requestURL = URL(string: urlString) else {
            fatalError()
        }
        
        self.resourceURL = requestURL
        
    }
    
    func getBooks(completion: @escaping(Result<[Volume], BookError>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: self.resourceURL) { data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(VolumeResponse.self, from: jsonData)
                let volumes = response.items
                completion(.success(volumes))
            } catch {
                completion(.failure(.failProcessData))
            }
        }
        dataTask.resume()
    }
}

struct ImageInfo: Decodable {
    let smallThumbnail: String?
    let thumbnail: String?
}

struct VolumeInfo: Decodable {
    let title: String
    let imageLinks: ImageInfo
    
}

struct Volume: Decodable {
    let id: String
    let volumeInfo: VolumeInfo
}

struct VolumeResponse: Decodable {
    let kind: String
    let totalItems: Int
    let items: [Volume]
}
