//
//  SearchTableViewController.swift
//  food
//
//  Created by J Lee on 7/23/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    
    var index: Int?
    
    @IBOutlet weak var layout: UICollectionViewFlowLayout!


    func didScroll(to position: CGFloat) {
        for cell in tableView.visibleCells as! [SearchTableViewCell] {
            (cell.collectionView as UIScrollView).contentOffset.x = position
        }
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return potentialRecipe.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell",
                                                          for: indexPath) as? SearchCollectionViewCell

            cell?.recipeName.text = RecipeBook[potentialRecipe[indexPath.row].index].FoodName
        if potentialRecipe[indexPath.row].ingredList.count == 0 {
            cell?.moreIngredients.text = ""
        }
        else {
            cell?.moreIngredients.text = "You need " + String(potentialRecipe[indexPath.row].ingredList.count) + " more ingredients!"
        }
            //cell?.StepsLabel.text = RecipeBook[indexPath.row].Steps
            setShadow(UICollectionViewCell: cell!)
        
        if FavoritesList.count != 0 {
            if FavoritesList.contains(indexPath.row) {
                let image = UIImage(named: "icons8-heart-30.png")
                cell?.filledHeart.image = image
            }
        }
        
        //on checkbox click
        cell?.onClick = { cell in
            if FavoritesList.contains(indexPath.row) {
                let image = UIImage(named: "")
                cell.filledHeart.image = image
                let delete = FavoritesList.index(of: indexPath.row) as! Int
                FavoritesList.remove(at: delete)
            }
            else {
                let image = UIImage(named: "icons8-heart-30.png")
                cell.filledHeart.image = image
                FavoritesList.append(indexPath.row)
                
            }
        }
        
            return cell!

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        index = potentialRecipe[indexPath.row].index
        performSegue(withIdentifier: "showDaFullRecipe", sender: index)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
//        setCardView(view: uiView)
        
        let layout = UICollectionViewFlowLayout()
        
        layout.scrollDirection = .horizontal
        
        let navigationBar = navigationController!.navigationBar
        navigationBar.prefersLargeTitles = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = UIColor("FFAF87")
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        
//        //get rid of bottom line of navigation
//        let navigationBar = navigationController!.navigationBar
//        navigationBar.isTranslucent = false
//        navigationBar.setBackgroundImage(UIImage(), for: .default)
//        navigationBar.shadowImage = UIImage()
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    func tableView(tableView: UITableView,
                   willDisplayCell cell: UITableViewCell,
                   forRowAtIndexPath indexPath: NSIndexPath) {
        
        guard let tableViewCell = cell as? SearchTableViewCell else { return }
        
        tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeued using a cell identifier.

            
            let cellIdentifier = "SearchTableViewCell"
            
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchTableViewCell  else {
                fatalError("The dequeued cell is not an instance of SearchTableViewCell.")
            }
            guard let tableViewCell = cell as? SearchTableViewCell else { return cell }
            
            tableViewCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: self, forRow: indexPath.row)
            
            tableView.rowHeight = 375
            tableView.estimatedRowHeight = 375
        
        
            return cell
        }


    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let data = index

        if let destinationViewController = segue.destination as? SearchViewController {
            destinationViewController.index = data
        }

    }
    
}
