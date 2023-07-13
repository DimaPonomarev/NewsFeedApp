//
//  ExtensionUIImage.swift
//  NewsFeedApp
//
//  Created by Дмитрий Пономарев on 13.07.2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

extension UIImage {
    
    public static func loadFrom(url: URL, completion: @escaping (_ image: UIImage?) -> ()) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    completion(UIImage(data: data))
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
    

}

