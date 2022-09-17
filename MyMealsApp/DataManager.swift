
import Foundation

struct DataManager {
    func parseJSON(_ completed: @escaping () -> Void ) {
        let urlString = "https://www.themealdb.com/api/json/v1/1/random.php"
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    do {
                        let decodedData = try JSONDecoder().decode(MealData.self, from: data!)
                        let mealName = decodedData.meals[0].strMeal
                        let mealCategory = decodedData.meals[0].strCategory
                        let instructions = decodedData.meals[0].strInstructions
                        let mealImage = decodedData.meals[0].strMealThumb
                        let ingredient = decodedData.meals[0].ingredients
                        
                        mealModel.append(MealModel(
                            mealName: mealName,
                            mealCategory: mealCategory,
                            instructions: instructions,
                            mealImage: mealImage,
                            ingredients: ingredient
                        ))
                        
                        completed()
                        
                    } catch {
                        print(error)
                    }
                }
            }
            task.resume()
        }
    }
}
