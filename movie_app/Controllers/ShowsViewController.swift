//
//  ShowsViewController.swift
//  movie_app
//
//  Created by Rafael Avelar on 19/11/20.
//

import UIKit

class ShowsViewController: UITableViewController {
  
  private var shows: [Show]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = false
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem
    NetworkManager().fetchShows{ (shows) in
      self.shows = shows
      DispatchQueue.main.async {
        self.tableView.reloadData()
      }
    }
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.shows?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
    let show = self.shows?[indexPath.row]
    cell.textLabel?.text = show?.name
    
    if let strUrl = show?.image.medium {
      let imageUrl = URL(string: strUrl.replacingOccurrences(of: "http", with: "https"))!
      cell.imageView?.setImage(from: imageUrl, withPlaceholder: UIImage(systemName: "wifi.exclamationmark"))
    }
    
    return cell
  }
  
  // MARK: - Swipe Actions
  override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .normal,
                                    title: "Favourite") { [weak self] (action, view, completionHandler) in
      self?.handleMarkAsFavourite()
      completionHandler(true)
    }
    action.backgroundColor = .systemGreen
    
    return UISwipeActionsConfiguration(actions: [action])
  }
  
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    // Delete action
    let delete = UIContextualAction(style: .destructive,
                                    title: "Delete") { [weak self] (action, view, completionHandler) in
      self?.handleMoveToTrash()
      completionHandler(true)
    }
    delete.backgroundColor = .systemRed
    
    let configuration = UISwipeActionsConfiguration(actions: [delete])
    
    return configuration
  }
  
  private func handleMarkAsFavourite(at offsets: IndexPath) {
    print("Marked as favourite")
  }
  
  private func handleMoveToTrash(at indexPath: IndexPath) {
    shows?.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
    tableView.reloadData()
  }
}
