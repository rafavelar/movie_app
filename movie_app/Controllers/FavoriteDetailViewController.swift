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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if let showDetail = show {
      setShowInfo(show: showDetail);
      
      if((showDetail.imdb?.isEmpty) != nil){
        //IMDbButton.isHidden = true
      }
    }
    
  }
  @IBAction func openIMDb(_ sender: Any) {
    
    if let url = URL(string: "https://www.imdb.com/title/\(String(describing: show?.imdb))/") {
        UIApplication.shared.open(url)
    }
    
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
