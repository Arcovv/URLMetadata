extension Array where Element == Metadata {
  
  var title: String? {
    return findContent(
      by: \.content,
      firstSearch: "name",
      plugins: [MetaProperty.OG.title, MetaProperty.Twitter.title]
    )
  }
  
  var contentDescription: String? {
    return findContent(
      by: \.content,
      firstSearch: "description",
      plugins: [
        MetaProperty.OG.description,
        MetaProperty.Twitter.description
      ]
    )
  }
  
  var url: String? {
    return findContent(
      by: \.content,
      firstSearch: nil,
      plugins: [MetaProperty.OG.url]
    )
  }
  
  var imageUrl: String? {
    return findContent(
      by: \.content,
      firstSearch: nil,
      plugins: [
        MetaProperty.OG.imageUrl,
        MetaProperty.Twitter.imageUrl
      ]
    )
  }
  
  var urlString: String? {
    return findContent(
      by: \.content,
      firstSearch: nil,
      plugins: [MetaProperty.OG.url]
    )
  }
  
  func findContent(
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
  
}
