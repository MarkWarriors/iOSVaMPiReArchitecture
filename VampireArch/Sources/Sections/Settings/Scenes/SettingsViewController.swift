//
//  SettingsViewController.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

final class SettingsViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet private var headerLabel: UILabel!
    
    // MARK: Properties
    private let presenter: SettingsPresenterType
    
    init(presenter: SettingsPresenterType) {
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
        presenter.screenWillAppear()
    }
}

extension SettingsViewController: SettingsViewControllerType {
    func config(with viewModel: SettingsViewModel) {
        title = viewModel.screenTitle
        headerLabel.text = viewModel.header
    }
    
}
