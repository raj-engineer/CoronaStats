//
//  ViewController.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 03/12/22.
//

import UIKit

class CountriesViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var countriesTableView: UITableView!
    
    // MARK: - Properties
    let countriesViewModel = CountriesViewModel(withService: CountriesService())
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
        countriesViewModel.countries.bind {[weak self] _ in
            DispatchQueue.main.async {
                self?.countriesTableView.reloadData()
            }
        }
        
        countriesViewModel.error.bind { [weak self] error in
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
extension CountriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesViewModel.filteredItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueCell(withType: CountryCell.self, for: indexPath) as? CountryCell else {
            return UITableViewCell()
        }
        
        let countryName = countriesViewModel.filteredItems?[indexPath.row]
        cell.configure(countryName)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CountriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.countriesViewModel.didSelectItemAt(indexPath: indexPath)
        guard let country = self.countriesViewModel.selectedData else {
            return
        }
        let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.configure(viewModel: DetailViewModel(countryName: country))
        self.navigationController?.pushViewController(detailViewController,animated:true)
    }
}

//MARK: - UISearchResultsUpdating
extension CountriesViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        // If we haven't typed anything into the search bar then do not filter the results
        guard let items = countriesViewModel.countries.value else { return }
        if searchController.searchBar.text! == "" {
            countriesViewModel.filteredItems = items
        } else {
            // Filter the results
            countriesViewModel.filteredItems = items.filter { $0.lowercased().contains(searchController.searchBar.text!.lowercased()) }
        }
        
        self.countriesTableView.reloadData()
    }
}
