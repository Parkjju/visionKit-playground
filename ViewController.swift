//
//  ViewController.swift
//  visionKit-playground
//
//  Created by Jun on 2023/02/22.
//

import UIKit
import VisionKit

class ViewController: UIViewController {
    
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var imageVIew: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


extension ViewController: VNDocumentCameraViewControllerDelegate{
    
}
