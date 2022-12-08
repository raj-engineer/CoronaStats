//
//  ErrorView.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 06/12/22.
//

import UIKit
import Foundation

public class ErrorView: UIView {
    
    // MARK: - IBOutlet
    @IBOutlet var titleLabel : UILabel!
    
    // MARK: - Functions
    public override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    //initWithCode to init view from xib or storyboard
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadViewFromNib()
    }
    
    private func loadViewFromNib() {
        if let nib = Bundle.main.loadNibNamed("ErrorView", owner: self),
           let nibView = nib.first as? UIView {
            nibView.frame = bounds
            nibView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            addSubview(nibView)
        }
    }
    
    func updateErrorText(title: String?) {
        if let title = title {
            titleLabel.text = title
        }
    }
}
