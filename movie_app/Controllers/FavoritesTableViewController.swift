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
}
