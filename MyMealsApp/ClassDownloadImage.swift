
import UIKit

class DownloadImage: UIImageView {
    var dataTask: URLSessionDataTask!
    let spinner = UIActivityIndicatorView(style: .large)

    func downloadImage(from urlString: String) {
        image = nil
        
        addImageLoadingIndicator()
        
        if let dataTask = dataTask {
            dataTask.cancel()
        }
        
        let url = URL(string: urlString)
        dataTask = URLSession.shared.dataTask(with: url!) { data, response, error in
            guard let data = data, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
                self.stopImageLoadingIndicator()
            }
        }
        dataTask.resume()
    }
    
    func addImageLoadingIndicator() {
        addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        spinner.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        spinner.startAnimating()
    }
    
    func stopImageLoadingIndicator() {
        spinner.hidesWhenStopped = true
        spinner.stopAnimating()
    }
}
