//
//  CheckButtonCell.swift
//  quiz-project
//
//  Created by Daria Sechko on 19.10.22.
//

import UIKit

class CheckButtonCell: UITableViewCell {
    
    static var reuseId = "CheckButtonCell"
    
    private lazy var checkButton: UIButton = {
        
        var button = UIButton()
        button.setTitle("Проверить", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    
    private func setupViews() {
        contentView.addSubview(checkButton)
    }
    
    private func setupConstraints() {
        
        checkButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: Question?) {
        
        checkButton.setTitle("Продолжить", for: .normal)
    }
}

