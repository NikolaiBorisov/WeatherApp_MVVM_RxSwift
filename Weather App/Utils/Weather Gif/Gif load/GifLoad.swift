//
//  GifLoad.swift
//  Weather App
//
//  Created by NIKOLAI BORISOV on 12.06.2021.
//

import UIKit
import ImageIO

extension UIImage {
  
  // MARK: - Create source from data
  
  public class func gif(data: Data) -> UIImage? {
    guard let source = CGImageSourceCreateWithData(data as CFData, nil) else {
      print("SwiftGif: Source for the image does not exist")
      return nil
    }
    return UIImage.animatedImageWithSource(source)
  }
  
  // MARK: - Validate URL and Data
  
  public class func gif(url: String) -> UIImage? {
    guard let bundleURL = URL(string: url) else {
      print("SwiftGif: This image named \"\(url)\" does not exist")
      return nil
    }
    guard let imageData = try? Data(contentsOf: bundleURL) else {
      print("SwiftGif: Cannot turn image named \"\(url)\" into NSData")
      return nil
    }
    return gif(data: imageData)
  }
  
  // MARK: - Checking for existance of gif and validating data
  
  public class func gif(name: String) -> UIImage? {
    guard let bundleURL = Bundle.main
            .url(forResource: name, withExtension: "gif") else {
      print("SwiftGif: This image named \"\(name)\" does not exist")
      return nil
    }
    guard let imageData = try? Data(contentsOf: bundleURL) else {
      print("SwiftGif: Cannot turn image named \"\(name)\" into NSData")
      return nil
    }
    return gif(data: imageData)
  }
  
  @available(iOS 9.0, *)
  
  // MARK: - Creating source from assets catalog
  
  public class func gif(asset: String) -> UIImage? {
    guard let dataAsset = NSDataAsset(name: asset) else {
      print("SwiftGif: Cannot turn image named \"\(asset)\" into NSDataAsset")
      return nil
    }
    return gif(data: dataAsset.data)
  }
  
  // MARK: -  Getting dictionaries
  
  internal class func delayForImageAtIndex(_ index: Int, source: CGImageSource!) -> Double {
    var delay = 0.1
    
    let cfProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil)
    let gifPropertiesPointer = UnsafeMutablePointer<UnsafeRawPointer?>.allocate(capacity: 0)
    defer {
      gifPropertiesPointer.deallocate()
    }
    let unsafePointer = Unmanaged.passUnretained(kCGImagePropertyGIFDictionary).toOpaque()
    if CFDictionaryGetValueIfPresent(cfProperties, unsafePointer, gifPropertiesPointer) == false {
      return delay
    }
    let gifProperties: CFDictionary = unsafeBitCast(gifPropertiesPointer.pointee, to: CFDictionary.self)
    
    // MARK: - Getting delay time
    
    var delayObject: AnyObject = unsafeBitCast(
      CFDictionaryGetValue(gifProperties,
                           Unmanaged.passUnretained(kCGImagePropertyGIFUnclampedDelayTime).toOpaque()),
      to: AnyObject.self)
    if delayObject.doubleValue == 0 {
      delayObject = unsafeBitCast(CFDictionaryGetValue(gifProperties,
                                                       Unmanaged.passUnretained(kCGImagePropertyGIFDelayTime).toOpaque()), to: AnyObject.self)
    }
    if let delayObject = delayObject as? Double, delayObject > 0 {
      delay = delayObject
    } else {
      delay = 0.1
    }
    return delay
  }
  
  // MARK: - Checking if one of them is nil
  internal class func gcdForPair(_ lhs: Int?, _ rhs: Int?) -> Int {
    var lhs = lhs
    var rhs = rhs
    if rhs == nil || lhs == nil {
      if rhs != nil {
        return rhs!
      } else if lhs != nil {
        return lhs!
      } else {
        return 0
      }
    }
    if lhs! < rhs! {
      let ctp = lhs
      lhs = rhs
      rhs = ctp
    }
    
    var rest: Int
    while true {
      rest = lhs! % rhs!
      
      if rest == 0 {
        return rhs!
      } else {
        lhs = rhs
        rhs = rest
      }
    }
  }
  
  internal class func gcdForArray(_ array: [Int]) -> Int {
    if array.isEmpty {
      return 1
    }
    
    var gcd = array[0]
    
    for val in array {
      gcd = UIImage.gcdForPair(val, gcd)
    }
    return gcd
  }
  
  // MARK: - Filling arrays, adding image, calculating duration
  
  internal class func animatedImageWithSource(_ source: CGImageSource) -> UIImage? {
    let count = CGImageSourceGetCount(source)
    var images = [CGImage]()
    var delays = [Int]()
    
    for index in 0..<count {
      if let image = CGImageSourceCreateImageAtIndex(source, index, nil) {
        images.append(image)
      }
      
      let delaySeconds = UIImage.delayForImageAtIndex(Int(index),
                                                      source: source)
      delays.append(Int(delaySeconds * 1000.0))
    }
    
    let duration: Int = {
      var sum = 0
      
      for val: Int in delays {
        sum += val
      }
      
      return sum
    }()
    
    // MARK: - Getting frames
    
    let gcd = gcdForArray(delays)
    var frames = [UIImage]()
    
    var frame: UIImage
    var frameCount: Int
    for index in 0..<count {
      frame = UIImage(cgImage: images[Int(index)])
      frameCount = Int(delays[Int(index)] / gcd)
      
      for _ in 0..<frameCount {
        frames.append(frame)
      }
    }
    
    let animation = UIImage.animatedImage(with: frames,
                                          duration: Double(duration) / 1000.0)
    return animation
  }
  
}

