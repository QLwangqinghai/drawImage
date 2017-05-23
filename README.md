#drawImage with CoreGraphics
======



##使用UIImageOperater生成图片（`可以在非主线程调用`）
------
###中间镂空一个圆的图

/// 创建一个中间圆形镂空的图片
///
/// - Parameters:
///   - size: 图片大小（scale跟随屏幕变化）
///   - cornerRadius: 中间镂空的圆的半径
///   - piercedColor: 中间镂空的圆的颜色
///   - maskColor: 遮罩的颜色
///   - border: 圆的边缘设置
/// - Returns: 图片
public static func makeCirclePiercedMask(size: CGSize, cornerRadius: CGFloat, piercedColor: CGColor = UIColor.clear.cgColor, maskColor: CGColor, border: (CGColor, CGFloat)? = nil) -> UIImage

//生成一张130 * 30 ， 中间圆形半径50， 圆形的颜色为蓝色，遮罩颜色为红色，圆形的边框颜色为绿色，边框10.0 的图片
let image = UIImageOperater.makeCirclePiercedMask(size: CGSize(width: 130, height: 130), cornerRadius: 50, piercedColor: UIColor.blue.cgColor, maskColor: UIColor.red.cgColor, border: (UIColor.green.cgColor, 10.0))



###圆角矩形图片

###CoreGraphics 图片裁剪

###CoreGraphics 图片裁圆
