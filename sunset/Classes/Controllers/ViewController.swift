import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var headerPrevBtn: UIBarButtonItem!
    @IBOutlet weak var headerNextBtn: UIBarButtonItem!

    let appDelegate: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    let formatter = DateFormatter()
    let TapPrevBtnNotification = Notification.Name("TapPrevBtn")
    let TapNextBtnNotification = Notification.Name("TapNextBtn")
    let gradationView: GradationView = GradationView(topColor: UIColor.darkOrange(), bottomColor: UIColor.lightIndigo())

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let formatter = DateFormatter()
        // 初期値 (今日の日付を元に、navigationBarのタイトルを決める)
        formatter.dateFormat = "MMM yyyy"
        self.title = formatter.string(from: Date())
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        gradationView.addGradation(view: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func tappedPrevMonthBtn(_ sender: UIButton) {
        let thisDate = generateTargetDate()
        let prevDate: Date = formatter.date(from: thisDate)!.monthAgoDate()
        appDelegate.targetDate = formatter.string(from: prevDate)
        NotificationCenter.default.post(name: TapPrevBtnNotification, object: nil)
    }
    
    @IBAction func tappedNextMonthBtn(_ sender: UIButton) {
        let thisDate = generateTargetDate()
        let nextDate: Date = formatter.date(from: thisDate)!.monthLaterDate()
        appDelegate.targetDate = formatter.string(from: nextDate)
        NotificationCenter.default.post(name: TapNextBtnNotification, object: nil)
    }
    
    private func generateTargetDate() -> String {
        formatter.dateFormat = "yyyy-MM-dd"
        let thisDate = appDelegate.targetDate
        let year:String = (thisDate?.components(separatedBy: "-")[0])!
        let month:String = (thisDate?.components(separatedBy: "-")[1])!
        let day:String = (thisDate?.components(separatedBy: "-")[2])!
        
        let thisDateString = year + "-" + month + "-" + day
        return thisDateString
    }
    
}

