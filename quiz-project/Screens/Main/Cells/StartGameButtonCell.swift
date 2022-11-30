//
//  StartGameButtonCell.swift
//  quiz-project
//
//  Created by Daria Sechko on 25.11.22.
//

import UIKit

protocol StartGameButtonCellOutput: AnyObject {
    func startGameButtonCellDidSelect()
}

class StartGameButtonCell: UITableViewCell {

    static var reuseId = "StartGameButtonCell"
    
    weak var delegate: StartGameButtonCellOutput?
    
    private lazy var startButton: UIButton = {
        
        var button = UIButton()
        button.setTitle("Начать", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.isEnabled = false
        
        button.addTarget(self, action: #selector(startGameAction), for: .touchUpInside)
   
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
        contentView.addSubview(startButton)
        
        self.selectionStyle = .none
    }
    
    private func setupConstraints() {
        
        startButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(30)
            make.top.bottom.equalToSuperview().inset(20)
            //make.height.equalTo(50)
        }
    }
    
    //MARK: - Public
    func configure(_ model: Category?) {
        
        if model != nil {
            startButton.isEnabled = true
        }
    }
    
    //MARK: - Actions
    @objc
    func startGameAction() {
        delegate?.startGameButtonCellDidSelect()
    }
}

