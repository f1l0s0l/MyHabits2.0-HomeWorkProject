//
//  InfoViewController.swift
//  MyHabits2.0
//
//  Created by Илья Сидорик on 17.01.2023.
//

import UIKit

class InfoViewController: UIViewController {

    // MARK: - Properties

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var headerTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Привычка за 21 день"
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    private lazy var labelTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = """
        Прохождение этапов, за которые за 21 день вырабатывается привычка, подчиняется следующему алгоритму:
        """
        return label
    }()
    
    private lazy var text1Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = """
        1. Провести 1 день без обращения к старым привычкам, стараться вести себя так, как будто цель, загаданная в перспективу, находится на расстоянии шага.
        """
        return label
    }()
    
    private lazy var text2Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = """
        2. Выдержать 2 дня в прежнем состоянии самоконтроля.
        """
        return label
    }()
    
    private lazy var text3Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = """
        3. Отметить в дневнике первую неделю изменений и подвести первые итоги — что оказалось тяжело, что — легче, с чем еще предстоит серьезно бороться.
        """
        return label
    }()
    
    private lazy var text4Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = """
        4. Поздравить себя с прохождением первого серьезного порога в 21 день.
        За это время отказ от дурных наклонностей уже примет форму осознанного преодоления и человек сможет больше работать в сторону принятия положительных качеств.
        """
        return label
    }()
    
    private lazy var text5Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = """
        5. Держать планку 40 дней. Практикующий методику уже чувствует себя освободившимся от прошлого негатива и двигается в нужном направлении с хорошей динамикой.
        """
        return label
    }()
    
    private lazy var text6Label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = """
        6. На 90-й день соблюдения техники все лишнее из «прошлой жизни» перестает напоминать о себе, и человек, оглянувшись назад, осознает себя полностью обновившимся.
        """
        return label
    }()
    
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
    }
    
    
    // MARK: - Methods

    private func setupView() {
        self.title = "Информация"
        self.view.backgroundColor = .systemGray6
        self.setupAddSubviews()
        self.setupConstraints()
    }
    
    private func setupAddSubviews() {
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(headerTextLabel)
        self.scrollView.addSubview(stackView)
        self.stackView.addArrangedSubview(labelTextLabel)
        self.stackView.addArrangedSubview(text1Label)
        self.stackView.addArrangedSubview(text2Label)
        self.stackView.addArrangedSubview(text3Label)
        self.stackView.addArrangedSubview(text4Label)
        self.stackView.addArrangedSubview(text5Label)
        self.stackView.addArrangedSubview(text6Label)
    }
    
    
    // MARK: - Constraints

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            headerTextLabel.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 22),
            headerTextLabel.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            headerTextLabel.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 16),

            stackView.topAnchor.constraint(equalTo: self.headerTextLabel.bottomAnchor, constant: 16),
            stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
        ])
    }
   
}
