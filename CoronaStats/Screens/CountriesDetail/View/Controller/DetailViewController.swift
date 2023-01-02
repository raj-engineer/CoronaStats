//
//  DetailViewController.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 04/12/22.
//
import UIKit

class DetailViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var factLabel: UILabel!
    @IBOutlet weak var countConfirmedLabel: UILabel!
    @IBOutlet weak var confirmedCaseLabel: UILabel!
    @IBOutlet weak var countDeceasedLabel: UILabel!
    @IBOutlet weak var deceasedCaseLabel: UILabel!
    @IBOutlet weak var countRecoveredLabel: UILabel!
    @IBOutlet weak var recoveredCaseLabel: UILabel!
    
    // MARK: - Properties
    private var detailViewModel: DetailViewModel!
  //  let detailViewModel = DetailViewModel(withService: DetailService())
    
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
    
    func configure(viewModel: DetailViewModel) {
            self.detailViewModel = viewModel
        }
    
    // MARK: - Private Functions
    private func setupDetailViewModelObserver() {
        detailViewModel.detail.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.setUIData()
            }
        }
    }
    
    private func setUIData() {
        guard let detailMapperModel = self.detailViewModel.getCountryDetail() else {return}
        countConfirmedLabel.text = detailMapperModel.confirmed
        countRecoveredLabel.text = detailMapperModel.recovered
        countDeceasedLabel.text = detailMapperModel.deceased
    }
    
    private func setNavigationBarUIData() {
        self.title = self.detailViewModel.countryName //"India"
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
