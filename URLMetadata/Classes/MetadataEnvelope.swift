public struct MetadataEnvelope {
  public let rawUrl: URL
  public let rawValues: [Metadata]
  public internal(set) var title: String?
  public internal(set) var contentDescription: String?
  public internal(set) var imageUrl: String?
  public internal(set) var urlString: String?
}
