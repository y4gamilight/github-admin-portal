import Foundation

class JSONFileHelper {
  static func readJSONFile<T: Decodable>(fileName: String,
                                         fileType: String = "json",
                                         bundle: Bundle = .main) -> T? {
    guard let url = bundle.url(forResource: fileName, withExtension: fileType) else {
      assertionFailure("Failed to locate \(fileName).\(fileType) in bundle.")
      return nil
    }
    
    do {
      let data = try Data(contentsOf: url)
      let decoder = JSONDecoder()
      let decodedData = try decoder.decode(T.self, from: data)
      return decodedData
    }  catch let error as DecodingError {
      assertionFailure("Failed to DecodingError \(fileName).\(fileType): \(error.localizedDescription)")
      return nil
    } catch {
      assertionFailure("Failed to dataLoadingFailed \(fileName).\(fileType): \(error.localizedDescription)")
      return nil
    }
  }
}
