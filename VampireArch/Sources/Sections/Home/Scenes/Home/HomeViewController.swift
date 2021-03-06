//
//  HomeViewController.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

final class HomeViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet private var headerLabel: UILabel!
    @IBOutlet private var nextEventView: UIView!
    @IBOutlet private var nextEventHeaderLabel: UILabel!
    @IBOutlet private var nextEventDateLabel: UILabel!
    @IBOutlet private var nextEventNameLabel: UILabel!
    @IBOutlet private var nextEventPriceLabel: UILabel!
    @IBOutlet private var nextEventDetailsButton: UIButton!
    @IBOutlet private var eventListButton: UIButton!
    
    // MARK: Properties
    private let presenter: HomePresenterType
    
    init(presenter: HomePresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup(with: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        style()
        presenter.screenWillAppear()
    }
    
    private func style() {
        nextEventView.isHidden = true
        headerLabel.textColor = .darkGray
        eventListButton.backgroundColor = .black
    }
    
    @IBAction private func eventListButtonTapped(_ sender: Any) {
        presenter.eventListButtonTapped()
    }
    
    @IBAction private func nextEventDetailsButtonTapped(_ sender: Any) {
        presenter.nextEventDetailsButtonTapped()
    }
}

extension HomeViewController: HomeViewControllerType {
    func config(with viewModel: HomeViewModel) {
        title = viewModel.screenTitle
        headerLabel.text = viewModel.header
        eventListButton.setTitle(viewModel.eventListButtonTitle,
                                 for: .normal)
        
        if let nextEvent = viewModel.nextEvent {
            nextEventView.isHidden = false
            nextEventHeaderLabel.text = nextEvent.header
            nextEventDateLabel.text = nextEvent.date
            nextEventNameLabel.text = nextEvent.name
            nextEventPriceLabel.text = nextEvent.price
            nextEventDetailsButton.setTitle(nextEvent.showEventButtonTitle, for: .normal)
        } else {
            nextEventView.isHidden = true
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.rightBarButton,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightBarButtonTapped))
    }
    
    @objc private func rightBarButtonTapped() {
        presenter.rightBarButtonTapped()
    }
    
    func showLoadingState() {
        // Not implemented
    }
    
    func dismissLoadingState() {
        // Not implemented
    }
}
