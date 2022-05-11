//
//  BookEventViewController.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

final class BookEventViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet private var headerLabel: UILabel!
    @IBOutlet private var bookEventButton: UIButton!
    
    // MARK: Properties
    private let presenter: BookEventPresenterType
    
    init(presenter: BookEventPresenterType) {
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
        // Stubbed
    }
    
    @IBAction private func bookEventButtonTapped(_ sender: Any) {
        // Stubbed
    }
    
}

extension BookEventViewController: BookEventViewControllerType {
    func config(with viewModel: BookEventViewModel) {
        title = viewModel.screenTitle
        headerLabel.text = viewModel.header
        bookEventButton.setTitle(viewModel.bookEventButton, for: .normal)
    }
}
