#
# Be sure to run `pod lib lint PureNavigationPath.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PureNavigationPath'
  s.version          = '1.1.0'
  s.summary          = 'A pure usage of NavigationPath in SwiftUI'

  s.description      = <<-DESC
PureNavigationPath is a Swift library designed to simplify navigation in iOS applications. It provides a straightforward and intuitive API for managing and visualizing navigation paths, making it easier to handle complex navigation flows in your app. With PureNavigationPath, you can effortlessly manage navigation states, track user progress, and implement custom transitions with minimal code. Ideal for developers looking to enhance their app's navigation experience.
                       DESC

  s.homepage         = 'https://github.com/hosituan/PureNavigationPath'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hosituan' => 'hosituan.work@gmail.com' }
  s.source           = { :git => 'https://github.com/hosituan/PureNavigationPath.git', :tag => s.version.to_s }
  s.social_media_url = 'https://www.linkedin.com/in/hosituan/'

  s.ios.deployment_target = '16.0'

  s.source_files = 'PureNavigationPath/Classes/**/*'
end
