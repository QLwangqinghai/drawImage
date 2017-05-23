//
//  UIImageResize.swift
//  CAShapeLayerDemo
//
//  Created by CaiLianfeng on 2017/4/29.
//  Copyright © 2017年 WangQinghai. All rights reserved.
//

import UIKit


public struct UIMath {
    
    public static func angle(startPoint: CGPoint, endPoint: CGPoint) -> CGFloat {
        let xPoint = CGPoint(x: startPoint.x + 100, y: startPoint.y);
        let a = endPoint.x - startPoint.x
        let b = endPoint.y - startPoint.y
        let c = xPoint.x - startPoint.x
        let d = xPoint.y - startPoint.y
        
        var rads = acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
        if startPoint.y > endPoint.y {
            rads = -rads
        }
        if rads < 0 {
            rads = CGFloat(Double.pi * 2) + rads
        }
        
        return rads;
    }
}


extension CGMutablePath {
    func addArc(center: CGPoint, start: CGPoint, end: CGPoint, radius: CGFloat) {
        let startAngle = UIMath.angle(startPoint: center, endPoint: start)
        let endAngle = UIMath.angle(startPoint: center, endPoint: start)
        addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
    }
}

extension CGContext {
    func addArc(center: CGPoint, start: CGPoint, end: CGPoint, radius: CGFloat) {
        let startAngle = UIMath.angle(startPoint: center, endPoint: start)
        let endAngle = UIMath.angle(startPoint: center, endPoint: end)
        addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
    }
}

public struct UIImageOperater {
    
    //顺时针方向 每段弧的两个顶点 第一个点为A， 第二个点为B
    struct RoundRectKeyPathPoints {
        let leftTopPointA: CGPoint
        let leftTopCenter: CGPoint
        let leftTopPointB: CGPoint
        
        let rightTopPointA: CGPoint
        let rightTopCenter: CGPoint
        let rightTopPointB: CGPoint
        
        let rightBottomPointA: CGPoint
        let rightBottomCenter: CGPoint
        let rightBottomPointB: CGPoint
        
        let leftBottomPointA: CGPoint
        let leftBottomCenter: CGPoint
        let leftBottomPointB: CGPoint
        
        let leftIntersect: Bool
        let topIntersect: Bool
        let rightIntersect: Bool
        let bottomIntersect: Bool

        
        init(frame: CGRect, insets: UIEdgeInsets, cornerRadius: CGFloat) {
            let bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: frame.width - insets.left + insets.right, height: frame.height - insets.top + insets.bottom))
            
            let levelIntersect: Bool = bounds.height < 2 * cornerRadius
            let verticalIntersect: Bool = bounds.width < 2 * cornerRadius

            self.leftIntersect = levelIntersect
            self.rightIntersect = levelIntersect
            
            self.topIntersect = verticalIntersect
            self.bottomIntersect = verticalIntersect

            var leftTopPointA: CGPoint
            let leftTopCenter: CGPoint = CGPoint(x: cornerRadius, y: cornerRadius)
            var leftTopPointB: CGPoint
            
            var rightTopPointA: CGPoint
            let rightTopCenter: CGPoint = CGPoint(x: bounds.width - cornerRadius, y: cornerRadius)
            var rightTopPointB: CGPoint
            
            var rightBottomPointA: CGPoint
            let rightBottomCenter: CGPoint = CGPoint(x: bounds.width - cornerRadius, y: bounds.height - cornerRadius)
            var rightBottomPointB: CGPoint
            
