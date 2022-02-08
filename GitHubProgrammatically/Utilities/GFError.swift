//
//  GFError.swift
//  GitHubProgrammatically
//
//  Created by Doğa Bayram on 4.02.2022.
//

import Foundation

enum GFError : String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection"
    case invalidResponse = "Invalid response from the server."
    case invalidData = "The data received from the server was invalid."
    case unableToFavorite = "There was an error favoriting this user. Please try again"
    case alreadyInFavorites = "You've already favorited this user. You must really like them!"
}
