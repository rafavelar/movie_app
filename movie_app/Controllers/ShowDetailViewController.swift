//
//  ShowDetailViewController.swift
//  movie_app
//
//  Created by Rafael Avelar on 20/11/20.
//

import UIKit

class ShowDetailViewController: UIViewController {
  
  var show: Show?
  
  @IBOutlet weak var imageShowDetail: UIImageView!
  @IBOutlet weak var summaryShowDetail: UITextView!
  
  @IBOutlet weak var nameShowDetail: UILabel!
  @IBOutlet weak var languageShowDetail: UILabel!
  @IBOutlet weak var statusShowDetail: UILabel!
  @IBOutlet weak var imdbShowDetail: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
    if let showDetail = show{
      setShowInfo(show: showDetail);
    }
  }
  
  func setShowInfo(show: Show){
    
    //Set the image
    if let imageUrl = URL(string: show.image.original.replacingOccurrences(of: "http", with: "https")){
      imageShowDetail.setImage(from: imageUrl, withPlaceholder: UIImage(systemName: "wifi.exclamationmark"))
    }
    
    //Set summary
    summaryShowDetail.text = show.summary
    summaryShowDetail.layer.borderWidth = 1
    summaryShowDetail.layer.borderColor = UIColor.gray.cgColor
    languageShowDetail.text = show.network?.name
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
