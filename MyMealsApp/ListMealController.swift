
import UIKit

var mealModel = [MealModel]()

class ListMealController: UIViewController {
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.view.bounds
        tableView.backgroundView = blurView
        tableView.backgroundColor = UIColor(white: 0, alpha: 0.2)
        tableView.layer.cornerRadius = 12
        
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

extension ListMealController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mealModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MealCell", for: indexPath) as! TableViewCell
        
        let meal = mealModel[indexPath.row]
        cell.mealName.text = meal.mealName
        cell.mealCategory.text = meal.mealCategory
        cell.mealImage.downloadImage(from: meal.mealImage)
        cell.backgroundColor = .clear
        
        return cell
    }
    
}

extension ListMealController: UITableViewDelegate {
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
