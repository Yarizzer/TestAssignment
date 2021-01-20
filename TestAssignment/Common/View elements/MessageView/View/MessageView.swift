//
//  MessageView.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 20.01.2021.
//

import UIKit

class MessageView: UIView {
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		setupView()
		setupConstraints()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		
		setupView()
		setupConstraints()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		guard let canvasView = canvasView, let tableView = tableView else { return }
		
		canvasView.layer.cornerRadius = Constants.elementsViewCornerRadiusValue
		canvasView.layer.masksToBounds = true
		
		tableView.layer.cornerRadius = Constants.elementsViewCornerRadiusValue
		tableView.layer.masksToBounds = true
	}
	
	private func setupView() {
		let blurEffect = UIBlurEffect(style: .dark)
		blurEffectView = UIVisualEffectView(effect: blurEffect)
		
		imageView = UIImageView()
		imageView?.image = UIImage(named: Constants.imageNameValue)
		imageView?.contentMode = .scaleAspectFit
		
		canvasView = UIView()
		
		titleLabel = UILabel()
		contentLabel = UILabel()
		
		tableView = UITableView()
		
		guard let blurEffectView = blurEffectView, let imageView = imageView, let canvasView = canvasView, let titleLabel = titleLabel, let contentLabel = contentLabel, let tableView = tableView else { return }
		
		blurEffectView.alpha = Constants.minAlphaValue
		tableView.alpha = Constants.minAlphaValue
		imageView.alpha = Constants.minAlphaValue
		
		canvasView.backgroundColor = AppCore.shared.appStyleManager.colorLightGray
		
		titleLabel.textAlignment = .center
		titleLabel.font = AppCore.shared.appStyleManager.labelTitleFontLarge
		titleLabel.minimumScaleFactor = Constants.labelMinScaleFactor
		titleLabel.adjustsFontSizeToFitWidth = true
		titleLabel.textColor = AppCore.shared.appStyleManager.colorDarkGray
		
		contentLabel.textAlignment = .center
		contentLabel.font = AppCore.shared.appStyleManager.labelTitleFontMedium
		contentLabel.minimumScaleFactor = Constants.labelMinScaleFactor
		contentLabel.adjustsFontSizeToFitWidth = true
		contentLabel.numberOfLines = 0
		contentLabel.textColor = AppCore.shared.appStyleManager.colorDarkGray
		
		addSubview(blurEffectView)
		addSubview(imageView)
		addSubview(canvasView)
		addSubview(tableView)
		
		canvasView.addSubview(titleLabel)
		canvasView.addSubview(contentLabel)
	}
	
	private func setupConstraints() {
		guard let blurEffectView = blurEffectView, let canvasView = canvasView, let imageView = imageView, let titleLabel = titleLabel, let contentLabel = contentLabel, let tableView = tableView else { return }
		
		let screenSize = AppCore.shared.appDeviceManager.screenSize
		
		blurEffectView.translatesAutoresizingMaskIntoConstraints = false
		imageView.translatesAutoresizingMaskIntoConstraints = false
		canvasView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		contentLabel.translatesAutoresizingMaskIntoConstraints = false
		tableView.translatesAutoresizingMaskIntoConstraints = false
		
		blurEffectView.topAnchor.constraint(equalTo: topAnchor).isActive = true
		blurEffectView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
		blurEffectView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
		blurEffectView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
		
		tableViewHeightConstraint = tableView.heightAnchor.constraint(equalToConstant: Constants.initialTableViewHeightConstraintValue)
		tableViewHeightConstraint?.isActive = true
		
		tableView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: screenSize.width * Constants.elementsXPaddingCoeffValue).isActive = true
		tableView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: screenSize.width * -Constants.elementsXPaddingCoeffValue).isActive = true
		tableView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.bottomPaddingValue).isActive = true
		
		canvasView.heightAnchor.constraint(equalToConstant: screenSize.width * Constants.elementsHeightCoeffValue).isActive = true
		canvasView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: screenSize.width * Constants.elementsXPaddingCoeffValue).isActive = true
		canvasView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: screenSize.width * -Constants.elementsXPaddingCoeffValue).isActive = true
		canvasView.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -Constants.elementsPaddingValue).isActive = true
		
		imageView.heightAnchor.constraint(equalToConstant: screenSize.width * Constants.elementsHeightCoeffValue).isActive = true
		imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: screenSize.width * Constants.elementsXPaddingCoeffValue).isActive = true
		imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: screenSize.width * -Constants.elementsXPaddingCoeffValue).isActive = true
		imageView.bottomAnchor.constraint(equalTo: canvasView.topAnchor, constant: -Constants.elementsPaddingValue).isActive = true
		
		titleLabel.topAnchor.constraint(equalTo: canvasView.topAnchor, constant: Constants.labelPaddingConstraintValue).isActive = true
		titleLabel.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor, constant: Constants.labelPaddingConstraintValue).isActive = true
		titleLabel.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor, constant: -Constants.labelPaddingConstraintValue).isActive = true
		titleLabel.heightAnchor.constraint(equalToConstant: (screenSize.width * Constants.elementsHeightCoeffValue) / 5).isActive = true
		
		contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
		contentLabel.leadingAnchor.constraint(equalTo: canvasView.leadingAnchor, constant: Constants.labelPaddingConstraintValue).isActive = true
		contentLabel.trailingAnchor.constraint(equalTo: canvasView.trailingAnchor, constant: -Constants.labelPaddingConstraintValue).isActive = true
		contentLabel.bottomAnchor.constraint(equalTo: canvasView.bottomAnchor, constant: -Constants.labelPaddingConstraintValue).isActive = true
	}
	
	func setup(with model: MessageViewViewModelType) {
		self.model = model
		
		guard let titleLabel = titleLabel, let contentLabel = contentLabel else { return }
		
		titleLabel.text = model.title
		contentLabel.text = model.content
		
		setupTableViewWithProvider()
	}
	
	private func setupTableViewWithProvider() {
		guard let tableView = tableView, let model = model, let heightConstraint = tableViewHeightConstraint else { return }
		
		tableView.backgroundColor = AppCore.shared.appStyleManager.colorClear
		tableView.separatorStyle = .none
		tableView.tableFooterView = UIView(frame: .zero)
		
		heightConstraint.constant = (model.actions.count > 3) ? Constants.maxTableViewHeightConstraintValue : CGFloat(model.rowHeightValue)
		
		layoutIfNeeded()
		
		provider = TableViewProvider(for: tableView, with: model as! MessageViewViewModel)
		provider?.registerCells([MessageViewTableViewCell.self])
		
		provider?.onConfigureCell = { [unowned self] indexPath in

			guard let provider = self.provider else { return UITableViewCell() }

			let tebleViewCell: MessageViewTableViewCell = provider.dequeueReusableCell(for: indexPath)

			guard let model = model.getTableViewCellViewModel(with: indexPath.row) else { return tebleViewCell }

			tebleViewCell.setup(with: model)

			return tebleViewCell
		}
		
		provider?.onSelectCell = { model.setSelectedActionType(with: $0.row) }
		
		provider?.reloadData()
	}
	
	func apear() {
		UIView.animate(withDuration: Constants.apearAnimationDuration / 2, delay: 0, options: [.curveEaseInOut]) { [unowned self] in
			blurEffectView?.alpha = Constants.blurEffectViewMaxAlphaValue
		} completion: { [unowned self] _ in
			UIView.animate(withDuration: Constants.apearAnimationDuration / 2, delay: 0, options: [.curveEaseInOut]) { [unowned self] in
				tableView?.alpha = Constants.maxAlphaValue
				imageView?.alpha = Constants.maxAlphaValue
			} completion: { [unowned self] _ in
				UIView.animate(withDuration: Constants.imageAnimationDuration, delay: 0, options: [.repeat, .autoreverse]) { [unowned self] in
					imageView?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
				}
			}
		}
	}
	
	func disapear() {
		UIView.animate(withDuration: Constants.apearAnimationDuration, delay: 0, options: [.curveEaseInOut]) { [unowned self] in
			blurEffectView?.alpha = Constants.minAlphaValue
			tableView?.alpha = Constants.minAlphaValue
			imageView?.alpha = Constants.minAlphaValue
		}
	}
	
	private var model: MessageViewViewModelType?
	private var provider: TableViewProvider?
	
	private var blurEffectView: UIVisualEffectView?
	private var canvasView: UIView?
	private var titleLabel: UILabel?
	private var contentLabel: UILabel?
	private var imageView: UIImageView?
	
	private var tableViewHeightConstraint: NSLayoutConstraint?
	private var tableView: UITableView?
}

extension MessageView {
	private struct Constants {
		static let minAlphaValue: CGFloat = 0.0
		static let maxAlphaValue: CGFloat = 1.0
		static let blurEffectViewMaxAlphaValue: CGFloat = 0.8
		static let imageNameValue = "MessageViewImage-universal"
		
		static let bottomPaddingValue: CGFloat = 120
		static let elementsXPaddingCoeffValue: CGFloat = 0.1
		static let elementsPaddingValue: CGFloat = 10
		static let initialTableViewHeightConstraintValue: CGFloat = 0
		static let maxTableViewHeightConstraintValue: CGFloat = 180
		static let elementsHeightCoeffValue: CGFloat = 0.3
		static let labelPaddingConstraintValue: CGFloat = 5
		
		static let elementsViewCornerRadiusValue: CGFloat = 10
		static let labelMinScaleFactor: CGFloat = 0.5
		
		//Animation
		static let apearAnimationDuration: Double = 1
		static let imageAnimationDuration: Double = 10
	}
}
