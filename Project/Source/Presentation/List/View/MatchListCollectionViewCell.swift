import UIKit

final class MatchListCollectionViewCell: BaseCollectionViewCell<MatchInfo> {

    static let id = "MatchCell"

    private let viewBounds = UIScreen.main.bounds

    private let cellView = UIView().then {
        $0.layer.cornerRadius = 20
    }

    private let matchEventLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    private let matchEventContainerView = UIView().then {
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray.cgColor
        $0.layer.cornerRadius = 20
        $0.backgroundColor = .white
    }

    private let firstPlayerCardView = ProfileCardView()

    private let secondPlayerCardView = ProfileCardView()

    private let firstPlayerLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.text = ""
        $0.textColor = UIColor(red: 0.633, green: 0.625, blue: 0.625, alpha: 1)
    }

    private let secondPlayerLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 15)
        $0.text = ""
        $0.textColor = UIColor(red: 0.633, green: 0.625, blue: 0.625, alpha: 1)
    }

    private let matchDateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14, weight: .bold)
        $0.text = "2023-06-11"
        $0.textColor = .white
    }

    override func addView() {
        contentView.addSubview(cellView)
        cellView.addSubViews(matchEventContainerView, firstPlayerCardView, secondPlayerCardView, matchDateLabel)
        matchEventContainerView.addSubview(matchEventLabel)
    }

    override func configureCell() {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 335, height: 230))
        let gradient = CAGradientLayer()

        gradient.frame = view.bounds
        gradient.colors = [UIColor.rgb(red: 138, green: 255, blue: 213).cgColor,
                           UIColor.rgb(red: 147, green: 144, blue: 255).cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)

        cellView.layer.insertSublayer(gradient, at: 0)
        gradient.cornerRadius = 20
        contentView.layer.cornerRadius = 20

        contentView.backgroundColor = .red
    }

    override func setLayout() {
        cellView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(335)
        }

        matchEventLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }

        matchEventContainerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(contentView.snp.top).offset(20)
            $0.width.equalTo(125)
            $0.height.equalTo(40)
        }

        firstPlayerCardView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(29)
            $0.width.equalTo(120)
            $0.height.equalTo(170)
        }

        secondPlayerCardView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(29)
            $0.width.equalTo(120)
            $0.height.equalTo(170)
        }

        matchDateLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalToSuperview().inset(5)
        }
    }

    func changeCellNameData(with model: [MatchInfo]) {
        DispatchQueue.main.async {
            self.matchEventLabel.text = model[0].event
            self.firstPlayerCardView.playerNameLabel.text = model[0].firstPlayer
            self.secondPlayerCardView.playerNameLabel.text = model[0].secondPlayer
        }
    }
}
