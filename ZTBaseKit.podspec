#
# Be sure to run `pod lib lint ZTBaseKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZTBaseKit'
  s.version          = '0.7.9'
  s.summary          = 'ZTBaseKit is the basic framework of OC project.'
  s.homepage         = 'https://github.com/CherishSmile/ZTBaseKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CherishSmile' => 'misteralvin@yeah.net' }
  s.source           = { :git => 'https://github.com/CherishSmile/ZTBaseKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  
  
  s.source_files = 'ZTBaseKit/ZTBaseKit.framework/Headers/*.{h}'
  s.vendored_frameworks = 'ZTBaseKit/ZTBaseKit.framework'
  s.public_header_files = 'ZTBaseKit/ZTBaseKit.framework/Headers/*.{h}'
  s.resource = 'ZTBaseKit/ZTBaseKit.framework/Resource.bundle'

  s.dependency 'AFNetworking'
  s.dependency 'MJRefresh'
  s.dependency 'MJExtension'
  s.dependency 'Masonry'
  s.dependency 'IQKeyboardManager'
  s.dependency 'SDWebImage'
  s.dependency 'SDWebImage/GIF'
  s.dependency 'SDAutoLayout'
  s.dependency 'MBProgressHUD'
  s.dependency 'KMNavigationBarTransition'
  s.dependency 'DZNEmptyDataSet'

end
