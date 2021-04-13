//
//  GeneralSearchAgent.swift
//  VENI VIDI
//
//  Created by 雲無心 on 3/29/21.
//

import Foundation

class GeneralSearchAgent {
    let deletage: GeneralSearchAgentDeletage? = nil

    let searchAgents: [DatabaseSpecificSearchAgent] = [GoogleBooksSearchAgent(), TMDBMovieSearchAgent(), IGDBSearchAgent()]
}
