import Foundation
import Combine


public class APIServiceCombine {
	public static let shared = APIServiceCombine()
	var cancellables = Set<AnyCancellable>()
	public enum APIError: Error {
		case error(_ errorString: String)
	}

	public func getJSON<T: Decodable>(urlString: String,dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys,  completion: @escaping (Result<T, APIError>) -> Void) {

		guard let url = URL(string: urlString) else {
			//			completion(.failure(.error("Error: invalid URL")))
			//SUPORTE PARA VARIAS LINUGAS
			completion(.failure(.error(NSLocalizedString("Error: Invalid URL", comment: "Error: URL Inválida!"))))
			return
		} //end guard let url

		//CRIANDO A REQUISIÇ˜AO ATRAVÉS DA URL
		let request = URLRequest(url: url)
		let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = dateDecodingStrategy
		decoder.keyDecodingStrategy = keyDecodingStrategy
		URLSession.shared.dataTaskPublisher(for: request)
			.map { $0.data}
			.decode(type: T.self, decoder: JSONDecoder())
			.receive(on: RunLoop.main)
			.sink { (taskCompletion) in
				switch taskCompletion {

					case .finished:
						return
					case .failure(let decodingError):
						completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
				}
			} receiveValue: { (decodeData) in
				completion(.success(decodeData))
			}
			.store(in: &cancellables)

//		URLSession.shared.dataTask(with: request) { (data, response, error) in
//			//checar se houve algum error
//			if let error = error {
//				completion(.failure(.error("Error: \(error.localizedDescription)")))
//				return
//			} //end if let error = error
//
//			//verificar se os dados retornados são validos, se deu sucesso ou error
//			guard let data = data else {
//				completion(.failure(.error(NSLocalizedString("Error: Data us corrupt.", comment: "Error: Os Dados estão corrpmpidos"))))
//				return
//			} //end guard let data = data
//
//			//Se não há erros vamos receber alguns dados que vmos decodificar
//			let decoder = JSONDecoder()
//			decoder.dateDecodingStrategy = dateDecodingStrategy
//			decoder.keyDecodingStrategy = keyDecodingStrategy
//			do {
//				//vamos tentar decodificar
//				let decodeData = try decoder.decode(T.self, from: data)
//				//se deu certo vamos chamr o bloco de sucesso
//				completion(.success(decodeData))
//				return
//			} catch let decodingError{
//				completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))
//
//			}
//		} //end URLSession
//		.resume()

	}
}

