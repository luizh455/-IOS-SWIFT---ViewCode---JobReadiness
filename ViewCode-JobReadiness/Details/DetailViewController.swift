//
//  DetailViewController.swift
//  ViewCode-JobReadiness
//
//  Created by Luiz Henrique Lage Da Silva on 05/07/22.
//

import UIKit

class DetailViewController: UIViewController, UINavigationBarDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var titleProd : String
    var imageProd : String
    var priceProd : String
    var descriptionProd : String
    
    @IBAction func onPressBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    init(titleA : String, image : String, price : String, description : String){
        titleProd = titleA
        imageProd = image
        priceProd = price
        descriptionProd = description
        super.init(nibName: nil, bundle: nil)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = titleProd
        priceLabel.text = priceProd
        descriptionLabel.text = descriptionProd
        let url = URL(string: imageProd) ?? URL(fileURLWithPath: "")
        loadImage(url: url)
        navigationController?.navigationBar.backgroundColor = .yellow

        // Do any additional setup after loading the view.
    }
    
    func loadImage(url: URL) {
            DispatchQueue.main.async { [weak self] in
                if let data = try? Data(contentsOf: url) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.productImage.image = image
                        }
                    }
                }
            }
        }


}
