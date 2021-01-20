//
//  MessageViewViewModel.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 20.01.2021.
//

class MessageViewViewModel {
	init(with data: (title: String, content: String, type: MessageViewType, actions: [MessageViewActionModel])) {
		self.modelData = data
	}
	
	private let modelData: (title: String, content: String, type: MessageViewType, actions: [MessageViewActionModel])
	
	var selectedActionType: Publisher<MessageViewActionType?> = Publisher(nil)
}

extension MessageViewViewModel: MessageViewViewModelType {
	var title: String { return modelData.title }
	
	var content: String { return modelData.content }
	
	var type: MessageViewType { return modelData.type }
	
	var actions: [MessageViewActionModel] { return modelData.actions }
	
	var rowHeightValue: Float { return Constants.rowHeightValue * Float(modelData.actions.count) }
	
	func getTableViewCellViewModel(with index: Int) -> MessageViewTableViewCellViewModelType? { return MessageViewTableViewCellViewModel(for: actions[index]) }
	
	func setSelectedActionType(with index: Int) { selectedActionType.value = modelData.actions[index].actionType }
}

extension MessageViewViewModel: TableViewProviderViewModel {
	func numberOfTableSections() -> Int { return 1 }
	
	func numberOfTableRowsInSection(_ section: Int) -> Int { modelData.actions.count }
	
	func heightForRow(atIndex index: Int) -> Float { Constants.rowHeightValue }
}

extension MessageViewViewModel {
	private struct Constants {
		static let rowHeightValue: Float = 50
	}
}
