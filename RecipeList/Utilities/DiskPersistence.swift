//
//  DiskPersistence.swift
//  RecipeList
//
//  Created by Paul Jr Mesa on 1/28/25.
//

import Foundation

protocol PersistenceProtocol: Actor {
  func insert(key: String, data: Data)
  func get(key: String) -> Data?
}

actor DiskPersistence: PersistenceProtocol {
  struct Entry: Codable {
    let data: Data
    let expirationDate: Date
  }
  
  // time to persist in seconds
  private let ttl: Double
  private let directoryUrl: URL?
  private let directoryName = "imageDiskPersistence"
  private let encoder = JSONEncoder()
  private let decoder = JSONDecoder()
  
  init(ttl: Double) {
    self.ttl = ttl
    do {
      let url = try FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appending(path: directoryName)
      self.directoryUrl = url
      
      if !FileManager.default.fileExists(atPath: url.path()) {
        do {
          try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        } catch let error {
          print(error)
        }
      }
    } catch {
      print(error)
      self.directoryUrl = nil
    }
  }
  
  private func getUrl(for key: String) -> URL? {
    directoryUrl?.appending(path: key)
  }
  
  func insert(key: String, data: Data) {
    var expiration = Date()
    expiration.addTimeInterval(ttl)
    let entry = Entry(data: data, expirationDate: expiration)
    guard let url = getUrl(for: key) else {
      print("Failed to get url for \(key)")
      return
    }
    
    do {
      let entryData = try encoder.encode(entry)
      try entryData.write(to: url)
    } catch {
      print(error)
    }
  }
  
  func get(key: String) -> Data? {
    guard let url = getUrl(for: key) else {
      print("Failed to get url for \(key)")
      return nil
    }

    guard FileManager.default.fileExists(atPath: url.path()) else {
      return nil
    }

    do {
      let data = try Data(contentsOf: url)
      let entry = try decoder.decode(Entry.self, from: data)
      guard !(entry.expirationDate < Date()) else {
        do {
          try FileManager.default.removeItem(at: url)
        } catch {
          print(error)
        }
        return nil
      }
      return entry.data
    } catch {
      print(error)
      return nil
    }
  }
}
