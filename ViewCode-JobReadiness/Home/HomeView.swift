//
//  HomeViewController.swift
//  ViewCode-JobReadiness
//
//  Created by Luiz Henrique Lage Da Silva on 03/07/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchBarDelegate{
    
    
    let homeController = HomeController()
    
    private let tableView = UITableView()
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addComponents()
       
        tableView.register(ProductCell.self, forCellReuseIdentifier: ProductCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .black
        view.backgroundColor = .white
        
    }
    
    func getOnError() -> () -> Void {
        
        let onError : () -> Void = {
            let alert = UIAlertController(title: "Something went wrong...", message: "Try to search another product",preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { _ in
            }))
            self.present(alert, animated: true, completion: nil)
        }
        return onError
    }
    
    
    
    private func addComponents(){
        configureSearchBar()
        view.addSubview(tableView)
    }
    
    private func configureSearchBar() {
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        searchController.searchBar.isTranslucent = false
        searchController.searchBar.isHidden = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar en Mercado Libre"
        navigationItem.hidesSearchBarWhenScrolling = false
    }
 
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension HomeViewController  {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else{
            return
        }
        homeController.getProducts(product: text, completion: {
            self.tableView.reloadData()
        }, onError: getOnError())
    }
}

extension HomeViewController {
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductCell.identifier, for: indexPath) as? ProductCell else {
            let errorCell = UITableViewCell()
            errorCell.backgroundColor = .blue
            return errorCell
        }
        
        guard let productList = homeController.productList else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.configure(imageName: productList[indexPath.row].body.pictures[0]?.url ?? "",
                       titleLabel: productList[indexPath.row].body.title ?? "",
                       subtitleLabel: "",
                       priceLabel: "R$ \(String(productList[indexPath.row].body.price ?? 0))",
                       prodID: productList[indexPath.row].body.id)

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homeController.productCount
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = homeController.selectProduct(index: indexPath.row)
        
        guard let product = product else {
            return
        }
        
        
        let picture = product.body.pictures.first ?? Picture(url: "")
        
        let price = product.body.price ?? 0
        

        let productDetailView = (DetailViewController(titleA: product.body.title ?? "", image: picture?.url ?? "", price: String(price) ,  description: ""))
        
        navigationController?.pushViewController(productDetailView, animated: true)
        
    }   
    
}
