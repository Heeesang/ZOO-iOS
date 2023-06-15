import UIKit
import RxCocoa
import RxSwift

class AddMatchInfoViewController: BaseVC<AddMatchInfoViewModel> {

    var matchInfo = MatchInfo(firstPlayer: "", secondPlayer: "", event: "", schedule: "")

    private let disposeBag = DisposeBag()

    private let titleLabel = UILabel().then {
        $0.text = "게시물 생성"
        $0.font = .systemFont(ofSize: 21, weight: .bold)
        $0.updateGradientTextColor_horizontal(gradientColors:
            [UIColor.rgb(red: 138, green: 255, blue: 213),
             UIColor.rgb(red: 147, green: 144, blue: 255)])
    }

    private lazy var volleyballButton = UIButton().then {
        $0.setTitle("배구 🏐", for: .normal)
        $0.tag = 1
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(eventButtonDidTap(_:)), for: .touchUpInside)
    }

    private lazy var badmintonButton = UIButton().then {
        $0.setTitle("배드민턴 🏸", for: .normal)
        $0.tag = 2
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(eventButtonDidTap(_:)), for: .touchUpInside)
    }

    private lazy var basketballButton = UIButton().then {
        $0.setTitle("농구 🏀", for: .normal)
        $0.tag = 3
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(eventButtonDidTap(_:)), for: .touchUpInside)
    }

    private lazy var soccerButton = UIButton().then {
        $0.setTitle("축구 ⚽️", for: .normal)
        $0.tag = 4
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(eventButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private lazy var launchButton = UIButton().then {
        $0.setTitle("점심", for: .normal)
        $0.tag = 1
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(dateButtonDidTap(_:)), for: .touchUpInside)
    }
    
    private lazy var dinnerButton = UIButton().then {
        $0.setTitle("저녁", for: .normal)
        $0.tag = 2
        $0.setTitleColor(UIColor.black, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        $0.layer.borderColor = UIColor.lightGray.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 20
        $0.addTarget(self, action: #selector(dateButtonDidTap(_:)), for: .touchUpInside)
    }

    private let nextButton = GradientButton().then {
        $0.setTitle("완료", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
    }

    @objc private func eventButtonDidTap(_ sender: UIButton) {
        let buttons: [UIButton] = [volleyballButton, badmintonButton, basketballButton, soccerButton]

        for button in buttons {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }

        switch sender.tag {
        case 1:
            volleyballButton.layer.borderWidth = 1
            volleyballButton.layer.borderColor = UIColor.black.cgColor
            self.matchInfo.event = volleyballButton.titleLabel?.text ?? ""
        case 2:
            badmintonButton.layer.borderWidth = 1
            badmintonButton.layer.borderColor = UIColor.black.cgColor
            self.matchInfo.event = badmintonButton.titleLabel?.text ?? ""
        case 3:
            basketballButton.layer.borderWidth = 1
            basketballButton.layer.borderColor = UIColor.black.cgColor
            self.matchInfo.event = basketballButton.titleLabel?.text ?? ""
        case 4:
            soccerButton.layer.borderWidth = 1
            soccerButton.layer.borderColor = UIColor.black.cgColor
            self.matchInfo.event = soccerButton.titleLabel?.text ?? ""
        default:
            return
        }
    }

    @objc private func dateButtonDidTap(_ sender: UIButton) {
        let buttons: [UIButton] = [launchButton, dinnerButton]

        for button in buttons {
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }

        switch sender.tag {
        case 1:
            launchButton.layer.borderWidth = 1
            launchButton.layer.borderColor = UIColor.black.cgColor
            self.matchInfo.schedule = launchButton.titleLabel?.text ?? ""
        case 2:
            dinnerButton.layer.borderWidth = 1
            dinnerButton.layer.borderColor = UIColor.black.cgColor
            self.matchInfo.schedule = dinnerButton.titleLabel?.text ?? ""
        default:
            return
        }
    }

    private func nextButtonDidTap() {
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                MatchListData.shared.newMatchList.append(contentsOf: [self.matchInfo])
                owner.navigationController?.popToRootViewController(animated: true)
                print(self.matchInfo)
            }.disposed(by: disposeBag)
    }

    override func configureVC() {
        navigationItem.titleView = titleLabel

        nextButtonDidTap()
    }

    override func addView() {
        view.addSubViews(volleyballButton, badmintonButton, basketballButton,
                         soccerButton, nextButton, launchButton, dinnerButton)
    }

    override func setLayout() {
        volleyballButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(70)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(210)
            $0.height.equalTo(61)
        }

        badmintonButton.snp.makeConstraints {
            $0.top.equalTo(volleyballButton.snp.bottom).offset(31)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(210)
            $0.height.equalTo(61)
        }

        basketballButton.snp.makeConstraints {
            $0.top.equalTo(badmintonButton.snp.bottom).offset(31)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(210)
            $0.height.equalTo(61)
        }

        soccerButton.snp.makeConstraints {
            $0.top.equalTo(basketballButton.snp.bottom).offset(31)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(210)
            $0.height.equalTo(61)
        }

        launchButton.snp.makeConstraints {
            $0.top.equalTo(soccerButton.snp.bottom).offset(31)
            $0.leading.equalToSuperview().offset(70)
            $0.width.equalTo(100)
            $0.height.equalTo(61)
        }

        dinnerButton.snp.makeConstraints {
            $0.top.equalTo(soccerButton.snp.bottom).offset(31)
            $0.trailing.equalToSuperview().inset(70)
            $0.width.equalTo(100)
            $0.height.equalTo(61)
        }

        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(29)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(29)
            $0.height.equalTo(62)
        }
    }
}
