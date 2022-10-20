//
//  QuestionTextCell.swift
//  quiz-project
//
//  Created by Daria Sechko on 19.10.22.
//

import UIKit

class QuestionTextCell: UITableViewCell {
    
    static var reuseId = "QuestionTextCell"
    
    private lazy var backgroundCellView: UIView = {
        var view = UIView()
        view.backgroundColor = .brown.withAlphaComponent(0.5)
        view.layer.cornerRadius = 10
        
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        
        var label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(backgroundCellView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        
        backgroundCellView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView).inset(15)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(backgroundCellView).inset(30)
        }
        
        photoImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.bottom.equalTo(backgroundCellView).inset(20)
            
        }
    }
    
    //MARK: - Public
    
    func configure(_ model: Question?) {
        
        titleLabel.text = model?.text ?? ""
        
        let url = NSURL(string: model?.image ?? "")
        let imagedata = NSData.init(contentsOf: url! as URL)
        
        if imagedata != nil {
            photoImageView.image = UIImage(data:imagedata! as Data)
        }
    }
}
