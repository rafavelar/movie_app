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
      newShow.setValue(show.language.rawValue, forKey: "language")
      newShow.setValue(URL(string: show.image.medium), forKey: "medium_image")
      newShow.setValue(show.name, forKey: "name")
      newShow.setValue(URL(string: show.image.original), forKey: "original_image")
      newShow.setValue(show.status.rawValue, forKey: "status")
      newShow.setValue(show.summary, forKey: "summary")
      newShow.setValue(URL(string: show.url), forKey: "url")
      
      do {
        try context.save()
        print("It is saved !!* \\o/")
      } catch let error{
        print("Saving Failed \(error)")
      }
      
    }
  }
  
  func getShows() -> [ShowEntity]? {
    let results: [ShowEntity]
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      let context = appDelegate.persistentContainer.viewContext
      let fetchRequest = NSFetchRequest<ShowEntity>(entityName: "ShowEntity")
      
      do {
        results = try context.fetch(fetchRequest)
        return results
      } catch let error{
        print("Retrieving Failed \(error)")
      }
    }
    return nil
  }
}
