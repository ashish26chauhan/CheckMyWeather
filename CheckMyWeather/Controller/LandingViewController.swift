//
//  LandingViewController.swift
//  CheckMyWeather
//
//  Created by Ashish Chauhan  on 23/04/2023.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage.gifImageWithName("sunBreath")
        self.moveToHome()
    }
    
    private func moveToHome() {
        DispatchQueue.main.asyncAfter(deadline: .now()+4) {
            let vc = HomeViewController.newInstance
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
//            self.present(vc, animated: true)
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

