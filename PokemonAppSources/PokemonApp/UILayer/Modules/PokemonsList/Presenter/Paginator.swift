//
//  Paginator.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 01/10/2023.
//

struct Paginator {
    private var startIndex: Int = -1
    private let batchSize: Int
    private var responseSize: Int = 0
    private var getter: ((_ startIndex: Int, _ countItems: Int) -> Void)?
    private var onStartLoading: (() -> Void)?
    private var onNextLoading: (() -> Void)?
    var firstBatch: Bool = true
    private var isLoading: Bool = false
    private var needNextBatch: Bool {
        if !isLoading && startIndex > -1 && batchSize > 0 {
            return batchSize == responseSize
        } else {
            return firstBatch
        }
    }

    init(startIndex: Int = -1, batchSize: Int = 50, getData: ((_ startIndex: Int, _ countItems: Int) -> Void)?, onStart: (() -> Void)?, onNext: (() -> Void)?) {
        self.startIndex = startIndex
        self.batchSize = batchSize
        getter = getData
        onStartLoading = onStart
        onNextLoading = onNext
    }

    mutating func update(startIndex: Int, responseSize: Int) {
        // сообщения приходят в порядке от сегодняшних к вчерашним
        // если пользователь дойдет до конца списка подгрузим более ранние сообщения
        // после очередной загрузки сообщений обновим ид последнего сообщения

        self.startIndex = startIndex
        self.responseSize = responseSize
        firstBatch = false
        isLoading = false
    }

    mutating func getData() {
        if let getter = getter {
            if needNextBatch {
                isLoading = true
                if firstBatch {
                    onStartLoading?()
                } else {
                    onNextLoading?()
                }

                getter(startIndex, batchSize)
            }
        }
    }

    mutating func wasFail() {
        isLoading = false
    }

    mutating func refresh() {
        if let getter = getter {
            if !isLoading {
                firstBatch = true
                isLoading = true
                getter(-1, batchSize)
            }
        }
    }
}
