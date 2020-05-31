//
//  AddTVShowViewController.swift
//  TVShowManager
//
//  Created by Alexander Timonenkov on 30.05.2020.
//  Copyright © 2020 ATi Soft. All rights reserved.
//

import UIKit

protocol IAddTVShowViewController: UIViewController {
    func showError(viewModel: TVShowViewModel)
    func goBack()
}

final class AddTVShowViewController: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var seasonsNumberTextField: UITextField!
    @IBOutlet weak var saveButton: ActionButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private let interactor: IAddTVShowInteractor
    private let routerScenario: IHomeRouterScenario

    init(interactor: IAddTVShowInteractor,
         router: IHomeRouterScenario) {
        self.interactor = interactor
        routerScenario = router
        super.init(nibName: AddTVShowViewController.nameOfClass(), bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "add_tv_show_view_controller.title".localized

        titleTextField.placeholder = "add_tv_show_view_controller.title_textfield.placeholder".localized
        yearTextField.placeholder = "add_tv_show_view_controller.year_textfield.placeholder".localized
        seasonsNumberTextField.placeholder = "add_tv_show_view_controller.seasons_textfield.placeholder".localized

        updateUI(saveState: .dataInvalid)
    }
}

// MARK: - IAddTVShowViewController

extension AddTVShowViewController: IAddTVShowViewController {
    func showError(viewModel: TVShowViewModel) {
        validateSaveButtonAvailability(title: titleTextField.text, year: yearTextField.text, seasons: seasonsNumberTextField.text)
        showSimpleAlert(title: viewModel.errorTitle, message: viewModel.errorMessage)
    }

    func goBack() {
        clearAll()
        validateSaveButtonAvailability(title: titleTextField.text, year: yearTextField.text, seasons: seasonsNumberTextField.text)
        routerScenario.goToHome(from: self)
    }
}

// MARK: - IBActions

private extension AddTVShowViewController {
    @IBAction func saveButtonDidPress(_ sender: Any) {
        updateUI(saveState: .savingInProgress)

        interactor.createTVShow(title: titleTextField.text, year: yearTextField.text, seasons: seasonsNumberTextField.text)
    }
}

// MARK: - UITextFieldDelegate

extension AddTVShowViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        let title = textField == titleTextField ? newString : titleTextField.text
        let year = textField == yearTextField ? newString : yearTextField.text
        let seasons = textField == seasonsNumberTextField ? newString : seasonsNumberTextField.text
        validateSaveButtonAvailability(title: title, year: year, seasons: seasons)
        return true
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == titleTextField {
            yearTextField.becomeFirstResponder()
        } else if textField == yearTextField {
            seasonsNumberTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
}

// MARK: - Private

private extension AddTVShowViewController {
    private enum SaveState {
        case dataInvalid, canBeSaved, savingInProgress
    }

    private func updateUI(saveState: SaveState) {
        var buttonTitle = "add_tv_show_view_controller.save_button.title".localized
        var buttonIsEnabled = true
        var indicatorVisible = false

        switch saveState {
        case .dataInvalid:
            buttonIsEnabled = false
        case .canBeSaved:
            buttonIsEnabled = true
            break
        case .savingInProgress:
            buttonIsEnabled = false
            indicatorVisible = true
            buttonTitle = ""
        }

        saveButton.setTitle(buttonTitle, for: .normal)
        saveButton.isEnabled =  buttonIsEnabled
        activityIndicator.isHidden = !indicatorVisible
    }

    func validateSaveButtonAvailability(title: String?, year: String?, seasons: String?) {
        let canBeSaved = interactor.isDataValid(title: title, year: year, seasons: seasons)
        updateUI(saveState: canBeSaved ? .canBeSaved : .dataInvalid)
    }

    func clearAll() {
        titleTextField.text = ""
        yearTextField.text = ""
        seasonsNumberTextField.text = ""
    }
}
