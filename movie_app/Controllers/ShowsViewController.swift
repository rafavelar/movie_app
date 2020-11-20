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
    
    self.tabBarController?.navigationItem.title = "TV Shows"
    
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
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segue.identifier {
    case "showDetailShow"?:
      if let row = tableView.indexPathForSelectedRow?.row {
        let show = shows?[row]
        let detailShowViewController = segue.destination as! ShowDetailViewController
        detailShowViewController.show = show
        
        let backItem = UIBarButtonItem()
        backItem.title = "Shows \(show?.id ?? 0)"
        navigationItem.backBarButtonItem = backItem
      }
    default:
      print("Sin eventos")
    }
  }
  
  // MARK: - Swipe Actions
  override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
    let action = UIContextualAction(style: .normal,
                                    title: "Favourite") { [weak self] (action, view, completionHandler) in
      self?.handleMarkAsFavourite(at: indexPath)
      completionHandler(true)
    }
    action.backgroundColor = .systemGreen
    
    return UISwipeActionsConfiguration(actions: [action])
  }
  
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
  
  private func handleMarkAsFavourite(at indexPath: IndexPath) {
    save(show: (self.shows?[indexPath.row])!)
  }
  
  private func handleMoveToTrash(at indexPath: IndexPath) {
    
    let deleteAlert = UIAlertController(title: "Warning", message: "¿Deseas eliminar el show de la lista?", preferredStyle: UIAlertController.Style.alert)
    
    deleteAlert.addAction(UIAlertAction(title: "Si", style: .default, handler: { (action: UIAlertAction!) in
      self.shows?.remove(at: indexPath.row)
      self.tableView.deleteRows(at: [indexPath], with: .fade)
      self.tableView.reloadData()
      print("Handle Ok logic here")
    }))
    
    deleteAlert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (action: UIAlertAction!) in
      print("Handle Cancel Logic here")
    }))
    
    present(deleteAlert, animated: true, completion: nil)
  }
}
