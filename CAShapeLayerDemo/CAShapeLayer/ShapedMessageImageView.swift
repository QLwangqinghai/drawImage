//
//  ShapedMessageImageView.swift
//  CAShapeLayerDemo
//
//  Created by CaiLianfeng on 2017/4/26.
//  Copyright © 2017年 WangQinghai. All rights reserved.
//

import UIKit

open class ShapedMessageImageView: UIView {
    open var cornerRadius: CGFloat = 0 {
        didSet {
            setup()
        }
    }
    public let contentLayer: CALayer
    public let maskLayer: CAShapeLayer

    open var image: UIImage? {
        didSet {
            contentLayer.contents = image?.cgImage;
        }
    }

    open var fillColor: UIColor = UIColor.black {//default is black color
        didSet {
            maskLayer.fillColor = fillColor.cgColor;
        }
    }
    open var strokeColor: UIColor = UIColor.clear {//default is clear color
        didSet {
            maskLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    open var isLeftStyle: Bool
    
    public init(frame: CGRect, isLeftStyle: Bool) {
        contentLayer = CALayer()
        maskLayer = CAShapeLayer()
        self.isLeftStyle = isLeftStyle
        super.init(frame: frame)
        
        maskLayer.contentsCenter = CGRect(x: 0, y: 0, width: 1, height: 1);//显示区域 全部显示
        maskLayer.fillColor = fillColor.cgColor;
        maskLayer.strokeColor = strokeColor.cgColor
        maskLayer.contentsScale = UIScreen.main.scale
        contentLayer.mask = maskLayer
        self.layer.addSublayer(contentLayer)
        setup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        setup()
    }
    
    func setup() {
        if isLeftStyle {
            setupLeft()
        } else {
            setupRight()
        }
    }
    
    func setupRight() {
        //construct your path
        
        let bubblePath: CGMutablePath = CGMutablePath()
        let bounds = self.bounds
        let cornerRadius: CGFloat = self.cornerRadius
        let arrowTipWidth: CGFloat = 8;
        let arrowTipHeight: CGFloat = 8;
        let arrowTipToTop: CGFloat = 15;
        
        //顺时针 key point
        let leftTopPoint = CGPoint(x: 0, y: cornerRadius)
        let leftTopCenter = CGPoint(x: cornerRadius, y: cornerRadius)

        let rightTopPoint = CGPoint(x: bounds.size.width - arrowTipWidth - cornerRadius, y: 0)
        let rightTopCenter = CGPoint(x: bounds.size.width - arrowTipWidth - cornerRadius, y: cornerRadius)
        
        //中间
        let arrowTipTopPoint = CGPoint(x: bounds.size.width - arrowTipWidth, y: arrowTipToTop)
        let arrowTipPoint = CGPoint(x: bounds.size.width, y: arrowTipToTop + arrowTipHeight/2)
        let arrowTipBottomPoint = CGPoint(x: bounds.size.width - arrowTipWidth, y: arrowTipToTop + arrowTipHeight)
        
        let rightBottomPoint = CGPoint(x: bounds.size.width - arrowTipWidth, y: bounds.size.height)
        let rightBottomCenter = CGPoint(x: bounds.size.width - arrowTipWidth - cornerRadius, y: bounds.size.height - cornerRadius)
        
        let leftBottomPoint = CGPoint(x: cornerRadius, y: bounds.size.height)
        let leftBottomCenter = CGPoint(x: cornerRadius, y: bounds.size.height - cornerRadius)
        
        bubblePath.addArc(center: leftTopCenter, radius: cornerRadius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi*3/2), clockwise: false);
        bubblePath.addLine(to: rightTopPoint)

        bubblePath.addArc(center: rightTopCenter, radius: cornerRadius, startAngle: CGFloat(Double.pi*3/2), endAngle: CGFloat(Double.pi*2), clockwise: false);
        
        bubblePath.addLine(to: arrowTipTopPoint)
        bubblePath.addLine(to: arrowTipPoint)
        bubblePath.addLine(to: arrowTipBottomPoint)

        bubblePath.addLine(to: rightBottomPoint)
        
        bubblePath.addArc(center: rightBottomCenter, radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi/2), clockwise: false);


        bubblePath.addLine(to: leftBottomPoint)
        bubblePath.addArc(center: leftBottomCenter, radius: cornerRadius, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi), clockwise: false);

        bubblePath.addLine(to: leftTopPoint)

        bubblePath.closeSubpath()

        maskLayer.frame = self.bounds
    
        maskLayer.path = bubblePath
        contentLayer.frame = self.bounds
    }
    
    func setupLeft() {
        //construct your path
        
        let bubblePath: CGMutablePath = CGMutablePath()
        let bounds = self.bounds
        let cornerRadius: CGFloat = self.cornerRadius
        let arrowTipWidth: CGFloat = 8;
        let arrowTipHeight: CGFloat = 8;
        let arrowTipToTop: CGFloat = 15;
        
        //顺时针 key point
        let leftTopPoint = CGPoint(x: arrowTipWidth, y: cornerRadius)
        let leftTopCenter = CGPoint(x: cornerRadius + arrowTipWidth, y: cornerRadius)
        
        let rightTopPoint = CGPoint(x: bounds.size.width - cornerRadius, y: 0)
        let rightTopCenter = CGPoint(x: bounds.size.width - cornerRadius, y: cornerRadius)
        
        let rightBottomPoint = CGPoint(x: bounds.size.width, y: bounds.size.height)
        let rightBottomCenter = CGPoint(x: bounds.size.width - cornerRadius, y: bounds.size.height - cornerRadius)
        
        let leftBottomPoint = CGPoint(x: arrowTipWidth + cornerRadius, y: bounds.size.height)
        let leftBottomCenter = CGPoint(x: arrowTipWidth + cornerRadius, y: bounds.size.height - cornerRadius)
        
        //中间
        let arrowTipTopPoint = CGPoint(x: arrowTipWidth, y: arrowTipToTop)
        let arrowTipPoint = CGPoint(x: 0, y: arrowTipToTop + arrowTipHeight/2)
        let arrowTipBottomPoint = CGPoint(x: arrowTipWidth, y: arrowTipToTop + arrowTipHeight)
        
        bubblePath.addArc(center: leftTopCenter, radius: cornerRadius, startAngle: CGFloat(Double.pi), endAngle: CGFloat(Double.pi*3/2), clockwise: false);
        bubblePath.addLine(to: rightTopPoint)
        
        bubblePath.addArc(center: rightTopCenter, radius: cornerRadius, startAngle: CGFloat(Double.pi*3/2), endAngle: CGFloat(Double.pi*2), clockwise: false);
        
        bubblePath.addLine(to: rightBottomPoint)
        
        bubblePath.addArc(center: rightBottomCenter, radius: cornerRadius, startAngle: 0, endAngle: CGFloat(Double.pi/2), clockwise: false);
        
        
        bubblePath.addLine(to: leftBottomPoint)
        bubblePath.addArc(center: leftBottomCenter, radius: cornerRadius, startAngle: CGFloat(Double.pi/2), endAngle: CGFloat(Double.pi), clockwise: false);
        
        bubblePath.addLine(to: arrowTipBottomPoint)
        bubblePath.addLine(to: arrowTipPoint)
        bubblePath.addLine(to: arrowTipTopPoint)

        bubblePath.addLine(to: leftTopPoint)
        
        bubblePath.closeSubpath()
        
        maskLayer.frame = self.bounds
        
        maskLayer.path = bubblePath
        contentLayer.frame = self.bounds
    }
}
