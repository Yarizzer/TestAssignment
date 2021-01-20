//
//  MessageViewViewModelContract.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 20.01.2021.
//

//MARK: - MessageViewType
enum MessageViewType {
	case info(content: String?)
	case failure(content: String?)
}

//MARK: - MessageViewActionModel
enum MessageViewActionType {
	case confirm
	case dismiss
}

struct MessageViewActionModel {
	var title: String
	var actionType: MessageViewActionType
}

protocol MessageViewViewModelType {
	var selectedActionType: Publisher<MessageViewActionType?> { get }
	
	var title: String { get }
	var content: String { get }
	var type: MessageViewType { get }
	var actions: [MessageViewActionModel] { get }
	var rowHeightValue: Float { get }
	
	func getTableViewCellViewModel(with index: Int) -> MessageViewTableViewCellViewModelType?
	func setSelectedActionType(with index: Int)
}
