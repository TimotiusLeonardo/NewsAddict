//
//  UIImage + Extensions.swift
//  NewsAddict
//
//  Created by Timotius Leonardo Lianoto on 22/08/22.
//

import Foundation
import UIKit

extension UIImageView {
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async() { [weak self] in
                self?.image = UIImage(data: data)?.resizeImageWithHeight(newW: 60, newH: 40)
            }
        }
    }
}
