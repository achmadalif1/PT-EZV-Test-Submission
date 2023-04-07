//
//  MainViewModel.swift
//  PT EZV Test Submission
//
//  Created by Ahmad Nur Alifullah on 07/04/23.
//

import Foundation

final class MainViewModel{
    
    let result: Observable<[Product]?> = Observable(nil)
    let errorMessage: Observable<String?> = Observable(nil)
    let isLoading: Observable<Bool> = Observable(false)
    
  func getProducts(){
    ApiProvider.shared.get(url: baseUrl) { result in
        self.isLoading.value = true
      switch result {
      case .success(let data):
        let decoder = JSONDecoder()
        do {
          let response = try decoder.decode(ProductDataModel.self, from: data)
            self.result.value = response.products
            self.isLoading.value = false
        } catch {
            self.errorMessage.value = error.localizedDescription
            self.isLoading.value = false
        }
      case .failure(let error):
          self.errorMessage.value = error.localizedDescription
          self.isLoading.value = false
      }
    }
  }
    
}
