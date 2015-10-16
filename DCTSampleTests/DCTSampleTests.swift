//
//  dctTests.swift
//  dctTests
//
//  Created by Ross M Mooney on 10/15/15.
//

import XCTest
import DCTSample

class DCTSampleTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test8x8() {
        
        let testBlock = Matrix([[255.0, 0.0, 255.0, 0.0, 255.0, 0.0, 255.0, 0.0],
            [0.0, 255.0, 0.0, 255.0, 0.0, 255.0, 0.0, 255.0],
            [255.0, 0.0, 255.0, 0.0, 255.0, 0.0, 255.0, 0.0],
            [0.0, 255.0, 0.0, 255.0, 0.0, 255.0, 0.0, 255.0],
            [255.0, 0.0, 255.0, 0.0, 255.0, 0.0, 255.0, 0.0],
            [0.0, 255.0, 0.0, 255.0, 0.0, 255.0, 0.0, 255.0],
            [255.0, 0.0, 255.0, 0.0, 255.0, 0.0, 255.0, 0.0],
            [0.0, 255.0, 0.0, 255.0, 0.0, 255.0, 0.0, 255.0]])
        
        let dctMatrix = calculateDCT(testBlock, blockSize: 8)
        let inverseDctMatrix = calculateInverseDCT(dctMatrix, blockSize: 8)
        
        
        print(dctMatrix)
        print("     ")
        print(inverseDctMatrix)
        
        //Inverse DCT matrix must be rounded to 1 decimal place in order to compare
        XCTAssertEqual(testBlock, roundMatrix(inverseDctMatrix))
    }
    
    func roundMatrix(matrix: Matrix) -> Matrix {
        var roundedMatrix = Matrix(rows: matrix.rows, cols: matrix.cols)
        
        for x in 0..<matrix.cols {
            for y in 0..<matrix.rows {
                roundedMatrix[x, y] = Double(round(matrix[x, y] * 10)/10)
            }
        }
        return roundedMatrix
    }
}
