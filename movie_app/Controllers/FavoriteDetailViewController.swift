//
//  FavoriteDetailViewController.swift
//  movie_app
//
//  Created by Rafael Avelar on 20/11/20.
//

import UIKit

class FavoriteDetailViewController: UIViewController {
  
  var show: ShowEntity?
  
  @IBOutlet weak var imageShowDetail: UIImageView!
  @IBOutlet weak var summaryShowDetail: UITextView!
  
  @IBOutlet weak var nameShowDetail: UILabel!
  @IBOutlet weak var languageShowDetail: UILabel!
  @IBOutlet weak var statusShowDetail: UILabel!
  @IBOutlet weak var imdbShowDetail: UILabel!
  @IBOutlet weak var IMDbButton: UIButton!
  
  var navButton: UIBarButtonItem? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if let showDetail = show {
      
      self.tabBarController?.navigationItem.title = showDetail.name
      
      setShowInfo(show: showDetail);
      
      if let imdb = showDetail.imdb {
        if(imdb.isEmpty){
          IMDbButton.isHidden = true
        }
      }
    }
    
    
    navButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteFavorite))
    navigationItem.rightBarButtonItem = navButton
    
  }
  @IBAction func openIMDb(_ sender: Any) {
    if let imdb = show?.imdb{
      if let url = URL(string: "https://www.imdb.com/title/\(imdb)/") {
        UIApplication.shared.open(url)
      }
    }
  }
  
  @objc func deleteFavorite(_ sender: Any) {
    
  }
  
  func setShowInfo(show: ShowEntity){
    
    //Set the image
    if let imageUrl = show.medium_image {
      imageShowDetail.setImage(from: imageUrl, withPlaceholder: UIImage(systemName: "wifi.exclamationmark"))
    }
    
    //Set summary
    summaryShowDetail.text = show.summary
    summaryShowDetail.layer.borderWidth = 1
    summaryShowDetail.layer.borderColor = UIColor.gray.cgColor
    
    nameShowDetail.text = show.name
    languageShowDetail.text = show.language
    statusShowDetail.text = show.status
    imdbShowDetail.text = show.imdb
  }
}
