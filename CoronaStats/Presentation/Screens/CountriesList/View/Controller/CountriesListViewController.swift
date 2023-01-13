//
//  CountriesListViewController.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//
import UIKit

final class CountriesListViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var countriesTableView: UITableView!
    
    // MARK: - Properties
    private let countriesViewModel: CountriesListViewModelProtocol = CountriesListViewModel()
    private let searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // set title
        title = ScreenTitle.Countries
        setupTableView()
        setupCountriesViewModelObserver()
        setupSearchBar()
        // fetch countries data
        countriesViewModel.fetchCountries()
    }
    
    // MARK: - Private Functions
    private func setupTableView() {
        // Register table cell
        countriesTableView.registerCell(type: CountryCell.self)
        
        // delegate the TableView
        countriesTableView.dataSource = self
        countriesTableView.delegate = self
    }
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
                self?.displayAlert(with: error)
            }
        }
    }
    
    private func displayAlert(with message: String?) {
        let alertController = UIAlertController(title: Alert.alertTitle, message: message ?? "", preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: Alert.okTitle, style: .default) { (action:UIAlertAction!) in
            // Code in this block will trigger when OK button tapped.
        }
        alertController.addAction(OKAction)
        present(alertController, animated: true, completion:nil)
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
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        let country = countriesViewModel.getItem(at: indexPath)
        detailViewController.configure(viewModel: DetailsViewModel(countryName: country))
        navigationController?.pushViewController(detailViewController,animated:true)
    }
}

//MARK: - UISearchResultsUpdating
extension CountriesListViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        countriesViewModel.input.filterCountriesList(for: searchController.searchBar.text!)
    }
}
