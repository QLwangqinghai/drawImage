//
//  ViewController.swift
//  CAShapeLayerDemo
//
//  Created by CaiLianfeng on 2017/4/26.
//  Copyright © 2017年 WangQinghai. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let imageView = ShapedMessageImageView(frame: CGRect(), isLeftStyle: true)
        imageView.cornerRadius = 5;
        self.view.addSubview(imageView)
        imageView.frame = CGRect(x: 50, y: 150, width: 160, height: 160)
        imageView.image = UIImage(named: "messageImage")
        
        let imageView2 = HeaderImageView(frame: CGRect())
        self.view.addSubview(imageView2)
        imageView2.frame = CGRect(x: 50, y: 400, width: 160, height: 160)
        imageView2.image = UIImage(named: "messageImage")
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) { 
//            self.navigationController?.pushViewController(MyViewController(), animated: true);
        }
        
        let imageView1: UIImageView = UIImageView()
        imageView1.frame = CGRect(x: 0, y: 70, width: 100, height: 100)
        self.view.addSubview(imageView1)
        imageView1.backgroundColor = UIColor.darkGray
//        DispatchQueue.global().async {
//            let image = make()
//            DispatchQueue.main.async {
//                imageView1.image = image
//            }
//        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
//            let image = make()
//            DispatchQueue.main.async {
//                imageView1.image = image
//            }
//            DispatchQueue.global().async {
//                let image = UIImageOperater.makePiercedMask(size: CGSize.init(width: 130, height: 130), cornerRadius: 50, piercedColor: UIColor.blue.cgColor, maskColor: UIColor.red.cgColor, border: (UIColor.green.cgColor, 10.0))
//                DispatchQueue.main.async {
//                    imageView1.image = image
//                }
//            }

//            let image = UIImageOperater.makeImage(size: CGSize(width: 100, height: 100), color: UIColor.red.cgColor)
//            let image = UIImage(named: "111")!
//            imageView1.image = UIImageOperater.maskCircleImage(image, cornerRadius: 40, to: CGSize(width: 80, height: 80))
            imageView1.image = UIImageOperater.makePiercedRoundRectMask(size: CGSize(width: 100, height: 100), cornerRadius: 60, piercedColor: UIColor.red.cgColor, maskColor: UIColor.blue.cgColor, border: (UIColor.black.cgColor, 10))
        }
        
        let imageView3: UIImageView = UIImageView()
        imageView3.frame = CGRect(x: 130, y: 70, width: 100, height: 100)
        self.view.addSubview(imageView3)
        imageView3.backgroundColor = UIColor.green
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
            imageView3.layer.cornerRadius = 60
            imageView3.layer.masksToBounds = true
            imageView3.layer.borderColor = UIColor.red.cgColor
            imageView3.layer.borderWidth = 3
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("1viewWillAppear");
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("1viewDidAppear");
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("1viewWillDisappear");
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("1viewDidDisappear");
    }
}


