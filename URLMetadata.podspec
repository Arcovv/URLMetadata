#
# Be sure to run `pod lib lint URLMetadata.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'URLMetadata'
  s.version          = '0.1.0'
  s.summary          = 'A short description of URLMetadata.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Arcovv/URLMetadata'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Arco' => 'yiyezhihen@gmail.com' }
  s.source           = { :git => 'https://github.com/Arcovv/URLMetadata.git', :tag => s.version.to_s }
  s.swift_version    = '5.1'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'URLMetadata/Classes/**/*'
  
  # s.resource_bundles = {
  #   'URLMetadata' => ['URLMetadata/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Kanna', '~> 5.0.0'
  s.xcconfig = {
   'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2',
   'SWIFT_INCLUDE_PATHS' => '$(SRCROOT)/Kanna/Modules'
 }
end
