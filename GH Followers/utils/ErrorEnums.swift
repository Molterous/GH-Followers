//
//  ErrorEnums.swift
//  GH Followers
//
//  Created by Aakash Choudhary on 03/05/24.
//

import Foundation

enum GFError: String, Error {
    case invalidUserName    = "This username created an invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection."
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "Invalid data received from the server. Please try again."
}
