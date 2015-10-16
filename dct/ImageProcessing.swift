//
//  ImageProcessing.swift
//  dct
//
//  Created by Ross M Mooney on 10/15/15.
//

import Foundation
import UIKit

//Constants
let π = M_PI

public func matrixFromImage(inputImage: UIImage) -> Matrix {
    
    let image = inputImage.CGImage
    
    
    let width = CGImageGetWidth(image)
    let height = CGImageGetHeight(image)
    
    var matrix = Matrix(rows: width, cols: height)
    let bytesPerRow = (4 * width)
    let pixels = UnsafeMutablePointer<UInt8>(malloc(width*height*4))
    
    let context = CGBitmapContextCreate(pixels , width, height, CGImageGetBitsPerComponent(image), bytesPerRow, CGImageGetColorSpace(image), CGImageGetBitmapInfo(image).rawValue)
    
    CGContextDrawImage(context, CGRectMake(0, 0, CGFloat(width), CGFloat(height)), image)
    
    for x in 0..<width {
        for y in 0..<height {
            let offset = 4*((Int(width) * Int(y)) + Int(x))
            let red = Int(pixels[offset])
            let green = Int(pixels[offset+1])
            let blue = Int(pixels[offset+2])
            
            let luminance = Double((red + green + blue) / 3)
            matrix[x, y] = luminance
        }
    }
    
    return matrix

}


public func calculateDCT(matrix: Matrix, blockSize: Int) -> Matrix {
    let N = blockSize, M = blockSize
    
    var dctMatrix = Matrix(M, N)
    
    for u in 0..<N {
        for v in 0..<M {
            dctMatrix[u, v] = 0
            
            for i in 0..<N {
                for j in 0..<M {
                    dctMatrix[u, v] += matrix[i, j] * cos(π/Double(N) * (Double(i) + 0.5) * Double(u) ) * cos(π/Double(M) * (Double(j) + 0.5) * Double(v) )
                }
            }
        }
    }
    return dctMatrix
}

public func calculateInverseDCT(dctMatrix: Matrix, blockSize: Int) -> Matrix {

    let N = blockSize, M = blockSize
    
    var inverseMatrix = Matrix(M, N)
    
    for u in 0..<N {
        for v in 0..<M {
            inverseMatrix[u, v] = 0.25 * dctMatrix[0,0]
            
            for i in 1..<N {
                inverseMatrix[u,v] += 0.5 * dctMatrix[i, 0]
            }
            
            for j in 1..<M {
                inverseMatrix[u,v] += 0.5 * dctMatrix[0, j]
            }
            
            for i in 1..<N {
                for j in 1..<N {
                    inverseMatrix[u, v] += dctMatrix[i, j] * cos(π/Double(N) * (Double(u) + 0.5) * Double(i) ) * cos(π/Double(M) * (Double(v) + 0.5) * Double(j) )
                }
            }
            
            inverseMatrix[u,v] *= 2 / Double(N)*2/Double(M)
        }
    }
    return inverseMatrix
}