//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

protocol ReusableViewType {
    static var reuseIdentifier: String { get }
}

extension ReusableViewType {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UIView: ReusableViewType {

    class public func autolayoutView<T: UIView>() -> T {
        let result = T(frame: CGRect.zero)
        result.translatesAutoresizingMaskIntoConstraints = false
        return result
    }
}

@objc protocol CellDelegate {
    func changeRed(_ cell: Cell)
    func changeGreen(_ cell: Cell)
    func changeBlue(_ cell: Cell)
}

class Cell: UITableViewCell {
    
    let redButton: UIButton = {
        let button: UIButton = UIButton.autolayoutView()
        button.setTitle("Red", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        return button
    }()
    
    let greenButton: UIButton = {
        let button: UIButton = UIButton.autolayoutView()
        button.setTitle("Green", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        return button
    }()
    
    let blueButton: UIButton = {
        let button: UIButton = UIButton.autolayoutView()
        button.setTitle("Blue", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup() {
        self.selectionStyle = .none
        self.contentView.backgroundColor = .red
        self.redButton.addTarget(self, action: #selector(self.changeRed(_:)), for: .touchUpInside)
        self.greenButton.addTarget(self, action: #selector(self.changeGreen(_:)), for: .touchUpInside)
        self.blueButton.addTarget(self, action: #selector(self.changeBlue(_:)), for: .touchUpInside)
        
        let stackView: UIStackView = UIStackView.autolayoutView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 20
        stackView.addArrangedSubview(self.redButton)
        stackView.addArrangedSubview(self.greenButton)
        stackView.addArrangedSubview(self.blueButton)
        
        self.contentView.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor)
        ])
    }
    
    func changeRed(_ sender: UIButton) {
        UIApplication.shared.sendAction(#selector(CellDelegate.changeRed(_:)), to: .none, from: self, for: .none)
    }
    
    func changeGreen(_ sender: UIButton) {
        UIApplication.shared.sendAction(#selector(CellDelegate.changeGreen(_:)), to: .none, from: self, for: .none)
    }
    
    func changeBlue(_ sender: UIButton) {
        UIApplication.shared.sendAction(#selector(CellDelegate.changeBlue(_:)), to: .none, from: self, for: .none)
    }
    
}

class ViewController: UITableViewController, CellDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(Cell.self, forCellReuseIdentifier: Cell.reuseIdentifier)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: Cell.reuseIdentifier, for: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return self.responds(to: action)
    }
    
    func changeRed(_ cell: Cell) {
        cell.contentView.backgroundColor = .red
    }
    
    func changeGreen(_ cell: Cell) {
        cell.contentView.backgroundColor = .green
    }
    
    func changeBlue(_ cell: Cell) {
        cell.contentView.backgroundColor = .blue
    }
}

let viewController: ViewController = ViewController(nibName: .none, bundle: .none)
PlaygroundPage.current.liveView = viewController.view
