//
//  ViewController.swift
//  visionKit-playground
//
//  Created by Jun on 2023/02/22.
//

import UIKit
import VisionKit
import Vision

class ViewController: UIViewController {
    
    @IBOutlet weak var scanButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var images: Array<Any> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        images = []
        visionKit()
        
    }
    
    func visionKit(){
        let scan = VNDocumentCameraViewController()
        scan.delegate = self
        self.present(scan, animated: true)
    }
    
}


extension ViewController: VNDocumentCameraViewControllerDelegate{
    func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
        for pageNumber in 0 ..< scan.pageCount{
            let image = scan.imageOfPage(at: pageNumber)
            images.append(image)
        }
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        imageView.image = (images[0] as! UIImage)
        
        controller.dismiss(animated: true)
    }
}
