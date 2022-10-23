//
//  QuestionImageCell.swift
//  quiz-project
//
//  Created by Daria Sechko on 23.10.22.
//

import UIKit

class QuestionImageCell: UITableViewCell {
    
    static var reuseId = "QuestionImageCell"
    
    private lazy var questionImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
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
        contentView.addSubview(questionImageView)
        contentView.backgroundColor = #colorLiteral(red: 0.1274336874, green: 0.1577785611, blue: 0.2958254814, alpha: 1)
    }
    
    private func setupConstraints() {
        
        questionImageView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalTo(contentView)
        }
        
    }
    
    //MARK: - Public
    
    func configure(_ model: Question?) {
        
        questionImageView.image = .init(named: model?.image ?? "")
    }
    
}
