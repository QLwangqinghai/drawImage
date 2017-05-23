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
                let image = UIImageOperater.makeCirclePiercedMask(size: CGSize(width: 130, height: 130), cornerRadius: 50, piercedColor: UIColor.blue.cgColor, maskColor: UIColor.red.cgColor, border: (UIColor.green.cgColor, 10.0))
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
        
        let showImageView: UIImageView = UIImageView()
        showImageView.frame = CGRect(x: 15, y: 210, width: 130, height: 130)
        self.view.addSubview(showImageView)
        showImageView.backgroundColor = UIColor.darkGray
        
        let showImageView1: UIImageView = UIImageView()
        showImageView1.frame = CGRect(x: 150, y: 210, width: 100, height: 100)
        self.view.addSubview(showImageView1)
        showImageView1.backgroundColor = UIColor.darkGray
     
        DispatchQueue.global().async {
            let size = CGSize(width: 130, height: 130)
            let cornerRadius: CGFloat = 50
            let piercedColor: UIColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
            let maskColor: UIColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            let borderColor = UIColor.green
            let borderWidth: CGFloat = 10.0

            let image = UIImageOperater.makeCirclePiercedMask(size: size, cornerRadius: cornerRadius, piercedColor: piercedColor.cgColor, maskColor: maskColor.cgColor, border: (borderColor.cgColor, borderWidth))
            if let data = UIImagePNGRepresentation(image) {
                let filePath = NSHomeDirectory().appending("/Library/Caches/\(UUID().uuidString)")
                do {
                    try data.write(to: URL(fileURLWithPath: filePath))
                    print("图片写入成功， 文件路径：\(filePath) size:\(size) cornerRadius:\(cornerRadius) borderWidth:\(borderWidth)")
                } catch let error {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                showImageView.image = image
            }
        }
        
        //镂空圆图片
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 2) {
            let size = CGSize(width: 130, height: 130)
            let cornerRadius: CGFloat = 50
            let piercedColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            let maskColor: UIColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            let borderColor = UIColor.green
            let borderWidth = 0.0
            
            let image = UIImageOperater.makeCirclePiercedMask(size: size, cornerRadius: cornerRadius, piercedColor: piercedColor.cgColor, maskColor: maskColor.cgColor, border: (borderColor.cgColor, 10.0))
            if let data = UIImagePNGRepresentation(image) {
                let filePath = NSHomeDirectory().appending("/Library/Caches/\(UUID().uuidString)")
                do {
                    try data.write(to: URL(fileURLWithPath: filePath))
                    print("图片写入成功， 文件路径：\(filePath) size:\(size) cornerRadius:\(cornerRadius) borderWidth:\(borderWidth)")
                } catch let error {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                showImageView.image = image
            }
        }
        
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 4) {
            let size = CGSize(width: 130, height: 130)
            let cornerRadius: CGFloat = 50
            let piercedColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            let maskColor: UIColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            let borderColor = UIColor.green
            let borderWidth = 0.0
            
            let image = UIImageOperater.makeCirclePiercedMask(size: size, cornerRadius: cornerRadius, piercedColor: piercedColor.cgColor, maskColor: maskColor.cgColor, border: (borderColor.cgColor, 10.0))
            if let data = UIImagePNGRepresentation(image) {
                let filePath = NSHomeDirectory().appending("/Library/Caches/\(UUID().uuidString)")
                do {
                    try data.write(to: URL(fileURLWithPath: filePath))
                    print("图片写入成功， 文件路径：\(filePath) size:\(size) cornerRadius:\(cornerRadius) borderWidth:\(borderWidth)")
                } catch let error {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                showImageView.image = image
            }
        }
        
        
        //-------------------------
        
        //生成纯色图
        DispatchQueue.global().async {
            
            let size = CGSize(width: 100, height: 100)
            let color: UIColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
            let image = UIImageOperater.makeImage(size: size, color: color.cgColor)
            if let data = UIImagePNGRepresentation(image) {
                let filePath = NSHomeDirectory().appending("/Library/Caches/\(UUID().uuidString)")
                do {
                    try data.write(to: URL(fileURLWithPath: filePath))
                    print("图片写入成功， 文件路径：\(filePath) size:\(size) 纯色图")
                } catch let error {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                showImageView1.image = image
            }
        }
        
        //裁圆
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 3) {
            let size = CGSize(width: 100, height: 100)
            let cornerRadius: CGFloat = 40
            let image = UIImageOperater.maskCircleImage(UIImage(named: "messageImage")!, cornerRadius: cornerRadius, to: size)
            if let data = UIImagePNGRepresentation(image) {
                let filePath = NSHomeDirectory().appending("/Library/Caches/\(UUID().uuidString)")
                do {
                    try data.write(to: URL(fileURLWithPath: filePath))
                    print("图片写入成功， 文件路径：\(filePath) size:\(size) 裁圆")
                } catch let error {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                showImageView1.image = image
            }
        }
        
        //圆角矩形楼空图
        DispatchQueue.global().asyncAfter(deadline: DispatchTime.now() + 6) {
            let size = CGSize(width: 100, height: 100)
            let cornerRadius: CGFloat = 50
            let piercedColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
            let maskColor: UIColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
            let borderColor = UIColor.green
            let borderWidth: CGFloat = 0.0
            
            
            guard let image = UIImageOperater.makePiercedRoundRectMask(size: size, cornerRadius: cornerRadius, piercedColor: piercedColor.cgColor, maskColor: maskColor.cgColor, border: (borderColor.cgColor, borderWidth)) else {
                return
            }
        
            if let data = UIImagePNGRepresentation(image) {
                let filePath = NSHomeDirectory().appending("/Library/Caches/\(UUID().uuidString)")
                do {
                    try data.write(to: URL(fileURLWithPath: filePath))
                    print("图片写入成功， 文件路径：\(filePath) size:\(size) cornerRadius:\(cornerRadius) borderWidth:\(borderWidth)  makePiercedRoundRectMask")
                } catch let error {
                    print(error)
                }
            }
            DispatchQueue.main.async {
                showImageView1.image = image
            }
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


