//
//  AnswerCell.swift
//  quiz-project
//
//  Created by Daria Sechko on 19.10.22.
//

import UIKit

class AnswerCell: UITableViewCell {
    
    static var reuseId = "AnswerCell"
    
    private lazy var answerLabel: UILabel = {
        
        var label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var backgroundCellView: UIView = {
        var view = UIView()
        view.backgroundColor = .yellow.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        
        return view
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
        contentView.addSubview(backgroundCellView)
        contentView.addSubview(answerLabel)
    }
    
    private func setupConstraints() {
        
        backgroundCellView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).inset(5)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).inset(20)
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: Answer?) {
        
        answerLabel.text = model?.text ?? ""
    }
}
