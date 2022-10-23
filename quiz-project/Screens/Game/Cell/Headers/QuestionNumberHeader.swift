//
//  QuestionNumberHeader.swift
//  quiz-project
//
//  Created by Daria Sechko on 23.10.22.
//

import UIKit

class QuestionNumberHeader: UIView {

    private lazy var lightBackgroundCellView: UIView = {
        var view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return view
    }()
    
    private lazy var headerLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
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
        
        self.addSubview(lightBackgroundCellView)
        self.addSubview(headerLabel)
        self.backgroundColor = #colorLiteral(red: 0.1274336874, green: 0.1577785611, blue: 0.2958254814, alpha: 1)
    }
    
    private func setupConstraints() {
        lightBackgroundCellView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self).inset(10)
            make.height.equalTo(1)
        }
        
        headerLabel.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview().inset(30)
        }
    }
    
    //MARK: - Public
    func configure(currentQuestion: Int, numberOfQuestions: Int) {
        headerLabel.text = "Вопрос \(currentQuestion) из \(numberOfQuestions)"
    }
    
}

