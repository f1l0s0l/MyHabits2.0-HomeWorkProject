//
//  ProgresHabitCollectionViewCell.swift
//  MyHabits2.0
//
//  Created by Илья Сидорик on 17.01.2023.
//

import UIKit

class ProgresHabitCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.text = "Все получится!"
        return label
    }()
    
    private lazy var countProgress: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .systemGray
        label.text = "0%"
        return label
    }()
    
    private lazy var progresBackView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 3.5
        return view
    }()
    
    private lazy var progresView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 161/225, green: 22/225, blue: 204/225, alpha: 1)
        view.layer.cornerRadius = 3.5
        return view
    }()
    
    private var progresViewWidthAnchor: NSLayoutConstraint?
    
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Public
    
    func animateProgress() {
        let todayProgress = HabitsStore.shared.todayProgress
        let maxProgressWidth = progresBackView.frame.width
        let todayProgressWidth = maxProgressWidth * CGFloat(todayProgress)
        progresViewWidthAnchor?.constant = todayProgressWidth
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
            self.countProgress.text = "\( Int(todayProgress * 100 ))%"
            self.layoutIfNeeded()
       }
   }
    
    func initProgress() {
        let todayProgress = HabitsStore.shared.todayProgress
        let maxProgressWidth = progresBackView.frame.width
        let todayProgressWidth = maxProgressWidth * CGFloat(todayProgress)
        progresViewWidthAnchor?.constant = todayProgressWidth
        self.countProgress.text = "\( Int(todayProgress * 100 ))%"
    }
    
    
    // MARK: - Methods

    private func setupView() {
        self.backgroundColor = .white
        self.addSubview(textLabel)
        self.addSubview(countProgress)
        self.addSubview(progresBackView)
        self.addSubview(progresView)
        self.setupConstraint()
    }
    
    
    // MARK: - Constraints
    
    private func setupConstraint() {
        progresViewWidthAnchor = progresView.widthAnchor.constraint(equalToConstant: 0)
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            textLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),

            countProgress.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            countProgress.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            
            progresBackView.topAnchor.constraint(equalTo: self.textLabel.bottomAnchor, constant: 10),
            progresBackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            progresBackView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -12),
            progresBackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            progresBackView.heightAnchor.constraint(equalToConstant: 7),
            
            progresView.topAnchor.constraint(equalTo: self.textLabel.bottomAnchor, constant: 10),
            progresView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 12),
            progresView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -15),
            progresView.heightAnchor.constraint(equalToConstant: 7),
            progresViewWidthAnchor,
        ].compactMap({ $0 }))
    }

}


