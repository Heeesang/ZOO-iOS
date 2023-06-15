import Foundation
import UIKit

final class GradientButton: UIButton {
    // MARK: - Properties
    private let viewBounds = UIScreen.main.bounds

    // MARK: - LifeCycles
    override init(frame: CGRect) {
        super.init(frame: frame)

        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        configureUI()
    }

    // MARK: - Helpers
    private func configureUI() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: viewBounds.width, height: 68))
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor.rgb(red: 138, green: 255, blue: 213).cgColor,
                           UIColor.rgb(red: 147, green: 144, blue: 255).cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)

        self.layer.insertSublayer(gradient, at: 0)
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
    }
}
