import UIKit

extension UILabel {
    public func updateGradientTextColor_horizontal(
        gradientColors: [UIColor] = [UIColor(white: 0, alpha: 0.95),
                                     UIColor(white: 0, alpha: 0.6)]) {
        let size = CGSize(width: intrinsicContentSize.width, height: 1)

        UIGraphicsBeginImageContextWithOptions(size, false, 0)

        defer { UIGraphicsEndImageContext()}
        guard let context = UIGraphicsGetCurrentContext() else {return}
        var colors: [CGColor] = []
        for color in gradientColors {
            colors.append(color.cgColor)
        }
        guard let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(),
                                        colors: colors as CFArray,
                                        locations: nil) else {return }

        context.drawLinearGradient(
            gradient,
            start: CGPoint.zero,
            end: CGPoint(x: size.width, y: 0),
            options: []
        )
        if let image = UIGraphicsGetImageFromCurrentImageContext() {
            self.textColor = UIColor(patternImage: image)
        }
    }
}
