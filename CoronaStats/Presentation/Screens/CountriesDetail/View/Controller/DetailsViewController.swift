//
//  DetailsViewController.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import UIKit

final class DetailsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet private weak var factLabel: UILabel!
    @IBOutlet private weak var countConfirmedLabel: UILabel!
    @IBOutlet private weak var confirmedCaseLabel: UILabel!
    @IBOutlet private weak var countDeceasedLabel: UILabel!
    @IBOutlet private weak var deceasedCaseLabel: UILabel!
    @IBOutlet private weak var countRecoveredLabel: UILabel!
    @IBOutlet private weak var recoveredCaseLabel: UILabel!
    
    // MARK: - Properties
    private var detailViewModel: DetailsViewModel!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setNavigationBarUIData()
        setUIStyle()
        
        // Data Binding
        setupDetailViewModelObserver()
        
        // fetch countries data
        detailViewModel.fetchCountryDetail()
    }
    
    func configure(viewModel: DetailsViewModel) {
        detailViewModel = viewModel
    }
    
    // MARK: - Private Functions
    private func setupDetailViewModelObserver() {
        /// show details 
        detailViewModel.detailEntity.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.setUIData()
            }
        }
        
        /// show or hide loader
        detailViewModel.output.loaderStatus.bind { status in
            Loader.shared.showLoadingView(status)
        }
    }
    
    private func setUIData() {
        guard let detailEntity = detailViewModel.getDetailEntity() else {return}
        countConfirmedLabel.text = detailEntity.confirmed
        countRecoveredLabel.text = detailEntity.recovered
        countDeceasedLabel.text = detailEntity.deceased
    }
    
    private func setNavigationBarUIData() {
        title = detailViewModel.countryName
        navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor:UIColor.customGrey]
    }
    
    private func setUIStyle() {
        view.backgroundColor = UIColor.background
        confirmedCaseLabel.textColor = UIColor.customGrey
        deceasedCaseLabel.textColor = UIColor.customGrey
        recoveredCaseLabel.textColor = UIColor.customGrey
        factLabel.textColor = UIColor.customGrey
        countConfirmedLabel.textColor = UIColor.customGreen
        countDeceasedLabel.textColor = UIColor.customRed
        countRecoveredLabel.textColor = UIColor.customBlue
    }
}
