//
//  PokemonDetailViewController.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 03/10/2023.
//  Copyright © 2023 Innowise Group. All rights reserved.
//

import UIKit

class PokemonDetailViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let containerView = UIView()
    
    private let headerView = PokemonDetailHeaderView()

    var output: PokemonDetailViewOutput?

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupTransparentNavigationBar()

        Task {
            await output?.viewIsReady()
        }
    }
    
    override func viewDidLayoutSubviews() {
        scrollView.contentSize.height = headerView.frame.height
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        resetNavigationBar()
    }
}

private extension PokemonDetailViewController {
    func setupViews() {
        scrollView.delegate = self
        view.backgroundColor = .systemBackground
        view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(headerView)
    }
    
    func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
        
        containerView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView)
            make.width.equalTo(self.scrollView)
            make.height.equalTo(self.scrollView)
        }
        
        headerView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(-270)
            make.left.right.bottom.equalToSuperview()
        }
        
        view.layoutIfNeeded()
    }
    
    func setupTransparentNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.clear]
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }

    func resetNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.tintColor = nil
        navigationController?.navigationBar.titleTextAttributes = nil
    }
}

// MARK: - PokemonDetailViewInput
extension PokemonDetailViewController: PokemonDetailViewInput {
    func setupNavigationBar(title: String) {
        navigationController?.title = title
    }
    
    func configureViewWith(model: CompletePokemonInfo, imageDelegate: ImageDownloaderDelegate) {
        headerView.configureWith(model: model, delegate: imageDelegate)
    }
}

// MARK: - ScrollViewDelegate
extension PokemonDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yOffset = scrollView.contentOffset.y
        
        let minCircleHeight: CGFloat = 50.0
        let maxCircleHeight: CGFloat = 300.0

        var newHeight: CGFloat = maxCircleHeight

        let resizeSpeedCoefficient: CGFloat = 5.0 // Увеличиваем резкость изменения размера

        if yOffset < 0 {
            // Скроллим вверх: уменьшаем круг
            newHeight = min(minCircleHeight, maxCircleHeight + (yOffset * resizeSpeedCoefficient))
        } else if yOffset > 0 {
            // Скроллим вниз: увеличиваем круг
            newHeight = max(maxCircleHeight, maxCircleHeight + (yOffset * resizeSpeedCoefficient))
        }
        
        let lowerBound = min(newHeight, maxCircleHeight)
        let upperBound = max(newHeight, maxCircleHeight)
        
        headerView.handleScrollWith(range: lowerBound...upperBound)
    }
}
