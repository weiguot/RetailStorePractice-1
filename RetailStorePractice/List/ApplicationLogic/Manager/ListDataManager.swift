//
//  ListDataManager.swift
//  RetailStorePractice
//
//  Created by Field Employee on 3/1/21.
//

import Foundation


class ListDataManager {
    var coreDataStore = RetailStorePractice.sharedInstance
    var productsArray = [Product]()
    
    init() {
        if let products = readProductsFromPlist() {
            productsArray = products
        }
    }
    //MARK: Products Fetcher Methods
    func readProductsFromPlist() -> [Product]? {
        if let fileUrl = Bundle.main.url(forResource: "Products", withExtension: "plist"),
           let data = try? Data(contentsOf: fileUrl) {
            if let result = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any] {
                if let dict = result, let array = (dict["Products"] as? [Any]) {
                    let productsArray = products(from: array)
                    // print(productsArray.count)
                    return productsArray
                }
            }
        }
        return nil
    }
    
    func products(from array: [Any]) -> [Product] {
        var productsArray = [Product]()
        for value in array {
            if let dict = value as? [String : Any] {
                var newProduct = Product()
                newProduct.productId = (dict["productId"] as! NSNumber)
                newProduct.name = (dict["name"] as! String)
                newProduct.categoryId = (dict["categoryId"] as! NSNumber)
                newProduct.price = (dict["price"] as! NSNumber)
                newProduct.imageName = (dict["imageName"] as! String)
                productsArray.append(newProduct)
            }
        }
        return productsArray
    }
    
}
