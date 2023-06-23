//
//  RestService.swift
//  EarthQuakeiOSApp
//
//  Created by dedeepya reddy salla on 23/06/23.
//

import Foundation
import Combine

enum APIError: Error {
    case urlError(errInfo: String)
    case APIFailed
}

protocol ServiceInput {
    associatedtype DataModel: Decodable
    var urlStr: String {get}
}

class RestService {
    static func getAPICall<T: ServiceInput>(service: T) -> AnyPublisher<T.DataModel, Error> {
        guard let url = URL(string: service.urlStr) else {
            return Fail(error: APIError.urlError(errInfo: "URL is not working")).eraseToAnyPublisher()
        }
        
        /*
         err:
         Thrown expression type 'Fail<Output, APIError>' does not conform to 'Error'
         code:
         throw Fail(error: APIError.urlError(errInfo: "status code is not equal to 200"))
         
         Fix: APIError.urlError(errInfo: "status code is not equal to 200")
         it is saying I am expecting only error but you are returning Fail<Output, APIError>
         
         How does it know it is Fail<Output, APIError> --> we created Fail struct instance - compiler learns it that it is 'Fail' type. But how does it know it has generics <Output, APIError> - it learns error type is APIError by looking at error parameter.
         and Fail struct structure has other generic 'Output' in its declaration itself. so thats how it knows
         But remember fail(err:) type is not same as Error --
         fail(err:) - its type is Fail
         APIError.urlError - its type is APIError - which confirms to Error - that is why compiler accpets
         */
        let pub = URLSession.shared.dataTaskPublisher(for: url)
        let mappedDataFromNetwork = pub.tryMap { (data, urlResponse) in
            guard let resp = urlResponse as? HTTPURLResponse, resp.statusCode == 200 else {
                throw APIError.urlError(errInfo: "status code is not equal to 200")
            }
            return data
        }
        
        return mappedDataFromNetwork.decode(type: T.DataModel.self, decoder: JSONDecoder()).receive(on: DispatchQueue.main).eraseToAnyPublisher()
    }
}
