#
# Be sure to run `pod lib lint HSBKeyboardNotification.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HSBKeyboardNotification'
  s.version          = '0.1.0'
  s.summary          = 'HSBKeyboardNotification support keyboard notification delegate.'
  s.swift_version    = '4.2'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
HSBKeyboardNotification support keyboard notification delegate.
Keyboard notification: willShow, willHide, willChange
                       DESC

  s.homepage         = 'https://github.com/hsb9kr/HSBKeyboardNotification'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Red' => 'hsb9kr@gmail.com' }
  s.source           = { :git => 'https://github.com/hsb9kr/HSBKeyboardNotification.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HSBKeyboardNotification/Classes/*.swift'
  
  # s.resource_bundles = {
  #   'HSBKeyboardNotification' => ['HSBKeyboardNotification/Assets/*.png']
  # }
  
  s.frameworks = 'UIKit'
end
