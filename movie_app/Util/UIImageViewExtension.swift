//
//  UIImageViewExtension.swift
//  movie_app
//
//  Created by Rafael Avelar on 19/11/20.
//

import UIKit

extension UIImageView {
    func setImage(from url: URL, withPlaceholder placeholder: UIImage? = nil) {
        self.image = placeholder
      URLSession.shared.dataTask(with: url) {data,_,_ in
            if let data = data {
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }.resume()
    }
}
