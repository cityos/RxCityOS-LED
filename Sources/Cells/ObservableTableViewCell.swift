//
//  ObservableTableViewCell.swift
//  CityOS-LED
//
//  Created by Said Sikira on 5/7/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

extension CollectionType where Generator.Element: UIView {
    public func setTranslatesAutoResizingMaskIntoConstraints(translate: Bool) {
        for view in self {
            view.translatesAutoresizingMaskIntoConstraints = translate
        }
    }
}

extension CollectionType where Generator.Element == NSLayoutConstraint {
    func activateConstraints() {
        NSLayoutConstraint.activateConstraints(self as! [NSLayoutConstraint])
    }
    
    func deactivateConstraints() {
        NSLayoutConstraint.deactivateConstraints(self as! [NSLayoutConstraint])
    }
}

protocol ObservableCellViewModelType {
    var title: String? { get set }
    var subtitle: String? { get set }
    var image: UIImage? { get set }
    var rightTitle: String? { get set }
    var rightSubtitle: String? { get set }
}

public class ObservableCellViewModel: ObservableCellViewModelType {
    var title: String?
    var subtitle: String?
    var image: UIImage?
    var rightTitle: String?
    var rightSubtitle: String?
}

public class ObservableTableViewCell: UITableViewCell {
    
    //MARK: - Views
    lazy var mainImageView: UIImageView = UIImageView()
    lazy var leadingLabel: UILabel = UILabel()
    lazy var leadingSubtitleLabel: UILabel = UILabel()
    lazy var trailingLabel: UILabel = UILabel()
    lazy var trailingSubtitleLabel: UILabel = UILabel()
    
    lazy var stackView = UIStackView()
    lazy var leadingStackView = UIStackView()
    lazy var trailingStackView = UIStackView()
    
    //MARK: - Properties
    lazy var viewModel: ObservableCellViewModelType = ObservableCellViewModel()
    var fontFamily: String?
    
    //MARK: - Helper methods
    
    func setupStackViews() {
        stackView.axis = .Horizontal
        stackView.alignment = .Fill
        stackView.distribution = .Fill
        stackView.spacing = 20
        
        leadingStackView.axis = .Vertical
        leadingStackView.alignment = .Fill
        leadingStackView.distribution = .FillEqually
        
        trailingStackView.axis = .Vertical
        trailingStackView.alignment = .Fill
        trailingStackView.distribution = .FillEqually
        
    }
    
    func addSubviews() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        if let image = viewModel.image {
            mainImageView.image = image
            stackView.addArrangedSubview(mainImageView)
        }
        
        stackView.addArrangedSubview(leadingStackView)
        
        if let title = viewModel.title {
            leadingLabel.text = title
            leadingStackView.addArrangedSubview(leadingLabel)
        }
        
        if let subtitle = viewModel.subtitle {
            leadingSubtitleLabel.text = subtitle
            leadingStackView.addArrangedSubview(leadingSubtitleLabel)
        }
        
        stackView.addArrangedSubview(trailingStackView)
        
        if let rightTitle = viewModel.rightTitle {
            trailingLabel.text = rightTitle
            trailingStackView.addArrangedSubview(trailingLabel)
        }
        
        if let rightSubtitle = viewModel.rightSubtitle {
            trailingSubtitleLabel.text = rightSubtitle
            trailingStackView.addArrangedSubview(trailingSubtitleLabel)
        }
    }
    
    func setupConstraints() {
        var stackViewConstraints = [NSLayoutConstraint]()
        
        stackViewConstraints.appendContentsOf(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "H:|-20-[stackView]-20-|",
                options: [],
                metrics: nil,
                views: ["stackView": stackView]
            )
        )
        
        stackViewConstraints.appendContentsOf(
            NSLayoutConstraint.constraintsWithVisualFormat(
                "V:|[stackView]|",
                options: [],
                metrics: nil,
                views: ["stackView": stackView]
            )
        )
        
        stackViewConstraints.activateConstraints()
    }
    
    func customizeViews() {
        if let fontFamily = fontFamily {
            leadingLabel.font = UIFont(name: fontFamily, size: 17)
            leadingSubtitleLabel.font = UIFont(name: fontFamily, size: 14)
            trailingLabel.font = UIFont(name: fontFamily, size: 17)
            trailingSubtitleLabel.font = UIFont(name: fontFamily, size: 14)
        }
        
        leadingSubtitleLabel.textAlignment = .Left
        trailingSubtitleLabel.textAlignment = .Right
    }
    
    //MARK: - Init methods
    final func commonInit() {
        setupStackViews()
        addSubviews()
        setupConstraints()
        customizeViews()
    }
    
    public override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}