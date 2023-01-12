import Combine

extension Future where Failure == Error {
    convenience init(operation: @escaping () async throws -> Output) {
        self.init { promise in
            Task {
                do {
                    let output = try await operation()
                    promise(.success(output))
                } catch {
                    promise(.failure(error))
                }
            }
        }
    }
}

extension Publisher {
    func sinkResult(receiveResult: @escaping ((Result<Self.Output, Self.Failure>) -> Void)) -> AnyCancellable {
        sink(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                receiveResult(.failure(error))
            }
        }, receiveValue: { output in
            receiveResult(.success(output))
        })
    }
}
