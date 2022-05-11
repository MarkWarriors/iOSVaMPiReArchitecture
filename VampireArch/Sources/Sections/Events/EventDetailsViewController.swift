//
//  EventDetailsViewController.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

final class EventDetailsViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet private var idLabel: UILabel!
    @IBOutlet private var dateLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var priceLabel: UILabel!
    @IBOutlet private var bookedLabel: UILabel!
    @IBOutlet private var bookEventButton: UIButton!
    
    // MARK: Properties
    private let presenter: EventDetailsPresenterType
    
    init(presenter: EventDetailsPresenterType) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup(with: self)
        style()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.screenWillAppear()
    }
    
    private func style() {
        // TODO: it's an example
    }
    
    @IBAction private func bookEventButtonTapped(_ sender: Any) {
        presenter.bookEventTapped()
    }
}

extension EventDetailsViewController: EventDetailsViewControllerType {
    func config(with viewModel: EventDetailsViewModel) {
        title = viewModel.screenTitle
        
        if let eventInfo = viewModel.eventInfo {
            idLabel.text = eventInfo.id
            dateLabel.text = eventInfo.date
            nameLabel.text = eventInfo.name
            priceLabel.text = eventInfo.price
            bookedLabel.text = eventInfo.booked
        }
        
        if let bookButton = viewModel.bookEventButton {
            bookEventButton.isHidden = false
            bookEventButton.setTitle(bookButton, for: .normal)
        } else {
            bookEventButton.isHidden = true
        }
    }
    
    func showLoadingState() {
        // TODO: it's an example
    }
    
    func dismissLoadingState() {
        // TODO: it's an example
    }
}
