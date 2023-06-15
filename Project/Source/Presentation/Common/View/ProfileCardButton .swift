import UIKit

class ProfileCardButton: UIButton {
    private let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = UIImage(systemName: "person.crop.circle.fill")
        $0.tintColor = .gray
    }

    let playerNameLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .semibold)
        $0.text = "터치!"
    }

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

        addSubView()
        setLayout()
        configureUI()
    }

    // MARK: - Helpers
    private func configureUI() {
        self.backgroundColor = .white
        self.layer.cornerRadius = 20
        self.layer.borderWidth = 1
    }

    func addSubView() {
        addSubViews(profileImageView, playerNameLabel)
    }

    func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(30)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(75)
        }

        playerNameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
    }
}
