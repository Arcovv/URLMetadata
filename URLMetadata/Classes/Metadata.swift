import Kanna

public struct Metadata {
  public let name: String?
  public let property: String?
  public let content: String?
  public let value: String?
}

extension Array where Element == Metadata {
  
  public func findContent(
    by contentKey: KeyPath<Element, String?>,
    firstSearch name: String?,
    plugins: [MetaPropertyPlugin])
    -> String?
  {
    for ele in self {
      // Most of the result, "content" attribute is the goal.
      // But in here, this method also can search attribute
      // like "name", "property"
      guard let content = ele[keyPath: contentKey] else {
        continue
      }
      
      // Try to search the result from the "name" attribute
      if let eleName = ele.name, let name = name, eleName == name {
        return content
      }
      
      // Try to search the result by
      // mapping plugin rawValue with "property" attribute,
      // then return the first searching result
      let searchingResult = plugins
        .filter { $0.rawValue == ele.property }
        .first
        .map { _ in content }
      
      // If can not search the result, this metadata do not have the
      // information we needed. So just continue
      guard let result = searchingResult else {
        continue
      }
      
      return result
    }
    
    return nil
  }
  
  public var title: String? {
    return findContent(
      by: \.content,
      firstSearch: "name",
      plugins: [MetaProperty.OG.title, MetaProperty.Twitter.title]
    )
  }
  
  public var contentDescription: String? {
    return findContent(
      by: \.content,
      firstSearch: "description",
      plugins: [
        MetaProperty.OG.description,
        MetaProperty.Twitter.description
      ]
    )
  }
  
  public var url: String? {
    return findContent(
      by: \.content,
      firstSearch: nil,
      plugins: [MetaProperty.OG.url]
    )
  }
  
  public var imageUrl: String? {
    return findContent(
      by: \.content,
      firstSearch: nil,
      plugins: [
        MetaProperty.OG.imageUrl,
        MetaProperty.Twitter.imageUrl
      ]
    )
  }
  
}

public protocol MetaPropertyPlugin {
  var rawValue: String { get }
}

public enum MetaProperty {
  public enum OG: String, MetaPropertyPlugin {
    case title = "og:title"
    case siteName = "og:site_name"
    case contentType = "og:type"
    case description = "og:description"
    case url = "og:url"
    case imageUrl = "og:image"
  }
  
  public enum Twitter: String, MetaPropertyPlugin {
    case title = "twitter:title"
    case description = "twitter:description"
    case imageUrl = "twitter:image:src"
  }
}
