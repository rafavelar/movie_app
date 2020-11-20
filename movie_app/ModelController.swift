//
//  ModelController.swift
//  movie_app
//
//  Created by Rafael Avelar on 19/11/20.
//

import UIKit
import CoreData

extension UIViewController {
  
  func save(show: Show) {
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      let context = appDelegate.persistentContainer.viewContext
      
      guard let entityDescription = NSEntityDescription.entity(forEntityName: "ShowEntity", in: context) else { return }
      
      let newShow = NSManagedObject(entity: entityDescription, insertInto: context)
      
      //Fill the show
      newShow.setValue(show.id, forKey: "id")
      newShow.setValue(show.externals.imdb, forKey: "imdb")
      newShow.setValue(show.language, forKey: "language")
      newShow.setValue(show.image.medium, forKey: "medium_image")
      newShow.setValue(show.name, forKey: "name")
      newShow.setValue(show.image.original, forKey: "original_image")
      newShow.setValue(show.status, forKey: "status")
      newShow.setValue(show.summary, forKey: "summary")
      newShow.setValue(show.url, forKey: "url")
      
      do {
        try context.save()
        print("It is saved !!* \\o/")
      } catch let error{
        print("Saving Failed \(error)")
      }
      
    }
  }
}
