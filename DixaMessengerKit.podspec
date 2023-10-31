#
# Be sure to run `pod lib lint DixaMessengerKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'DixaMessengerKit'
  s.version          = '1.6.7'
  s.summary          = 'DixaMessenger for iOS'
  
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Dixa Messenger SDK is used to add a messenger functionality to your app. Requires a Dixa subscription.'
  s.homepage         = 'https://dixa.com'
  #s.documentation_url = 'https://'
  s.license          = { :type => 'Commercial', :file => 'LICENSE' }
  s.author           = { 'andras' => 'ama@dixa.com' }
  s.source = { :http => "https://github.com/dixahq/ios-messenger/releases/download/#{s.version}/DixaMessenger.xcframework.zip" }
  s.vendored_frameworks = "DixaMessenger.xcframework"
  s.ios.deployment_target = '13.0'

end
