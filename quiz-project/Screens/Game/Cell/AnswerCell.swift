//
//  AnswerCell.swift
//  quiz-project
//
//  Created by Daria Sechko on 19.10.22.
//

import UIKit

protocol AnswerCellDelegate: AnyObject {
    func answerCellSelectAnswer()
}

class AnswerCell: UITableViewCell {
    
    static var reuseId = "AnswerCell"
    
    var currentAnswer: Answer? = nil
    var canTapAnswer: Bool = true
    var delegate: AnswerCellDelegate?
    
    private lazy var answerLabel: UILabel = {
        
        var label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        
        return label
    }()
    
    private lazy var backgroundCellView: UIView = {
        var view = UIView()
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var answerButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = .clear
        
        button.addTarget(self, action: #selector(answerButtonAction), for: .touchUpInside)
        
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
        contentView.addSubview(backgroundCellView)
        contentView.addSubview(answerLabel)
        contentView.addSubview(answerButton)
    }
    
    private func setupConstraints() {
        
        backgroundCellView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).inset(5)
        }
        
        answerLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).inset(20)
        }
        
        answerButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: Answer?, buttonState: CheckButtonState, answerIsCorrect: Bool, canTapAnswer: Bool) {
        
        self.currentAnswer = model
        self.canTapAnswer = canTapAnswer
        
        answerLabel.text = model?.text ?? ""
        
        switch buttonState {
        case .next:
            
            if model?.isSelected == true {
                backgroundCellView.backgroundColor = .blue.withAlphaComponent(0.9)
            } else {
                backgroundCellView.backgroundColor = .lightGray.withAlphaComponent(0.5)
            }
            
        case .check:
            
            if answerIsCorrect == true {
                
                if let isCorrect = model?.isCorrect, isCorrect == true {
                    backgroundCellView.backgroundColor = .green.withAlphaComponent(0.9)
                } else {
                    backgroundCellView.backgroundColor = .lightGray.withAlphaComponent(0.5)
                }
                return
            }
            //Расклад
            if let isCorrect = model?.isCorrect, isCorrect == true {
                backgroundCellView.backgroundColor = .green.withAlphaComponent(0.9)
            } else {
                backgroundCellView.backgroundColor = .red.withAlphaComponent(0.9)
            }
        }
    }
    //MARK: - Actions
    
    @objc func answerButtonAction() {
        
        if canTapAnswer == true || currentAnswer?.isSelected == true {
            currentAnswer?.isSelected = currentAnswer?.isSelected == false ? true : false
            delegate?.answerCellSelectAnswer()
        }
    }
}

