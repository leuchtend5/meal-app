
import Foundation

struct MealData: Decodable {
    let meals: [Meals]
}

struct Meals: Decodable {
    let strMeal: String
    let strCategory: String
    let strInstructions: String
    let strMealThumb: String
    let ingredients: [Ingredient]
}

extension Meals {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let mealDictionary = try container.decode([String: String?].self)

        var index = 1
        var ingredients: [Ingredient] = []

        while let ingredient = mealDictionary["strIngredient\(index)"] as? String,
              let measure = mealDictionary["strMeasure\(index)"] as? String,
              !ingredient.isEmpty,
              !measure.isEmpty {
            ingredients.append(.init(nameIngredient: ingredient, measure: measure))
            index += 1
        }
        self.ingredients = ingredients
        strMeal = mealDictionary["strMeal"] as? String ?? ""
        strCategory = mealDictionary["strCategory"] as? String ?? ""
        strInstructions = mealDictionary["strInstructions"] as? String ?? ""
        strMealThumb = mealDictionary["strMealThumb"] as? String ?? ""
    }
}

struct Ingredient: Decodable {
    let nameIngredient: String
    let measure: String
}
