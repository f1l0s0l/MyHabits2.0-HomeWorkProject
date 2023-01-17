//
//  HabitCollectionViewCell.swift
//  MyHabits2.0
//
//  Created by Илья Сидорик on 17.01.2023.
//

import UIKit


protocol HabitCollectionViewCellSaveChabgeTrackHabit: AnyObject {
    func saveChangeTrackHabit(habit: Habit, indexInArrayHabits: Int)
}


class HabitCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties

    weak var delegateSaveChangeTrackHabit: HabitCollectionViewCellSaveChabgeTrackHabit?

    private var thisHabit = Habit(name: "", date: Date.now, color: .white)
    private var thisHabitIndex = 0
    
    private lazy var nameHabitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Название привычки"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var timeHabitLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray2
        label.text = "Каждый день в 7:00 утра"
        return label
    }()
    
    private lazy var countTrackHabit: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.text = "Счетчик 0"
        return label
    }()
    
    private lazy var isDoneHabitButton: UIButton = {
        let imageView = UIButton()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 19
        imageView.backgroundColor = .white
        imageView.tintColor = .white
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 2
        imageView.addTarget(self, action: #selector(didPabIsDoneHabitButton), for: .touchUpInside)
        return imageView
    }()
    
    @objc
    private func didPabIsDoneHabitButton() {
        if thisHabit.isAlreadyTakenToday == false {
            delegateSaveChangeTrackHabit?.saveChangeTrackHabit(habit: thisHabit,
                                                               indexInArrayHabits: thisHabitIndex
            )
        }
    }
    
    private lazy var checkmarkInButtonView: UIImageView = {
        let image = UIImage(systemName: "checkmark")
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = .white
        imageView.image = image
        return imageView
    }()
    
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
  
    // MARK: - Public
    
    func setup(habit: Habit, indexInArray: Int) {
        thisHabit = habit
        thisHabitIndex = indexInArray
        
        nameHabitLabel.text = thisHabit.name
        nameHabitLabel.textColor = thisHabit.color
        timeHabitLabel.text = thisHabit.dateString
        isDoneHabitButton.layer.borderColor = thisHabit.color.cgColor
        countTrackHabit.text = "Счетчик \(thisHabit.trackDates.count)"
        
        setupIsAlreadyTakenToday()
    }
    
    func setupIsAlreadyTakenToday() {
        if thisHabit.isAlreadyTakenToday {
            isDoneHabitButton.backgroundColor = thisHabit.color
        } else {
            isDoneHabitButton.backgroundColor = .none
        }
    }
    
    
    // MARK: - Methods

    private func setupView() {
        self.backgroundColor = .white
        self.addSubview(nameHabitLabel)
        self.addSubview(timeHabitLabel)
        self.addSubview(countTrackHabit)
        self.addSubview(isDoneHabitButton)
        self.addSubview(checkmarkInButtonView)
        self.setupConstraint()
    }
    
    
    // MARK: - Constraints
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.nameHabitLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            self.nameHabitLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.nameHabitLabel.widthAnchor.constraint(equalToConstant: 220),
            
            self.timeHabitLabel.topAnchor.constraint(equalTo: self.nameHabitLabel.bottomAnchor, constant: 4),
            self.timeHabitLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.timeHabitLabel.widthAnchor.constraint(equalTo: self.nameHabitLabel.widthAnchor),
            
            self.countTrackHabit.topAnchor.constraint(equalTo: self.timeHabitLabel.bottomAnchor, constant: 30),
            self.countTrackHabit.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            self.countTrackHabit.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            
            self.isDoneHabitButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.isDoneHabitButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25),
            self.isDoneHabitButton.widthAnchor.constraint(equalToConstant: 38),
            self.isDoneHabitButton.heightAnchor.constraint(equalToConstant: 38),
            
            self.checkmarkInButtonView.centerXAnchor.constraint(equalTo: self.isDoneHabitButton.centerXAnchor),
            self.checkmarkInButtonView.centerYAnchor.constraint(equalTo: self.isDoneHabitButton.centerYAnchor),
            self.checkmarkInButtonView.widthAnchor.constraint(equalToConstant: 20),
            self.checkmarkInButtonView.heightAnchor.constraint(equalToConstant: 20),

        ])
    }
    
}
