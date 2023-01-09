//
//  CountriesListViewController.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation
import UIKit

class CountriesListViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var countriesTableView: UITableView!
    
    // MARK: - Properties
    let countriesViewModel: CountriesListViewModelProtocol = CountriesListViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set title
        self.title = ScreenTitle.Countries
        
        // Register table cell
        countriesTableView.registerCell(type: CountryCell.self)
        
        // delegate the TableView
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
        
        // Data Binding
        setupCountriesViewModelObserver()
        
        setupSearchBar()
        
        // fetch countries data
        self.countriesViewModel.fetchCountries()
    }
    
    // MARK: - Private Functions
    private func setupSearchBar() {
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        countriesTableView.tableHeaderView = searchController.searchBar
    }
    
    private func setupCountriesViewModelObserver() {
        
        /// reload tableView
        countriesViewModel.output.reloadTable.bind {[weak self] _ in
            DispatchQueue.main.async {
                self?.countriesTableView.reloadData()
            }
        }
        
        /// show or hide loader
        countriesViewModel.output.loaderStatus.bind { status in
            Loader.shared.showLoadingView(status)
        }
        
        /// show error 
        countriesViewModel.output.error.bind { [weak self] error in
            DispatchQueue.main.async {
                self?.displayErrorOnUI(message: error)
            }
        }
    }
    
    private func displayErrorOnUI(message: String?) {
        let errorView = ErrorView(frame: CGRect(x: .zero, y: .zero, width: self.view.frame.width, height: self.view.frame.height/4))
        errorView.center = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height/2)
        errorView.updateErrorText(title: message)
        self.view.addSubview(errorView)
    }
}

// MARK: - UITableViewDataSource
extension CountriesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesViewModel.output.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: CountryCell.self, for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        
        let countryName = countriesViewModel.getItem(at: indexPath)
        cell.configure(countryName)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CountriesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let country = self.countriesViewModel.getItem(at: indexPath) else {
            return
        }
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        detailViewController.configure(viewModel: DetailsViewModel(countryName: country))
        self.navigationController?.pushViewController(detailViewController,animated:true)
    }
}

//MARK: - UISearchResultsUpdating
extension CountriesListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        countriesViewModel.input.filterCountriesList(for: searchController.searchBar.text!)
    }
}
