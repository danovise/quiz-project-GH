//
//  CategoryCollectionCell.swift
//  quiz-project
//
//  Created by Daria Sechko on 25.11.22.
//

import UIKit

protocol CategoryCollectionCellOutput: AnyObject {
    func categoryCollectionCellDidSelect(_ category: Category)
}

class CategoryCollectionCell: UICollectionViewCell {
    
    static var reuseId = "CategoryTextCollectionCell"
    
    weak var delegate: CategoryCollectionCellOutput? //controller
    
    var category: Category?

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.layer.cornerRadius = 20
        label.clipsToBounds = true
        label.textAlignment = .center
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Avenir Next", size: 20)
        label.textColor = .systemBackground
        label.backgroundColor = .blue
        return label
    }()
    
    private lazy var titleButton: UIButton = {
        var button = UIButton()
        //button.backgroundColor = .clear
        button.backgroundColor = .systemGray6.withAlphaComponent(0.1)
        button.addTarget(self, action: #selector(titleButtonAction), for: .touchUpInside)
        return button
    }()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: Public
    func configure(model: Category) {
        
        self.category = model
        
        titleLabel.text = model.name
        
        if model.selected {
            titleLabel.backgroundColor = .systemGreen
        } else {
            titleLabel.backgroundColor = .systemBlue
        }
    }

    // MARK: - Private

    private func setupViews() {
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(titleButton)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.left.right.bottom.equalTo(contentView).inset(20)
        }
        
        titleButton.snp.makeConstraints {
            $0.top.left.right.bottom.equalTo(contentView).inset(20)
        }
    }
    
    // MARK: - Actions
    @objc func titleButtonAction() {
        
        if let category = category {
            category.selected = true
            delegate?.categoryCollectionCellDidSelect(category)
        }

    }
    
}
