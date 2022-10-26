//
//  CheckButtonCell.swift
//  quiz-project
//
//  Created by Daria Sechko on 19.10.22.
//

import UIKit

enum CheckButtonState {
    case normal // стартовое состояние
    case check //1 состояние - Проверить ответ
    case next //2 состояние - Следующий вопрос
}

protocol CheckButtonCellDelegate: AnyObject {
    func checkButtonCellNextQuestion(_ buttonState: CheckButtonState)
}

class CheckButtonCell: UITableViewCell {
    
    static var reuseId = "CheckButtonCell"
    
    var buttonState: CheckButtonState = .normal
    
    var delegate: CheckButtonCellDelegate?
    
    private lazy var checkButton: UIButton = {
        
        var button = UIButton()
        button.setTitle("Проверить", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        
        button.addTarget(self, action: #selector(nextQuestionAction), for: .touchUpInside)
        
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
        
        self.selectionStyle = .none
    }
    
    private func setupConstraints() {
        
        checkButton.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: Question?,  answerIsChecked: Bool) {
        
        checkButton.isEnabled = answerIsChecked
    }
    
    //MARK: - Actions
    @objc func nextQuestionAction() {
        
        switch buttonState {
            
        case .normal:
            
            checkButton.setTitle("Следующий", for: .normal)
            buttonState = .check
            delegate?.checkButtonCellNextQuestion(buttonState) //output интерфейс
            
        case .check:
            
            checkButton.setTitle("Проверить", for: .normal)
            buttonState = .next
            delegate?.checkButtonCellNextQuestion(buttonState) //output интерфейс
            
          
        case .next:
            
            checkButton.setTitle("Следующий", for: .normal)
            buttonState = .check
            
            delegate?.checkButtonCellNextQuestion(buttonState) //output интерфейс
            
        }
    }
    
}

