//
//  HabitsViewController.swift
//  MyHabits2.0
//
//  Created by Илья Сидорик on 17.01.2023.
//

import UIKit

class HabitsViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = CGSize(width: UIScreen.main.bounds.width - 32, height: 200)
        layout.minimumLineSpacing = 12
        return layout
    }()
    
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: self.layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HabitCollectionViewCell.self, forCellWithReuseIdentifier: "HabitCollectionViewCellID")
        collectionView.register(ProgresHabitCollectionViewCell.self, forCellWithReuseIdentifier: "ProgresHabitCollectionViewCellID")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .systemGray5
        return collectionView
    }()
    
    
    // MARK: - Life cycle
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animatedProgressProgresHabitCollectionViewCell()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Сегодня"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationItem.title = nil
    }
    
    // MARK: - Methods

    private func setupView() {
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(collectionView)
        self.setupNavigationBar()
        self.setupConstraints()
    }
    

    private func setupNavigationBar() {
        let addHabitsBarButtonItem: UIBarButtonItem = {
            let button = UIButton(type: .system)
            button.setImage(UIImage(systemName: "plus"), for: .normal)
            button.tintColor = UIColor(red: 161/225, green: 22/225, blue: 204/225, alpha: 1)
            button.imageView?.contentMode = .scaleAspectFill
            button.contentVerticalAlignment = .fill
            button.contentHorizontalAlignment = .fill
            button.addTarget(self, action: #selector(presentHabitViewController), for: .touchUpInside)
            let addHabitsBarItem = UIBarButtonItem(customView: button)
            return addHabitsBarItem
        }()
        self.navigationItem.rightBarButtonItem = addHabitsBarButtonItem
        self.navigationItem.backButtonTitle = "Сегодня"
    }
    
    @objc
    private func presentHabitViewController() {
        let habitViewController = HabitViewController()
        habitViewController.setupTitle(with: "Создать")
        habitViewController.delegateSaveNewHabit = self
        let vc = UINavigationController(rootViewController: habitViewController)
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    private func animatedProgressProgresHabitCollectionViewCell() {
        if let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 0)) as? ProgresHabitCollectionViewCell {
            cell.animateProgress()
        }
    }
    
    
    // MARK: - Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}


    // MARK: - ExtensionUICollectionViewDataSource

extension HabitsViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return HabitsStore.shared.habits.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgresHabitCollectionViewCellID", for: indexPath) as? ProgresHabitCollectionViewCell else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                    return cell
            }
            
            cell.layer.cornerRadius = 8
            cell.initProgress()
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HabitCollectionViewCellID", for: indexPath) as? HabitCollectionViewCell else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                return cell
            }
            
            cell.setup(habit: HabitsStore.shared.habits[indexPath.item], indexInArray: indexPath.item)
            cell.delegateSaveChangeTrackHabit = self
            cell.layer.cornerRadius = 8
            return cell
        }
    }
    
}


    // MARK: - ExtensionUICollectionViewDelegateFlowLayout

extension HabitsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 22, left: 16, bottom: 18, right: 16)
        }
        
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section != 0 {
            let habitDetailsViewController = HabitDetailsViewController()
            habitDetailsViewController.setup(habit: HabitsStore.shared.habits[indexPath.item], indexInArrayHabits: indexPath.item)
            habitDetailsViewController.delegateSaveChangeHabit = self
            habitDetailsViewController.delegateRemoveHabit = self
            navigationController?.pushViewController(habitDetailsViewController, animated: true)
        }
    }
   
}

// MARK: - ExtensionSaveNewHabit

extension HabitsViewController: HabitViewControllerSaveNewHabit {
    
    func saveNewHabit(habit: Habit) {
        HabitsStore.shared.habits.insert(habit, at: 0)
        collectionView.insertItems(at: [IndexPath(item: 0, section: 1)])
        self.animatedProgressProgresHabitCollectionViewCell()
    }
}

// MARK: - ExtensionSaveChangeHabit

extension HabitsViewController: HabitViewControllerSaveChangeHabit {
    
    func saveChangeHabit(habit: Habit, indexInArrayHabits: Int) {
        HabitsStore.shared.habits[indexInArrayHabits].name = habit.name
        HabitsStore.shared.habits[indexInArrayHabits].color = habit.color
        HabitsStore.shared.habits[indexInArrayHabits].date = habit.date
        collectionView.reloadItems(at: [IndexPath(item: indexInArrayHabits, section: 1)])
    }
}

// MARK: - ExtensionRemoveHabit

extension HabitsViewController: HabitViewControllerRemoveHabit {
    
    func removeHabit(habit: Habit, indexInArrayHabits: Int) {
        HabitsStore.shared.habits.removeAll(where: {$0 == habit})
        collectionView.deleteItems(at: [IndexPath(item: indexInArrayHabits, section: 1)])
        self.animatedProgressProgresHabitCollectionViewCell()
    }
}

// MARK: - ExtensionSaveChabgeTrackHabit

extension HabitsViewController: HabitCollectionViewCellSaveChabgeTrackHabit {
    
    func saveChangeTrackHabit(habit: Habit, indexInArrayHabits: Int) {
        HabitsStore.shared.track(habit)
        if let cell = collectionView.cellForItem(at: IndexPath(item: indexInArrayHabits, section: 1)) as? HabitCollectionViewCell {
            cell.setupIsAlreadyTakenToday()
        }
        self.animatedProgressProgresHabitCollectionViewCell()
    }
    
}
