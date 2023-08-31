import Foundation

public class APIService {
	public static let shared = APIService()

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
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			//checar se houve algum error
			if let error = error {
				completion(.failure(.error("Error: \(error.localizedDescription)")))
				return
			} //end if let error = error

			//verificar se os dados retornados são validos, se deu sucesso ou error
			guard let data = data else {
				completion(.failure(.error(NSLocalizedString("Error: Data us corrupt.", comment: "Error: Os Dados estão corrpmpidos"))))
				return
			} //end guard let data = data

			//Se não há erros vamos receber alguns dados que vmos decodificar
			let decoder = JSONDecoder()
			decoder.dateDecodingStrategy = dateDecodingStrategy
			decoder.keyDecodingStrategy = keyDecodingStrategy
			do {
				//vamos tentar decodificar
				let decodeData = try decoder.decode(T.self, from: data)
				//se deu certo vamos chamr o bloco de sucesso
				completion(.success(decodeData))
				return
			} catch let decodingError{
				completion(.failure(APIError.error("Error: \(decodingError.localizedDescription)")))

			}
		} //end URLSession
		.resume()

	}
}
