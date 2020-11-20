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
  
  private func handleMoveToTrash(at indexPath: IndexPath) {
    deleteShow(show: (shows?[indexPath.row])!)
    shows?.remove(at: indexPath.row)
    tableView.deleteRows(at: [indexPath], with: .fade)
    tableView.reloadData()
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "FavoriteDetailShow"?:
      if let row = tableView.indexPathForSelectedRow?.row {
        let show = shows?[row]
        let detailFavoriteViewController = segue.destination as! FavoriteDetailViewController
        detailFavoriteViewController.show = show
        
        let backItem = UIBarButtonItem()
        backItem.title = "Shows \(show?.id ?? 0)"
        navigationItem.backBarButtonItem = backItem
      }
    default:
      print("Sin eventos")
    }
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
  
}
