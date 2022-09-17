
import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var mealImage: DownloadImage!
    @IBOutlet weak var mealIngredients: UILabel!
    @IBOutlet weak var mealInstructions: UILabel!
    @IBOutlet weak var mealName: UILabel!
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var detailView: UIView!
    
    var mealData: MealModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mealImage.layer.cornerRadius = mealImage.frame.size.width / 2
        mealImage.clipsToBounds = true
        
        mealImage.downloadImage(from: mealData!.mealImage)
        mealName.text = mealData!.mealName
        mealInstructions.text = mealData!.instructions
        
        // Mengambil nama & measure ingredient dan digabungkang ke array.
        // Kemudian arraynya digabung lagi menggunakan joined
        var ingredientArray = [String]()
        for data in mealData!.ingredients {
            ingredientArray.append(data.nameIngredient + " " + data.measure)
        }
        let ingredientString = ingredientArray.joined(separator: "\r\n")
        mealIngredients.text = ingredientString
        
        detailView.backgroundColor = .clear
        
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.view.bounds
        backgroundImage.addSubview(blurView)
        
        detailView.backgroundColor = UIColor(white: 0, alpha: 0.2)
        
        
    }

}
