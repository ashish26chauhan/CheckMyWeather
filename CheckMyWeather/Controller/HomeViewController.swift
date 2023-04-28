//
//  HomeViewController.swift
//  CheckMyWeather
//
//  Created by Ashish Chauhan  on 28/04/2023.
//

import UIKit

typealias JSONDictionary = [String: Any]

class HomeViewController: UIViewController {
    
    private let viewModel = HomeViewModel()
    private let searchController = UISearchController()
    
    @IBOutlet weak var cityLabel: UILabel!
    
    class var newInstance: HomeViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        return vc
    }
    
    override func viewDidLoad() {
        title = "Weather"
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Search your city"
        searchController.searchBar.searchTextField.returnKeyType = .search
        searchController.searchBar.searchTextField.delegate = self
        navigationItem.hidesBackButton = true
    }
    
    
}

extension HomeViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
       
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text else { return false }
        viewModel.fetchWeatherReport(for: text) { [self] response, error in
            guard let resp = response else { return }
            if let location = resp["location"] as? JSONDictionary, let city = location["name"] as? String, let currentTemp = resp["current"] as? JSONDictionary, let temp = currentTemp["temp_c"]  {
                print("City searched - ", city)
                DispatchQueue.main.async {
                    self.searchController.dismiss(animated: true)
                    self.cityLabel.text = city + "  " + "\(temp)"
                }
            }
        }
        return true
    }
}
