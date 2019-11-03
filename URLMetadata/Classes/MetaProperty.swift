public protocol MetaPropertyPlugin {
  var rawValue: String { get }
}

public enum MetaProperty {
  public enum OG: String, MetaPropertyPlugin {
    case title = "og:title"
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

