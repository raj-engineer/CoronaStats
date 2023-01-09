//
//  CountryCell.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 03/12/22.
//

import UIKit

class CountryCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var nameLabel: UILabel!
    
    // MARK: - override function
    override func awakeFromNib() {
        super.awakeFromNib()
        // Remove cell highlight/selection color
        self.selectionStyle = .none
    }
    
    func configure(_ title: String?) {
        guard let _title = title else { return }
        nameLabel.text = _title
    }
}
