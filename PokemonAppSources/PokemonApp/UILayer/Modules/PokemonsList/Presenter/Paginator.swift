//
//  Paginator.swift
//  PokemonApp
//
//  Created by Mikita Laptsionak on 01/10/2023.
//
import Foundation

actor Paginator {
    private var startIndex: Int = 0
    private let batchSize: Int
    private var responseSize: Int = 0
    private var getter: ((Int, Int) async -> Void)?
    private var onStartLoading: (() -> Void)?
    private var onNextLoading: (() -> Void)?
    var firstBatch: Bool = true
    private var isLoading: Bool = false
    private var needNextBatch: Bool {
        if !isLoading && startIndex > 0 && batchSize > 0 {
            return batchSize == responseSize
        } else {
            return firstBatch
        }
    }

    private var dataRetriever: ((Int, Int) async throws -> Void)?
    private var onError: ((Error) -> Void)?

    init(startIndex: Int = 0,
         batchSize: Int = 50,
         getData: ((Int, Int) async -> Void)?,
         onStart: (() -> Void)?,
         onNext: (() -> Void)?,
         onError: ((Error) -> Void)?) {
        self.startIndex = startIndex
        self.batchSize = batchSize
        dataRetriever = getData
        onStartLoading = onStart
        onNextLoading = onNext
        self.onError = onError
    }

    func update(startIndex: Int, responseSize: Int) {
        self.startIndex = startIndex
        self.responseSize = responseSize
        firstBatch = false
        isLoading = false
    }

    func getData() async {
        guard let dataRetriever = dataRetriever, needNextBatch else { return }

        isLoading = true
        if firstBatch {
            onStartLoading?()
        } else {
            onNextLoading?()
        }

        do {
            try await dataRetriever(startIndex, batchSize)
        } catch {
            onError?(error)
        }
    }

    func wasFail() {
        isLoading = false
    }

    func refresh() async {
        guard let dataRetriever = dataRetriever, !isLoading else { return }

        firstBatch = true
        isLoading = true

        do {
            try await dataRetriever(0, batchSize)
        } catch {
            onError?(error)
        }
    }
}
