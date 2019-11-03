import Foundation
import Kanna

public final class MetadataManager {
  public let session: URLSession

  public init(session: URLSession) {
    self.session = session
  }
  
  public func fireRequest(
    _ requester: MetadataRequester,
    completionHandler: @escaping (Result<MetadataEnvelope, MetadataError>) -> Void)
  {
    let url = requester.url
    let task = session.dataTask(with: url) { [weak self] data, _, error in
      guard let self = self else { return }
      
      guard let data = data, error == nil else {
        completionHandler(.failure(MetadataError(url: url, error: error!)))
        return
      }
      
      do {
        let document = try Kanna.HTML(html: data, encoding: .utf8)
        guard let head = document.head else { return }

        let results = head.xpath("//meta").map { metadata in
          Metadata(
            name: metadata["name"],
            property: metadata["property"],
            content: metadata["content"],
            value: metadata["value"]
          )
        }

        let title = self.searchTitle(on: head)
          ?? results.title
        let contentDescription = self.searchContentDescription(on: head)
          ?? results.contentDescription
 
        let envelope = MetadataEnvelope(
          rawUrl: url,
          rawValues: results,
          title: title,
          contentDescription: contentDescription,
          imageUrl: results.imageUrl,
          urlString: results.urlString
        )
        
        completionHandler(.success(envelope))
      } catch {
        completionHandler(.failure(MetadataError(url: url, error: error)))
      }
    }
    
    task.resume()
  }
  
  func searchTitle(on element: XMLElement) -> String? {
    element.xpath("//title").first?.text
  }
  
  func searchContentDescription(on element: XMLElement) -> String? {
    element.xpath("//description").first?.text
  }
  
}
