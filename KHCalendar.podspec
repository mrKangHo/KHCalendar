#
# Be sure to run `pod lib lint KHCalendar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'KHCalendar'
  s.version          = '0.1.2'
  s.summary          = '달력 데이터 모델 입니다.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'TableView, CollectionView에서 사용할 목적으로 만들었습니다.'
  s.swift_versions   = '4.2'
  s.homepage         = 'https://github.com/mrKangHo/KHCalendar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '이강호' => 'coke8707@gmail.com' }
  s.source           = { :git => 'https://github.com/mrKangHo/KHCalendar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'KHCalendar/Classes/**/*'
  
  # s.resource_bundles = {
  #   'KHCalendar' => ['KHCalendar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
