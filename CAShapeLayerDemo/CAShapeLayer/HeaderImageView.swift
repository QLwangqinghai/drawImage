
//
//  HeaderImageView.swift
//  CAShapeLayerDemo
//
//  Created by CaiLianfeng on 2017/4/28.
//  Copyright © 2017年 WangQinghai. All rights reserved.
//

import UIKit
import CoreGraphics

open class HeaderImageView: UIView {
    
    open var cornerRadius: CGFloat = 0 {
        didSet {
            setup()
        }
    }
    public let maskLayer: CAShapeLayer
    
    open var image: UIImage? {
        didSet {
            self.layer.contents = image?.cgImage;
        }
    }
    
    open var fillColor: UIColor = UIColor.black {//default is clear color
        didSet {
            maskLayer.fillColor = fillColor.cgColor;
        }
    }
    open var strokeColor: UIColor = UIColor.clear {//default is clear color
        didSet {
            maskLayer.strokeColor = strokeColor.cgColor
        }
    }
    
    public override init(frame: CGRect) {
        maskLayer = CAShapeLayer()
        super.init(frame: frame)
        
        maskLayer.contentsCenter = CGRect(x: 0, y: 0, width: 1, height: 1);//显示区域 全部显示
        maskLayer.fillColor = fillColor.cgColor;
        maskLayer.strokeColor = strokeColor.cgColor
        maskLayer.contentsScale = UIScreen.main.scale
        self.layer.mask = maskLayer
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
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: UIRectCorner.allCorners, cornerRadii: self.bounds.size)
        maskLayer.frame = self.bounds
        maskLayer.path = maskPath.cgPath
    }
    
    
    /*
     UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
     imageView.image = [UIImage imageNamed:@"1"];
     UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:imageView.bounds.size];
     
     CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
     //设置大小
     maskLayer.frame = imageView.bounds;
     //设置图形样子
     maskLayer.path = maskPath.CGPath;
     imageView.layer.mask = maskLayer;
     [self.view addSubview:imageView];
     */

}