            var leftBottomPointA: CGPoint
            let leftBottomCenter: CGPoint = CGPoint(x: cornerRadius, y: bounds.height - cornerRadius)
            var leftBottomPointB: CGPoint
            
            
            if levelIntersect {
                var x: CGFloat = 0
                var y: CGFloat = 0
                let h = sqrt(pow(Double(cornerRadius), 2) - pow(Double(cornerRadius) - Double(bounds.height)/2, 2))
                
                x = cornerRadius - CGFloat(h)
                y = bounds.height/2
                
                leftTopPointA = CGPoint(x: x, y: y)
                leftBottomPointB = leftTopPointA
                
                x = bounds.width - (cornerRadius - CGFloat(h))

                rightTopPointB = CGPoint(x: x, y: y)
                rightBottomPointA = rightTopPointB
            } else {
                leftTopPointA = CGPoint(x: 0, y: cornerRadius)
                leftBottomPointB = CGPoint(x: 0, y: bounds.height - cornerRadius)
                rightTopPointB = CGPoint(x: bounds.width, y: cornerRadius)
                rightBottomPointA = CGPoint(x: bounds.width, y: bounds.height - cornerRadius)
            }
            if verticalIntersect {
                var x: CGFloat = 0
                var y: CGFloat = 0
                let h = sqrt(pow(Double(cornerRadius), 2) - pow(Double(cornerRadius) - Double(bounds.height)/2, 2))
                
                x = bounds.width/2
                y = cornerRadius - CGFloat(h)
                
                leftTopPointB = CGPoint(x: x, y: y)
                rightTopPointA = leftTopPointB
                
                y = bounds.height - (cornerRadius - CGFloat(h))
                
                rightBottomPointB = CGPoint(x: x, y: y)
                leftBottomPointA = rightBottomPointB
            } else {
                leftTopPointB = CGPoint(x: cornerRadius, y: 0)
                rightTopPointA = CGPoint(x: bounds.width - cornerRadius, y: 0)
                rightBottomPointB = CGPoint(x: bounds.width - cornerRadius, y: bounds.height)
                leftBottomPointA = CGPoint(x: cornerRadius, y: bounds.height)
            }
            
            self.leftTopPointA = CGPoint(x: leftTopPointA.x + frame.origin.x + insets.left, y: leftTopPointA.y + frame.origin.y + insets.top)
            self.leftTopCenter = CGPoint(x: leftTopCenter.x + frame.origin.x + insets.left, y: leftTopCenter.y + frame.origin.y + insets.top)
            self.leftTopPointB = CGPoint(x: leftTopPointB.x + frame.origin.x + insets.left, y: leftTopPointB.y + frame.origin.y + insets.top)

            self.rightTopPointA = CGPoint(x: rightTopPointA.x + frame.origin.x + insets.left, y: rightTopPointA.y + frame.origin.y + insets.top)
            self.rightTopCenter = CGPoint(x: rightTopCenter.x + frame.origin.x + insets.left, y: rightTopCenter.y + frame.origin.y + insets.top)
            self.rightTopPointB = CGPoint(x: rightTopPointB.x + frame.origin.x + insets.left, y: rightTopPointB.y + frame.origin.y + insets.top)

            self.leftBottomPointA = CGPoint(x: leftBottomPointA.x + frame.origin.x + insets.left, y: leftBottomPointA.y + frame.origin.y + insets.top)
            self.leftBottomCenter = CGPoint(x: leftBottomCenter.x + frame.origin.x + insets.left, y: leftBottomCenter.y + frame.origin.y + insets.top)
            self.leftBottomPointB = CGPoint(x: leftBottomPointB.x + frame.origin.x + insets.left, y: leftBottomPointB.y + frame.origin.y + insets.top)
            
