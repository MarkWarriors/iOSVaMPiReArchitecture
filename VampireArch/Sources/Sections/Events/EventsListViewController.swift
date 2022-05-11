//
//  EventsListViewController.swift
//  VampireArch
//
//  Created by Marco Guerrieri on 11/05/2022.
//

import UIKit

final class EventsListViewController: UIViewController {
    // MARK: IBOutlets
    @IBOutlet private var eventsTableView: UITableView!
    @IBOutlet private var loadingActivityIndicator: UIActivityIndicatorView!
    private let refreshControl = UIRefreshControl()
    
    // MARK: Properties
    private var eventsShown = [EventListTableViewCellConfig]()
    
    private let presenter: EventsListPresenterType
    
    init(presenter: EventsListPresenterType) {
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
        configureTableView()
        presenter.screenWillAppear()
    }
    
    private func style() {
        loadingActivityIndicator.isHidden = true
        eventsTableView.tableFooterView = UIView()
    }
    
    private func configureTableView() {
        eventsTableView.register(UINib(nibName: EventListTableViewCell.identifier, bundle: nil),
                                 forCellReuseIdentifier: EventListTableViewCell.identifier)
        eventsTableView.delegate = self
        eventsTableView.dataSource = self
        eventsTableView.rowHeight = UITableView.automaticDimension
        eventsTableView.refreshControl = refreshControl
        refreshControl.addTarget(self,
                                 action: #selector(pulledToRefresh),
                                 for: .valueChanged)
    }
    
    @objc private func pulledToRefresh() {
        presenter.pullToRefreshTriggered()
    }
}

extension EventsListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int { 1 }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { eventsShown.count }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EventListTableViewCell.identifier,
                                                       for: indexPath) as? EventListTableViewCell else {
            assertionFailure("No table cell EventListTableViewCell found")
            return UITableViewCell()
        }
        
        let cellConfig = eventsShown[indexPath.row]
        cell.configure(with: cellConfig)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.setSelected(false, animated: true)
        }
        
        let eventId = eventsShown[indexPath.row].id
        presenter.eventSelected(eventId: eventId)
    }
}

extension EventsListViewController: EventsListViewControllerType {
    func config(with viewModel: EventsListViewModel) {
        title = viewModel.screenTitle
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: viewModel.rightBarButton,
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(rightBarButtonTapped))
    }
    
    func showEventsInList(events: [EventListTableViewCellConfig]) {
        eventsShown = events
        eventsTableView.reloadData()
    }
    
    func showLoadingState() {
        loadingActivityIndicator.isHidden = false
    }
    
    func dismissLoadingState() {
        loadingActivityIndicator.isHidden = true
    }
    
    @objc private func rightBarButtonTapped() {
        presenter.rightBarButtonTapped()
    }
    
}
