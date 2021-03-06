#
# Be sure to run `pod lib lint YCLJLib.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'YCLJLib'
    s.version          = '1.1.0'
    s.summary          = 'A short description of YCLJLib.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

    s.homepage         = 'https://github.com/infoyou/YCLJLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Adam' => 'infoyou@foxmail.com' }
    s.source           = { :git => 'https://github.com/infoyou/YCLJLib.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

#    s.prefix_header_contents = '#import "YCLJ_Header.h"'
    s.source_files = 'YCLJLib/Classes/**/*'
  
    s.resource_bundles = {
     'YCLJLib' => ['YCLJLib/Assets/*.png']
   }

    s.public_header_files = 'YCLJLib/Classes/**/*.h'
#s.public_header_files = 'Pod/Classes/**/*.h'
    s.frameworks = 'UIKit', 'MapKit'

    #dependency
    s.dependency 'ATMHud', '~> 0.0.1'
    s.dependency 'AFNetworking', '~> 2.3'
    s.dependency 'MRProgress', '~> 0.8'
    s.dependency 'MJRefresh', '~> 3.1.12'
#s.dependency 'Bugly', '~> 2.4.8'

end
