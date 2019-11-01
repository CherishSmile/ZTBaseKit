Pod::Spec.new do |s|
  s.name             = 'ZTBase'
  s.version          = '0.5.6'
  s.summary          = 'ZTBase is the basic framework of OC project.'
  s.homepage         = 'https://github.com/CherishSmile/ZTBase'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CherishSmile' => 'misteralvin@yeah.net' }
  s.source           = { :git => 'https://github.com/CherishSmile/ZTBase.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  
  
  s.source_files = 'ZTBase/ZTBaseKit.framework/Headers/*.{h}'
  s.vendored_frameworks = 'ZTBase/ZTBaseKit.framework'
  s.public_header_files = 'ZTBase/ZTBaseKit.framework/Headers/*.{h}'
  
#  s.dependency 'AFNetworking'
#  s.dependency 'MJRefresh'
#  s.dependency 'MJExtension'
#  s.dependency 'Masonry'
#  s.dependency 'IQKeyboardManager'
#  s.dependency 'SDWebImage'
#  s.dependency 'SDAutoLayout'
#  s.dependency 'MBProgressHUD'
#  s.dependency 'KMNavigationBarTransition'
#  s.dependency 'DZNEmptyDataSet'

end
