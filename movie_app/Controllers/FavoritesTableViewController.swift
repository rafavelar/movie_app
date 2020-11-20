//
//  FavoritesTableViewController.swift
//  movie_app
//
//  Created by Rafael Avelar on 19/11/20.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
  
  private var shows: [ShowEntity]?
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    self.shows = getShows()
    self.tableView.reloadData()
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.shows?.count ?? 0
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath)
    let show = self.shows?[indexPath.row]
    cell.textLabel?.text = show?.name
    
    if let imageUrl = show?.medium_image {
      cell.imageView?.setImage(from: imageUrl, withPlaceholder: UIImage(systemName: "wifi.exclamationmark"))
    }
    
    return cell
  }
  
  // MARK: - Swipe Actions
  override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    // Delete action
    let delete = UIContextualAction(style: .destructive,
                                    title: "Delete") { [weak self] (action, view, completionHandler) in
      self?.handleMoveToTrash(at: indexPath)
      completionHandler(true)
    }
    delete.backgroundColor = .systemRed
    
    let configuration = UISwipeActionsConfiguration(actions: [delete])
    
    return configuration
  }
  
  private func handleMoveToTrash(at indexPath: IndexPath) {
    shows?.remove(at: indexPath.row-1)
    tableView.deleteRows(at: [indexPath], with: .fade)
    deleteShow(show: (shows?[indexPath.row-1])!)
    tableView.reloadData()
  }
  
}
