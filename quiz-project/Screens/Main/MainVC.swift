//
//  MainVC.swift
//  quiz-project
//
//  Created by Daria Sechko on 19.10.22.
//

import UIKit

enum CategorySectionType: Int, CaseIterable {
    case gameMode //GameModeCell
    case category //CategoryCell
    case startButton //StartGameButtonCell
}

final class MainVC: UIViewController {
    
    var questionProvider = QuestionsProviderImpl.shared
    
    var categories: [Category] = []
    
    var currentCategory: Category?
    
    var zeroView = ZeroView.init(jsonName: "question-animation")
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.register(GameModeCell.self, forCellReuseIdentifier: GameModeCell.reuseId)
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.reuseId)
        tableView.register(StartGameButtonCell.self, forCellReuseIdentifier: StartGameButtonCell.reuseId)
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        zeroView.show()

        setupViews()
        setupConstraints()
        
        questionProvider.fetchAllQuestions {
        
            self.categories = self.questionProvider.fetchAllCategories()
            self.tableView.reloadData()
            
            self.zeroView.hide()
        }
    }
        
    // MARK: - Private
    
    private func setupViews() {
        view.addSubview(tableView)
        navigationItem.hidesBackButton = true
        view.addSubview(zeroView)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        zeroView.pinEdgesToSuperView()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.zeroView.hide()
        }
    }
    
    // MARK: - Navigation
    
    func showStandardGameScreen() {
        let gameVC = ScreenFactoryImpl().makeStandardGameScreen()
        self.navigationController?.pushViewController(gameVC, animated: true)
    }
}

extension MainVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return CategorySectionType.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cellType = CategorySectionType.init(rawValue: indexPath.section) {
            
            switch cellType {
            case .gameMode:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: GameModeCell.reuseId, for: indexPath) as? GameModeCell else { return UITableViewCell() }
                
                return cell
                
            case .category:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reuseId, for: indexPath) as? CategoryCell else { return UITableViewCell() }
                
                cell.delegate = self
                cell.configure(categories)
        
                return cell
                
            case .startButton:
                
                guard let cell = tableView.dequeueReusableCell(withIdentifier: StartGameButtonCell.reuseId, for: indexPath) as? StartGameButtonCell else { return UITableViewCell() }
                
                cell.delegate = self
                cell.configure(currentCategory)
        
                return cell
            }
        }
        return UITableViewCell()
    }
}

extension MainVC: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel?.font = UIFont.init(name: "Avenir Next Bold", size: 20)
            header.textLabel?.textColor = .black
            header.textLabel?.numberOfLines = 0
            header.textLabel?.textAlignment = .center
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let sectionType = CategorySectionType(rawValue: section) {
            switch sectionType {
            case .gameMode:
                return "Режим игры"
            case .category:
                return "Категории"
            case .startButton:
                return ""
            }
        }
        return ""
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return CGFloat(100)
    }
}

extension MainVC: StartGameButtonCellOutput {
    
    func startGameButtonCellDidSelect() {
        showStandardGameScreen()
    }
}

extension MainVC: CategoryCellOutput {
    
    func categoryCellDidSelect(_ category: Category) {
        
        currentCategory = category
        
        for item in categories {
            if item.name == category.name {
                item.selected = true
            } else {
                item.selected = false
            }
        }
   
        questionProvider.fetchQuestion(by: category) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}
