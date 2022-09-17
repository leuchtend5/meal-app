//
//  ViewController.swift
//  MyMealsApp
//
//  Created by Gilbert Tan on 31/08/22.
//

import UIKit

var mealModel = [MealModel]()

class ViewController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
//        tableView.separatorStyle = .none
        
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        
        loopingMealList()
        
        tableView.register(
            UINib(nibName: "TableViewCell", bundle: nil),
            forCellReuseIdentifier: "MealCell"
        )
    }
    
    func loopingMealList() {
        var index = 0
        while index <= 12 {
            dataManager.parseJSON {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.spinner.stopAnimating()
                }
            }
            index += 1
        }
    }
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! TableViewCell
        
        let meal = mealModel[indexPath.row]
        cell.mealName.text = meal.mealName
        cell.mealCategory.text = meal.mealCategory
        cell.mealImage.downloadImage(from: meal.mealImage)
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.identifier == "moveToDetail" {
        if let detaiViewController = segue.destination as? DetailViewController {
            detaiViewController.mealData = mealModel[tableView.indexPathForSelectedRow!.row]
        }
      }
    }
}
