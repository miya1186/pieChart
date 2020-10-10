//
//  ViewController.swift
//  pieChart
//
//  Created by miyazawaryohei on 2020/10/10.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let drawImage = drawLine()
        let drawView = UIImageView(image: drawImage)
        view.addSubview(drawView)
    }
    func arcPercent(_ radius:CGFloat, _ percent:Double) -> UIBezierPath {
        
        let endAngle = 2*Double.pi*percent/100 - Double.pi/2
        let path = UIBezierPath(
            arcCenter: CGPoint(x: 0, y: 0),
            radius: radius,
            startAngle: CGFloat(-Double.pi/2),
            endAngle: CGFloat(endAngle),
            clockwise: percent>0
        )
        return path
        
    }
    
    func drawLine() -> UIImage {
        let size = view.bounds.size
        UIGraphicsBeginImageContextWithOptions(size, false, 1.0)
        
        let percent = 58.2
        UIColor.red.setStroke()
        let arcPath = arcPercent(80, percent)
        arcPath.lineWidth = 60
        arcPath.lineCapStyle = .butt
        
        //パスを並行移動
        let tf = CGAffineTransform(translationX: view.center.x, y: view.center.y)
        arcPath.apply(tf)
        arcPath.stroke()
        
        let font = UIFont.boldSystemFont(ofSize: 28)
        let textFontAttributes = [NSAttributedString.Key.font: font,
                                  NSAttributedString.Key.foregroundColor: UIColor.gray]
        let drawString = String(percent) + "%"
        let posX = view.center.x - 45
        let posy = view.center.y - 15
        let rect = CGRect(x: posX, y: posy, width: 90, height: 30)
        drawString.draw(in: rect, withAttributes: textFontAttributes)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}

