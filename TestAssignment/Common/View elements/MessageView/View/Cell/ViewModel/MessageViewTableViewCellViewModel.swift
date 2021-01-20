//
//  MessageViewTableViewCellViewModel.swift
//  TestAssignment
//
//  Created by Yaroslav Abaturov on 20.01.2021.
//

protocol MessageViewTableViewCellViewModelType {
	var title: String { get }
}

class MessageViewTableViewCellViewModel {
	init(for action: MessageViewActionModel) {
		self.action = action
	}
	
	private var action: MessageViewActionModel
}

extension MessageViewTableViewCellViewModel: MessageViewTableViewCellViewModelType {
	var title: String {
		return action.title
	}
}
