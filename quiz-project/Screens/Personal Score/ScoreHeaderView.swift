//
//  ScoreHeaderView.swift
//  quiz-project
//
//  Created by Daria Sechko on 3.12.22.
//

import UIKit

class ScoreHeaderView: UIView {

    private lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .systemBlue
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private
    private func setupViews() {
        self.addSubview(headerLabel)
        self.backgroundColor = .systemGray3
    }
    
    private func setupConstraints() {
       
        headerLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(30)
        }
    }
    
    //MARK: - Public
    func configure(totalScore: Int) {
        headerLabel.text = "Общий счёт - \(totalScore)"
    }
}
