import UIKit
import RxSwift
import RxCocoa

class ListViewModel: BaseViewModel {
    private let schoolListSubject = PublishSubject<[MatchInfo]>()

    var schoolListObservable: Observable<[MatchInfo]> {
        return schoolListSubject.asObservable()
    }

    func updateSchoolList(match: [MatchInfo]) {
        schoolListSubject.onNext(match)
    }
}