            self.rightBottomPointA = CGPoint(x: rightBottomPointA.x + frame.origin.x + insets.left, y: rightBottomPointA.y + frame.origin.y + insets.top)
            self.rightBottomCenter = CGPoint(x: rightBottomCenter.x + frame.origin.x + insets.left, y: rightBottomCenter.y + frame.origin.y + insets.top)
            self.rightBottomPointB = CGPoint(x: rightBottomPointB.x + frame.origin.x + insets.left, y: rightBottomPointB.y + frame.origin.y + insets.top)
            
            
        }

        
        
        
    }
    
    
    
    /// 生成一张纯色图
    ///
    /// - Parameters:
    ///   - size: 图片size
    ///   - color: 图片颜色
    /// - Returns: 生成的图片
    public static func makeImage(size: CGSize, color: CGColor) -> UIImage {
        var rect = CGRect()
        rect.size = size
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        if color != UIColor.clear.cgColor {
            let context: CGContext = UIGraphicsGetCurrentContext()!
            context.setFillColor(color)
            context.clip()
            context.fill(rect)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
    /// 图片裁圆
    ///
    /// - Parameters:
    ///   - image: 原图
    ///   - cornerRadius: 圆的半径
    ///   - size: 生成的图片大小，注意裁剪的圆会居中
    /// - Returns: 生成的图片
    public static func maskCircleImage(_ image: UIImage, cornerRadius: CGFloat, to size: CGSize) -> UIImage {
        var rect = CGRect()
        rect.size = size
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let color = UIColor(patternImage: colorImage!)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let imageContext: CGContext = UIGraphicsGetCurrentContext()!
        let path: CGMutablePath = CGMutablePath()
        path.addArc(center: CGPoint(x: size.width/2, y: size.height/2), radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: false)
        imageContext.addPath(path)
        imageContext.setFillColor(color.cgColor)
        imageContext.clip()
        imageContext.fill(rect)
        let clipedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor.clear.cgColor)
        context.fill(rect)
        clipedImage?.draw(in: rect)

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    
    /// 创建一个中间圆形镂空的图片
    ///
    /// - Parameters:
    ///   - size: 图片大小（scale跟随屏幕变化）
    ///   - cornerRadius: 中间镂空的圆的半径
    ///   - piercedColor: 中间镂空的圆的颜色
    ///   - maskColor: 遮罩的颜色
    ///   - border: 圆的边缘设置
    /// - Returns: 图片
    public static func makeCirclePiercedMask(size: CGSize, cornerRadius: CGFloat, piercedColor: CGColor = UIColor.clear.cgColor, maskColor: CGColor, border: (CGColor, CGFloat)? = nil) -> UIImage {
        var rect = CGRect()
        rect.size = size
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        
        if piercedColor != UIColor.clear.cgColor {
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let piercedContext: CGContext = UIGraphicsGetCurrentContext()!
            
            let piercedCenterPath: CGMutablePath = CGMutablePath()
            piercedCenterPath.addArc(center: CGPoint(x: size.width/2, y: size.height/2), radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: false)
            piercedContext.addPath(piercedCenterPath)
            piercedContext.setFillColor(piercedColor)
            piercedContext.clip()
            piercedContext.fill(rect)
            let piercedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            piercedImage?.draw(in: rect)
        }
        
        if let value = border {
            let borderColor = value.0
            let borderWidth = value.1
            
            if borderWidth != 0 {
                UIGraphicsBeginImageContextWithOptions(size, false, 0)
                let borderContext: CGContext = UIGraphicsGetCurrentContext()!
                let borderPath: CGMutablePath = CGMutablePath()
                borderPath.addArc(center: CGPoint(x: size.width/2, y: size.height/2), radius: cornerRadius + borderWidth, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: false)
                
                borderPath.addArc(center: CGPoint(x: size.width/2, y: size.height/2), radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: false)
                borderPath.closeSubpath()
                borderContext.addPath(borderPath)
                borderContext.setFillColor(borderColor)
                borderContext.clip(using: CGPathFillRule.evenOdd)
                borderContext.fill(rect)
                let image = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                image?.draw(in: rect)
            }
        }
        if maskColor != UIColor.clear.cgColor {
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let maskContext: CGContext = UIGraphicsGetCurrentContext()!
            
            let maskPath: CGMutablePath = CGMutablePath()
            maskPath.addRect(rect)
            
            var borderWidth: CGFloat = 0;
            if let value = border {
                borderWidth = value.1
            }
            
            maskPath.addArc(center: CGPoint(x: size.width/2, y: size.height/2), radius: cornerRadius + borderWidth, startAngle: 0, endAngle: CGFloat(Double.pi * 2), clockwise: false)
            
            maskContext.addPath(maskPath)
            maskContext.setFillColor(maskColor)
            maskContext.clip(using: CGPathFillRule.evenOdd)
            maskContext.fill(rect)
            let maskImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            maskImage?.draw(in: rect)
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext()
        
        return image!
    }
    
    public static func makePiercedRoundRectMask(size: CGSize, cornerRadius: CGFloat, piercedColor: CGColor = UIColor.clear.cgColor, maskColor: CGColor, border: (CGColor, CGFloat)? = nil) -> UIImage? {
        
        //, border: (CGColor, CGFloat)? = nil
        func drawPiercedRoundRect(size: CGSize, cornerRadius: CGFloat, piercedColor: CGColor, borderWidth: CGFloat) -> UIImage {
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let context: CGContext = UIGraphicsGetCurrentContext()!
            let rect = CGRect(origin: CGPoint.zero, size: size)
            
            context.setAllowsAntialiasing(true)
            context.setLineWidth(0)
            
            let keyPoints = RoundRectKeyPathPoints(frame: rect, insets: UIEdgeInsets(top: borderWidth, left: borderWidth, bottom: -borderWidth, right: -borderWidth), cornerRadius: cornerRadius)
            
            
            /*
             context.move(to: keyPoints.leftTopPointA)
             context.addLine(to: keyPoints.leftTopPointB)
             
             
             context.addLine(to: keyPoints.rightTopPointA)
             context.addLine(to: keyPoints.rightTopPointB)
             
             context.addLine(to: keyPoints.rightBottomPointA)
             context.addLine(to: keyPoints.rightBottomPointB)
             
             context.addLine(to: keyPoints.leftBottomPointA)
             context.addLine(to: keyPoints.leftBottomPointB)
             context.addLine(to: keyPoints.leftTopPointA)
             */
            
            context.move(to: keyPoints.leftTopPointA)
            context.addArc(center: keyPoints.leftTopCenter, start: keyPoints.leftTopPointA, end: keyPoints.leftTopPointB, radius: cornerRadius)
            
            if !keyPoints.topIntersect {
                context.addLine(to: keyPoints.rightTopPointA)
            }
            
            context.addArc(center: keyPoints.rightTopCenter, start: keyPoints.rightTopPointA, end: keyPoints.rightTopPointB, radius: cornerRadius)
            if !keyPoints.rightIntersect {
                context.addLine(to: keyPoints.rightBottomPointA)
            }

            context.addArc(center: keyPoints.rightBottomCenter, start: keyPoints.rightBottomPointA, end: keyPoints.rightBottomPointB, radius: cornerRadius)
            if !keyPoints.bottomIntersect {
                context.addLine(to: keyPoints.leftBottomPointA)
            }

            context.addArc(center: keyPoints.leftBottomCenter, start: keyPoints.leftBottomPointA, end: keyPoints.leftBottomPointB, radius: cornerRadius)
            if !keyPoints.bottomIntersect {
                context.addLine(to: keyPoints.leftTopPointA)
            }
            context.closePath()

            context.clip()
            context.setFillColor(piercedColor)
            context.fill(rect)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            return image!
        }
        
        func drawBorder(size: CGSize, cornerRadius: CGFloat, borderColor: CGColor, borderWidth: CGFloat) -> UIImage? {
            if borderWidth == 0 {
                return nil
            }
            
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let context: CGContext = UIGraphicsGetCurrentContext()!
            
            context.setAllowsAntialiasing(true)
            context.setLineWidth(0)
            
            let rect = CGRect(origin: CGPoint.zero, size: size)

            let keyPoints = RoundRectKeyPathPoints(frame: rect, insets: UIEdgeInsets.zero, cornerRadius: cornerRadius + borderWidth)
            
            context.move(to: keyPoints.leftTopPointA)
            context.addArc(center: keyPoints.leftTopCenter, start: keyPoints.leftTopPointA, end: keyPoints.leftTopPointB, radius: cornerRadius + borderWidth)
            
            if !keyPoints.topIntersect {
                context.addLine(to: keyPoints.rightTopPointA)
            }
            
            context.addArc(center: keyPoints.rightTopCenter, start: keyPoints.rightTopPointA, end: keyPoints.rightTopPointB, radius: cornerRadius + borderWidth)
            if !keyPoints.rightIntersect {
                context.addLine(to: keyPoints.rightBottomPointA)
            }
            
            context.addArc(center: keyPoints.rightBottomCenter, start: keyPoints.rightBottomPointA, end: keyPoints.rightBottomPointB, radius: cornerRadius + borderWidth)
            if !keyPoints.bottomIntersect {
                context.addLine(to: keyPoints.leftBottomPointA)
            }
            
            context.addArc(center: keyPoints.leftBottomCenter, start: keyPoints.leftBottomPointA, end: keyPoints.leftBottomPointB, radius: cornerRadius + borderWidth)
            if !keyPoints.bottomIntersect {
                context.addLine(to: keyPoints.leftTopPointA)
            }
            
            
            let keyPoints1 = RoundRectKeyPathPoints(frame: rect, insets: UIEdgeInsets(top: borderWidth, left: borderWidth, bottom: -borderWidth, right: -borderWidth), cornerRadius: cornerRadius)
            context.move(to: keyPoints1.leftTopPointA)
            context.addArc(center: keyPoints1.leftTopCenter, start: keyPoints1.leftTopPointA, end: keyPoints1.leftTopPointB, radius: cornerRadius)
            
            if !keyPoints1.topIntersect {
                context.addLine(to: keyPoints1.rightTopPointA)
            }
            
            context.addArc(center: keyPoints1.rightTopCenter, start: keyPoints1.rightTopPointA, end: keyPoints1.rightTopPointB, radius: cornerRadius)
            if !keyPoints1.rightIntersect {
                context.addLine(to: keyPoints1.rightBottomPointA)
            }
            
            context.addArc(center: keyPoints1.rightBottomCenter, start: keyPoints1.rightBottomPointA, end: keyPoints1.rightBottomPointB, radius: cornerRadius)
            if !keyPoints1.bottomIntersect {
                context.addLine(to: keyPoints1.leftBottomPointA)
            }
            
            context.addArc(center: keyPoints1.leftBottomCenter, start: keyPoints1.leftBottomPointA, end: keyPoints1.leftBottomPointB, radius: cornerRadius)
            if !keyPoints1.bottomIntersect {
                context.addLine(to: keyPoints1.leftTopPointA)
            }
            
            context.closePath()
            context.clip(using: CGPathFillRule.evenOdd)
            context.setFillColor(borderColor)
            context.fill(rect)
            
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image;
        }
        
        func drawMask(size: CGSize, cornerRadius: CGFloat, maskColor: CGColor) -> UIImage? {

            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            let context: CGContext = UIGraphicsGetCurrentContext()!
            
            context.setAllowsAntialiasing(true)
            context.setLineWidth(0)
            
            let rect = CGRect(origin: CGPoint.zero, size: size)
            
            let keyPoints = RoundRectKeyPathPoints(frame: rect, insets: UIEdgeInsets.zero, cornerRadius: cornerRadius)
            context.addRect(rect)
            
            
            context.move(to: keyPoints.leftTopPointA)
            context.addArc(center: keyPoints.leftTopCenter, start: keyPoints.leftTopPointA, end: keyPoints.leftTopPointB, radius: cornerRadius)
            
            if !keyPoints.topIntersect {
                context.addLine(to: keyPoints.rightTopPointA)
            }
            
            context.addArc(center: keyPoints.rightTopCenter, start: keyPoints.rightTopPointA, end: keyPoints.rightTopPointB, radius: cornerRadius)
            if !keyPoints.rightIntersect {
                context.addLine(to: keyPoints.rightBottomPointA)
            }
            
            context.addArc(center: keyPoints.rightBottomCenter, start: keyPoints.rightBottomPointA, end: keyPoints.rightBottomPointB, radius: cornerRadius)
            if !keyPoints.bottomIntersect {
                context.addLine(to: keyPoints.leftBottomPointA)
            }
            
            context.addArc(center: keyPoints.leftBottomCenter, start: keyPoints.leftBottomPointA, end: keyPoints.leftBottomPointB, radius: cornerRadius)
            if !keyPoints.bottomIntersect {
                context.addLine(to: keyPoints.leftTopPointA)
            }
            
            context.closePath()
            context.clip(using: CGPathFillRule.evenOdd)
            context.setFillColor(maskColor)
            context.fill(rect)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return image;
        }
        
        let borderWidth: CGFloat
        if let aborder = border {
            borderWidth = aborder.1
        } else {
            borderWidth = 0
        }
        
        let rect = CGRect(origin: CGPoint.zero, size: size)

        if cornerRadius > min(size.width, size.height) {
            return nil
        }
        
        
        let image = drawPiercedRoundRect(size: size, cornerRadius: cornerRadius, piercedColor: piercedColor, borderWidth: borderWidth)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image.draw(in: rect)
        
        if let value = border {
            let image1 = drawBorder(size: size, cornerRadius: cornerRadius, borderColor: value.0, borderWidth: value.1)
            image1?.draw(in: rect)
        }
        let image1 = drawMask(size: size, cornerRadius: cornerRadius + borderWidth, maskColor: maskColor)
        image1?.draw(in: rect)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return resultImage!
    }
    
    public static func image(_ image: UIImage, resize toWidth: CGFloat) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(CGSize(width: toWidth, height: toWidth), false, 1.0)
        let rect = CGRect(x: 0, y: 0, width: toWidth, height: toWidth)
        
        guard let contexttext: CGContext = UIGraphicsGetCurrentContext(), let cgImage = image.cgImage else {
            return nil;
        }
        contexttext.draw(cgImage, in: rect)
        
        let bezierPath: UIBezierPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: toWidth, height: toWidth), cornerRadius: toWidth)
        bezierPath.addClip()
//        CGcontextDrawImage
        
//        UIGraphicsBeginImagecontextWithOptions(imageView.bounds.size, NO, 1.0);

        return nil
    }

    func asdf() {
        
    }
}


