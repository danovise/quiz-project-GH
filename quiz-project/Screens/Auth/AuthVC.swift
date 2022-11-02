//
//  AuthVC.swift
//  quiz-project
//
//  Created by Daria Sechko on 30.10.22.
//

import UIKit
import FirebaseAuth

class AuthVC: UIViewController {
    
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
        stackView.spacing = 20
        
        return stackView
    }()
    
    private var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "main")
        image.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        return image
    }()
    
    private var signLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 40)
        label.text = "Sign up"
        label.textAlignment = .center
        label.textColor = .white
        label.numberOfLines = 0
        label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        return label
    }()
    
    private var emailTextField: UITextView = {
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
    
    private let usernameTextField: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.contentInsetAdjustmentBehavior = .automatic
        textView.backgroundColor = .white
        textView.text = "Name"
        textView.isScrollEnabled = false
        textView.textColor = .lightGray
        textView.font = .systemFont(ofSize: 20)
        textView.layer.cornerRadius = 10
        textView.textContainerInset = .init(top: 20, left: 20, bottom: 20, right: 20)
        
        return textView
    }()
    
    private let passwordTextField: UITextView = {
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
    
    private let answerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Create account", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = #colorLiteral(red: 0.01418284792, green: 0.5850355029, blue: 0.9913098216, alpha: 1)
        button.layer.cornerRadius = 10
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        button.addTarget(self, action: #selector(registrationToFirebase), for: .touchUpInside)
        
        return button
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Already have an account? Sign in", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        button.addTarget(self, action: #selector(showSignInScreen), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        
        showMainScreen()
    }
    
    func setupViews(){
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackViewContainer)
        
        stackViewContainer.addArrangedSubview(imageView)
        stackViewContainer.addArrangedSubview(signLabel)
        stackViewContainer.addArrangedSubview(emailTextField)
        stackViewContainer.addArrangedSubview(usernameTextField)
        stackViewContainer.addArrangedSubview(passwordTextField)
        stackViewContainer.addArrangedSubview(answerButton)
        
        stackViewContainer.addArrangedSubview(signInButton)
    }
    
    func setupConstraints(){
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            
            stackViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 12),
            stackViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            stackViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            stackViewContainer.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 20)
        ])
    }
    
    //MARK: - Navigation
    func showMainScreen() {
        
        let mainVC = ScreenFactoryImpl().makeMainScreen()
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
    
//        //Логин - вход в аккаунт
//        func authorizeToFirebase() {
//
//            Auth.auth().signIn(withEmail: "test@test.com", password: "test12345678") { result, error in
//
//                if let error = error {
//
//                    print(error.localizedDescription)
//                    return
//                }
//
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    self.showMainScreen()
//                }
//            }
//        }
    
    //Создание аккаунта
    @objc func registrationToFirebase() {
        
        Auth.auth().createUser(withEmail: "testtest@test.com", password: "12345678") { result, error in
            
            if let error = error {
                
                print(error.localizedDescription)
                return
            }
        }
    }
    
    //Логаут - выход из аккаунта
    func logoutFromFirebase() {
        
        do {
            try Auth.auth().signOut()
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Action
    @objc func showSignInScreen() {
        let signInVC = ScreenFactoryImpl().makeSignInVC()
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
}
