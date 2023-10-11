//
//  PokemonsListViewController.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 30/09/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

class PokemonsListViewController: UIViewController {
    private let cellType = PokemonTableListCell.self
    private var isLoadingMode = false
    private var lastIndexPath: IndexPath?
    var output: PokemonsListViewOutput?

    // MARK: - UI Init

    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PokemonsListViewController.refresh), for: UIControl.Event.valueChanged)
        refreshControl.tintColor = .clear
        refreshControl.backgroundColor = .clear

        return refreshControl
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            self.cellType,
            forCellReuseIdentifier: PokemonTableListCell.reuseIdentifier
        )
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addSubview(self.refreshControl)
        tableView.tableFooterView = self.footerLoader
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none

        return tableView
    }()

    private lazy var headerLoader: UIView = {
        let view = UIView()
        view.frame = self.refreshControl.bounds
        view.backgroundColor = .clear
        return view
    }()

    private lazy var footerLoader: UIView = {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 74))
        view.backgroundColor = .clear
        return view
    }()

    // MARK: Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupConstraints()
        Task {
            await output?.viewIsReady()
        }
    }
}

private extension PokemonsListViewController {
    @objc func refresh() {
        headerLoader.frame = refreshControl.bounds
        self.headerLoader.showRotationLoader(constantY: 0, needWhiteBackground: false)
        output?.refresh()
    }

    func setupConstraints() {
        view.addSubview(tableView)
        refreshControl.addSubview(headerLoader)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - PokemonsListViewInput

extension PokemonsListViewController: PokemonsListViewInput {
    func reload() {
        hideRefreshControl()
        tableView.reloadData()
    }
    
    func displayFooterLoader() {
        tableView.tableFooterView?.isHidden = false
        self.footerLoader.showRotationLoader(constantY: 0)
    }

    func hideFooterLoader() {
        self.footerLoader.hideRotationLoader()
        tableView.tableFooterView?.isHidden = true
    }

    func hideRefreshControl() {
        refreshControl.endRefreshing()
        self.headerLoader.hideRotationLoader()
    }

    func selectRowAt(_ indexPath: IndexPath) {
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    }

    func reloadRow(indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: UITableView.RowAnimation.none)
    }

    func deleteRow(indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.left)
    }

    func displayError(title _: String, message _: String, reloadBlock _: (() -> Void)?) {}

    func setupNavigationBar(title: String) {
        navigationController?.title = title
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension PokemonsListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        if isLoadingMode {
            return 1
        } else {
            return output?.getNumberOfRows() ?? 0
        }
    }

    func tableView(_: UITableView, heightForRowAt _: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isLoadingMode {
            if let cell = tableView.dequeueReusableCell(withIdentifier: PokemonTableListCell.reuseIdentifier, for: indexPath) as? PokemonTableListCell {
                return cell
            } else {
                return UITableViewCell()
            }
        } else {
            if let cell: PokemonTableListCell = tableView.dequeueReusableCell(withIdentifier: PokemonTableListCell.reuseIdentifier) as? PokemonTableListCell {
                cell.configure(with: output?.getCellModelForRow(at: indexPath))
                lastIndexPath = indexPath
                return cell
            } else {
                return UITableViewCell()
            }
        }
    }

    func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        output?.didSelectRow(indexPath: indexPath)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffset = maximumOffset - currentOffset

        if deltaOffset <= 0 {
            if let ip = lastIndexPath {
                Task {
                    await output?.endOfPage(indexPath: ip)
                }
            }
        }
    }
}
