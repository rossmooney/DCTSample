//
//  ViewController.swift
//  dct
//
//  Created by Ross M Mooney on 10/15/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let clearMatrix = dctForImageName("clearDog.jpg")
        let blurMatrix = dctForImageName("blurryDog.jpg")
        
        print("Clear image DCT matrix: \(clearMatrix)")
        print("Blurry image DCT matrix: \(blurMatrix)")
    }
    
    func dctForImageName(name:String) -> Matrix {
        let image = UIImage(named: name)
        let matrix = matrixFromImage(image!)
        let dctMatrix = calculateDCT(matrix, blockSize: 16)
        
        return dctMatrix
    }

}

