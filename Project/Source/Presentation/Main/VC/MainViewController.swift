import UIKit
import Lottie
import RxSwift
import RxCocoa

class MainViewController: BaseVC<MainViewModel> {

    private let disposeBag = DisposeBag()

    private let titleLabel = UILabel().then {
        $0.text = "ZOO"
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.updateGradientTextColor_horizontal(gradientColors:
            [UIColor.rgb(red: 138, green: 255, blue: 213),
             UIColor.rgb(red: 147, green: 144, blue: 255)])
    }

    private let mainLottieAnimationView = LottieAnimationView(name: "144103-e-v-e").then {
        $0.contentMode = .scaleAspectFit
        $0.loopMode = .loop
        $0.play()
    }

    private let nextButton = GradientButton().then {
        $0.setTitle("경기 확인", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 21, weight: .semibold)
        $0.titleLabel?.textColor = .white
        $0.layer.cornerRadius = 20
    }

    private func nextButtonDidTap() {
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                let nextVC = ListViewController(viewModel: ListViewModel())
                owner.navigationController?.pushViewController(nextVC, animated: true)
            }.disposed(by: disposeBag)
    }

    override func configureVC() {
        nextButtonDidTap()
    }

    override func addView() {
        view.addSubViews(titleLabel, mainLottieAnimationView, nextButton)
    }

    override func setLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(130)
            $0.centerX.equalToSuperview()
        }

        mainLottieAnimationView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(30)
            $0.height.equalTo(280)
            $0.centerX.equalToSuperview()
        }

        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(120)
            $0.leading.trailing.equalToSuperview().inset(93)
            $0.height.equalTo(62)
        }
    }
}

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

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }

    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}
