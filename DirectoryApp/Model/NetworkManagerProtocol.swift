//
//  NetworkProtocols.swift
//  DirectoryApp
//
//  Created by Wajeeh Ul Hassan on 26/08/2022.
//

import Foundation

protocol NetworkManagerProtocol {
    
    func getData<T>(url: String, completion: @escaping (Result<T, NetworkError>) -> Void) where T: Codable
}
