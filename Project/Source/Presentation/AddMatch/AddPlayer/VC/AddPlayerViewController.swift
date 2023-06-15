import UIKit
import RxCocoa
import RxSwift

class AddPlayerViewController: BaseVC<AddPlayerViewModel> {

    private let disposeBag = DisposeBag()

    private let titleLabel = UILabel().then {
        $0.text = "게시물 생성"
        $0.font = .systemFont(ofSize: 21, weight: .bold)
        $0.updateGradientTextColor_horizontal(gradientColors:
            [UIColor.rgb(red: 138, green: 255, blue: 213),
             UIColor.rgb(red: 147, green: 144, blue: 255)])
    }

    private let descriptionLabel = UILabel().then {
        $0.text = "선수(팀 대표) 입력"
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
    }

    private lazy var firstProfileCardButton = ProfileCardButton().then {
        $0.tag = 0
        $0.addTarget(self, action: #selector(setCardButtonDidTap(_:)), for: .touchUpInside)
    }

    private lazy var secondProfileCardButton = ProfileCardButton().then {
        $0.tag = 1
        $0.addTarget(self, action: #selector(setCardButtonDidTap(_:)), for: .touchUpInside)
    }

    private let nextButton = GradientButton().then {
        $0.setTitle("다음", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 21, weight: .semibold)
    }

    @objc private func setCardButtonDidTap(_ sender: UIButton) {
        let alert = UIAlertController(title: "선수", message: "선수(팀 대표)를 입력해주세요.(1~8 글자)", preferredStyle: .alert)
        alert.addTextField()

        let okAlert = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            switch sender.tag {
            case 0:
                self?.firstProfileCardButton.playerNameLabel.text = alert.textFields?[0].text
            case 1:
                self?.secondProfileCardButton.playerNameLabel.text = alert.textFields?[0].text
            default:
                return
            }
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel)

        alert.addAction(okAlert)
        alert.addAction(cancel)

        self.present(alert, animated: true)
    }

    private func nextButtonDidTap() {
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                let nextVC = AddMatchInfoViewController(viewModel: AddMatchInfoViewModel())
                nextVC.matchInfo.firstPlayer = self.firstProfileCardButton.playerNameLabel.text ?? ""
                nextVC.matchInfo.secondPlayer = self.secondProfileCardButton.playerNameLabel.text ?? ""
                owner.navigationController?.pushViewController(nextVC, animated: true)
            }.disposed(by: disposeBag)
    }

    override func configureVC() {
        navigationItem.titleView = titleLabel
        nextButtonDidTap()
    }

    override func addView() {
        view.addSubViews(descriptionLabel, firstProfileCardButton, secondProfileCardButton, nextButton)
    }

    override func setLayout() {
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(139)
            $0.leading.equalToSuperview().offset(29)
        }

        firstProfileCardButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.equalTo(descriptionLabel.snp.leading)
            $0.width.equalTo(150)
            $0.height.equalTo(210)
        }

        secondProfileCardButton.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(29)
            $0.width.equalTo(150)
            $0.height.equalTo(210)
        }

        nextButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(29)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(29)
            $0.height.equalTo(62)
        }
    }
}
