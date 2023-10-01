//
//  UITableView+.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 01/10/2023.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(_: T.Type, forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(
            withIdentifier: T.reuseIdentifier,
            for: indexPath
        ) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        return cell
    }

    func reloadData(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0, animations: {
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
}
