import UIKit
import RxSwift
import RxCocoa

class ListViewController: BaseVC<ListViewModel> {

    private let disposeBag = DisposeBag()

    private let viewBounds = UIScreen.main.bounds

    private lazy var addMatchButton = UIButton().then {
        $0.imageView?.contentMode = .scaleAspectFit
        $0.backgroundColor = .clear
        $0.setImage(UIImage(systemName: "plus.app"), for: .normal)
    }

    private let titleLabel = UILabel().then {
        $0.text = "ZOO"
        $0.font = .systemFont(ofSize: 28, weight: .bold)
        $0.updateGradientTextColor_horizontal(gradientColors:
            [UIColor.rgb(red: 138, green: 255, blue: 213),
             UIColor.rgb(red: 147, green: 144, blue: 255)])
    }

    private let verticalFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .vertical
        $0.minimumLineSpacing = 66
        $0.itemSize = CGSize(width: 335, height: 230)
    }

    private lazy var matchListCollectionView =
    UICollectionView(frame: .zero, collectionViewLayout: verticalFlowLayout).then {
        $0.backgroundColor = .clear
        $0.clipsToBounds = true
        $0.register(MatchListCollectionViewCell.self, forCellWithReuseIdentifier: MatchListCollectionViewCell.id)
    }

    func bindViewModel() {
        viewModel.schoolListObservable
            .bind(to: matchListCollectionView.rx.items(
                    cellIdentifier: MatchListCollectionViewCell.id,
                    cellType: MatchListCollectionViewCell.self)) { (_, match, cell) in

                        cell.changeCellNameData(with: [match])
                        print([match])
            }
            .disposed(by: disposeBag)
    }

    private func scaleImage(_ image: UIImage, toSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage?.withRenderingMode(.alwaysOriginal)
    }

    private func loadData() {
        let newMatchList = [
            MatchInfo(firstPlayer: "오종진", secondPlayer: "박서준", event: "축구 ⚽️", schedule: "456"),
            MatchInfo(firstPlayer: "강민제", secondPlayer: "김도현", event: "배드민턴 🏸", schedule: "789"),
            MatchInfo(firstPlayer: "정은성", secondPlayer: "백혜인", event: "배구 🏐", schedule: "789")
        ]

        viewModel.updateSchoolList(match: newMatchList)
    }

    private func setButtonImage() {
        if let originalImage = addMatchButton.image(for: .normal) {
            let scaledImage = scaleImage(originalImage, toSize: CGSize(width: 42, height: 40))

            let tintedImage = scaledImage?.withRenderingMode(.alwaysTemplate)
            addMatchButton.setImage(tintedImage, for: .normal)
            addMatchButton.tintColor = .gray
        }
    }

    private func addMatchButtonDidTap() {
        addMatchButton.rx.tap
            .bind(with: self) { owner, _ in
                let nextVC = ListViewController(viewModel: ListViewModel())
                owner.navigationController?.pushViewController(nextVC, animated: true)
            }.disposed(by: disposeBag)
    }

    override func configureVC() {
        matchListCollectionView.delegate = self

        setButtonImage()
        bindViewModel()
        loadData()
    }

    override func addView() {
        view.addSubViews(titleLabel, addMatchButton, matchListCollectionView)
    }

    override func setLayout() {

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.centerX.equalToSuperview()
        }

        addMatchButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(12)
            $0.trailing.equalToSuperview().inset(30)
            $0.size.equalTo(30)
        }

        matchListCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(80)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.equalTo(view.safeAreaLayoutGuide)
            $0.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
    }
}

extension UIImage {
    func scaleImage(_ image: UIImage, toSize size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        image.draw(in: CGRect(origin: .zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage?.withRenderingMode(.alwaysOriginal)
    }
}
