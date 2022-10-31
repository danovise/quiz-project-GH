//
//  SignInVC.swift
//  quiz-project
//
//  Created by Daria Sechko on 31.10.22.
//

import UIKit
import FirebaseAuth

class SignInVC: UIViewController {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .black
        scrollView.bounces = true
        
        return scrollView
    }()
    
    private let stackViewContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "main")
        image.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        return image
    }()
    
    private let signLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "Sign in"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        return label
    }()
    
    private var  emailTextField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.backgroundColor = .white
        textView.text = "Email"
        textView.isScrollEnabled = false
        textView.textColor = .lightGray
        textView.font = .systemFont(ofSize: 20)
        textView.layer.cornerRadius = 10
        textView.textContainerInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        
        return textView
    }()
    
    private var passwordTextField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.backgroundColor = .white
        textView.text = "Password"
        textView.isScrollEnabled = false
        textView.textColor = .lightGray
        textView.font = .systemFont(ofSize: 20)
        textView.layer.cornerRadius = 10
        textView.textContainerInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        
        return textView
    }()
    
    private var answerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.01418284792, green: 0.5850355029, blue: 0.9913098216, alpha: 1)
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        button.addTarget(self, action: #selector(authorizeToFirebase), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    func setupViews(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackViewContainer)
        
        stackViewContainer.addArrangedSubview(imageView)
        stackViewContainer.addArrangedSubview(signLabel)
        stackViewContainer.addArrangedSubview(emailTextField)
        stackViewContainer.addArrangedSubview(passwordTextField)
        stackViewContainer.addArrangedSubview(answerButton)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            stackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 60),
            stackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackViewContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20)
        ])
    }
    //MARK: - Action
    @objc func authorizeToFirebase() {
        
        Auth.auth().signIn(withEmail: "test@test.com", password: "test12345678") { result, error in
            
            if let error = error {
                
                print(error.localizedDescription)
                return
            }
        }
    }
}
