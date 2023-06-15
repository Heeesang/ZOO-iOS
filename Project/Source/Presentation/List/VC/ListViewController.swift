import UIKit
import RxSwift
import RxCocoa

class ListViewController: BaseVC<ListViewModel> {

    private let disposeBag = DisposeBag()

    private let viewBounds = UIScreen.main.bounds

    let matchList = MatchListData.shared.newMatchList

    private lazy var addMatchButton = UIBarButtonItem(image: UIImage(systemName: "plus.app"),
                                                                     style: .plain,
                                                                     target: nil,
                                                                     action: nil).then {
                        $0.tintColor = .black
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

    private func loadData(match: [MatchInfo]) {
        viewModel.updateSchoolList(match: match)
    }

    private func setButtonImage() {
        if let originalImage = UIImage(systemName: "plus.app") {
            let scaledImage = scaleImage(originalImage, toSize: CGSize(width: 32, height: 30))

            let tintedImage = scaledImage?.withRenderingMode(.alwaysTemplate)
            addMatchButton.image = tintedImage
            addMatchButton.tintColor = .gray
        }
    }

    private func addMatchButtonDidTap() {
        addMatchButton.rx.tap
            .bind(with: self) { owner, _ in
                let nextVC = AddPlayerViewController(viewModel: AddPlayerViewModel())
                owner.navigationController?.pushViewController(nextVC, animated: true)
            }.disposed(by: disposeBag)
    }

    override func configureVC() {
        matchListCollectionView.delegate = self

        navigationController?.navigationBar.isHidden = false
        navigationItem.titleView = titleLabel
        navigationItem.rightBarButtonItem = addMatchButton

        addMatchButtonDidTap()
        setButtonImage()
        bindViewModel()
        loadData(match: matchList)
    }

    override func addView() {
        view.addSubViews(matchListCollectionView)
    }

    override func setLayout() {
        matchListCollectionView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
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
