//
//  ScanResultViewController.swift
//  visionKit-playground
//
//  Created by 박경준 on 2023/02/22.
//

import UIKit
import VisionKit
import Vision

class ScanResultViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    
    var imageData: [UIImage] = []{
        didSet{
            startOCR()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func startOCR(){
        guard let image = imageData.first else {
            return
        }
        
        guard let cgImage = image.cgImage else {
            return
        }
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        let request = VNRecognizeTextRequest{ [weak self]request, error in
            
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else{
                return
            }
            
            
            
            // 한 줄이 끝나는 부분마다 \n
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: "\n")
            
            print(text)
            
//            // ui 변경은 main thread에서만 가능
            DispatchQueue.main.async {
                self?.resultLabel.text = text
                print(text)
            }
        }
        
        if #available(iOS 16.0, *) {
            let revision3 = VNRecognizeTextRequestRevision3
            request.revision = revision3
            request.recognitionLevel = .accurate
            request.recognitionLanguages =  ["ko-KR"]
            request.usesLanguageCorrection = true

            do {
                var possibleLanguages: Array<String> = []
                possibleLanguages = try request.supportedRecognitionLanguages()
                print(possibleLanguages)
            } catch {
                print("Error getting the supported languages.")
            }
        } else {
            // Fallback on earlier versions
            request.recognitionLanguages =  ["en-US"]
            request.usesLanguageCorrection = true
        }
        
        do{
            try handler.perform([request])
        } catch {
            // 에러 처리
            self.resultLabel.text = "\(error)"
            print(error)
        }
        
        
        
        
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
