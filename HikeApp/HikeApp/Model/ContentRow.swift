//
//  ContentRow.swift
//  HikeApp
//
//  Created by Rudy Pangestu on 4/19/25.
//

import Foundation
import SwiftUI

struct ContentRow: Identifiable {
  var id: String { label }
  
  let label: String
  let icon: String
  let content: String
  let color: Color
}
