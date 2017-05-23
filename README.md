#drawImage with CoreGraphics
======



##使用UIImageOperater生成图片（`可以在非主线程调用`）
------

###生成纯色图

let size = CGSize(width: 100, height: 100)
let color: UIColor = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
let image = UIImageOperater.makeImage(size: size, color: color.cgColor)


###中间镂空一个圆的图

 创建一个中间圆形镂空的图片

 - Parameters:
   - size: 图片大小（scale跟随屏幕变化）
   - cornerRadius: 中间镂空的圆的半径
   - piercedColor: 中间镂空的圆的颜色
   - maskColor: 遮罩的颜色
   - border: 圆的边缘设置
 - Returns: 图片
public static func makeCirclePiercedMask(size: CGSize, cornerRadius: CGFloat, piercedColor: CGColor = UIColor.clear.cgColor, maskColor: CGColor, border: (CGColor, CGFloat)? = nil) -> UIImage

//生成一张130 * 30 ， 中间圆形半径50， 圆形的颜色为蓝色，遮罩颜色为红色，圆形的边框颜色为绿色，边框10.0 的图片
let image = UIImageOperater.makeCirclePiercedMask(size: CGSize(width: 130, height: 130), cornerRadius: 50, piercedColor: UIColor.blue.cgColor, maskColor: UIColor.red.cgColor, border: (UIColor.green.cgColor, 10.0))



###圆角矩形图片
let size = CGSize(width: 100, height: 100)
let cornerRadius: CGFloat = 20
let piercedColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
let maskColor: UIColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1)
let borderColor = UIColor.green
let borderWidth: CGFloat = 0.0


guard let image = UIImageOperater.makePiercedRoundRectMask(size: size, cornerRadius: cornerRadius, piercedColor: piercedColor.cgColor, maskColor: maskColor.cgColor, border: (borderColor.cgColor, borderWidth)) else {
return
}


###CoreGraphics 图片裁剪

###CoreGraphics 图片裁圆

let size = CGSize(width: 100, height: 100)
let cornerRadius: CGFloat = 40
let image = UIImageOperater.maskCircleImage(UIImage(named: "messageImage")!, cornerRadius: cornerRadius, to: size)
