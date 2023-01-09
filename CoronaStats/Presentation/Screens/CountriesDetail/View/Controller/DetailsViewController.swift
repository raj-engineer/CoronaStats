//
//  DetailsViewController.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 08/01/23.
//

import Foundation
import UIKit

class DetailsViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var countConfirmedLabel: UILabel!
    @IBOutlet weak var confirmedCaseLabel: UILabel!
    @IBOutlet weak var countDeceasedLabel: UILabel!
    @IBOutlet weak var deceasedCaseLabel: UILabel!
    @IBOutlet weak var countRecoveredLabel: UILabel!
    @IBOutlet weak var recoveredCaseLabel: UILabel!
    
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
        self.detailViewModel.fetchCountryDetail()
    }
    
    func configure(viewModel: DetailsViewModel) {
        self.detailViewModel = viewModel
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
        guard let detailEntity = self.detailViewModel.getCountryDetail() else {return}
        countConfirmedLabel.text = detailEntity.confirmed
        countRecoveredLabel.text = detailEntity.recovered
        countDeceasedLabel.text = detailEntity.deceased
    }
    
    private func setNavigationBarUIData() {
        self.title = self.detailViewModel.countryName
        self.navigationController?.navigationBar.titleTextAttributes =  [NSAttributedString.Key.foregroundColor:UIColor.customGrey]
    }
    
    private func setUIStyle() {
        self.view.backgroundColor = UIColor.background
        confirmedCaseLabel.textColor = UIColor.customGrey
        deceasedCaseLabel.textColor = UIColor.customGrey
        recoveredCaseLabel.textColor = UIColor.customGrey
        factLabel.textColor = UIColor.customGrey
        countConfirmedLabel.textColor = UIColor.customGreen
        countDeceasedLabel.textColor = UIColor.customRed
        countRecoveredLabel.textColor = UIColor.customBlue
    }
}
