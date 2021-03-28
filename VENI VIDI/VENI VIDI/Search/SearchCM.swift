//
//  SearchCM.swift
//  VENI VIDI
//
//  Created by MonAster on 2021/3/22.
//

import Foundation
import DCFrame
import SnapKit

class SearchCM: DCContainerModel {
    private let searchResultCM = DCContainerModel()
    var currentTimeTag: TimeInterval = 0
    
    override func cmDidLoad() {
        super.cmDidLoad()
        addSubCell(SearchCell.self) { (model) in
            model.cellHeight = 56
        }
        addSubmodel(searchResultCM)
        handleEvents()
    }
    
    private func handleEvents() {
        subscribeEvent(SearchCell.textChanged) { [weak self] (text: String) in
            guard let `self` = self else {
                return
            }
            if text != "" {
                self.getBooks(with: text)
            } else {
                self.searchResultCM.removeAllSubmodels()
            }
        }
    }
    
    private func getBooks(with text: String) {
        let request = BookRequest(with: text)
        let timeStamp = NSDate().timeIntervalSince1970
        request.getBooks { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
                self?.searchResultCM.removeAllSubmodels()
            case .success(let volumes):
                var i = 0
                guard let tag = self?.currentTimeTag, timeStamp >= tag else {
                    return
                }
                self?.currentTimeTag = timeStamp
                self?.searchResultCM.removeAllSubmodels()
                for volume in volumes {
                    if i == 5 {
                        break
                    }
                    let info = volume.volumeInfo
                    let resultModel = SearchResultCellModel()
                    resultModel.title = info.title
                    i += 1
                    guard let image = info.imageLinks.thumbnail else {
                        continue
                    }
                    
                    let imageURL = URL(string: image)
                    guard let url = imageURL else {
                        return
                    }
                    
                    self?.downloadImage(from: url) { [weak self] result in
                        switch result {
                        case .success(let image):
                            resultModel.cover = image
                            break
                        case .failure(let error):
                            break
                        }
                    }
                    
//                    let imageData = try? Data(contentsOf: imageURL!)
//                    resultModel.cover = UIImage(data: imageData!)
                    self?.searchResultCM.addSubmodel(resultModel)
                }
            }
            self?.needAnimateUpdate()
        }
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
            URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
        
    func downloadImage(from url: URL, completion: @escaping(Result<UIImage, Error>) -> Void) {
            print("Download Started")
            getData(from: url) { data, response, error in
                guard let data = data, error == nil else { return }
                print(response?.suggestedFilename ?? url.lastPathComponent)
                print("Download Finished")
                DispatchQueue.main.async() { [weak self] in
                    guard let image = UIImage(data: data) else { return }
                    completion(.success(image))
                }
            }
    }
    
}
