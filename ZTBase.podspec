Pod::Spec.new do |s|
  s.name             = 'ZTBase'
  s.version          = '0.3.3'
  s.summary          = 'ZTBase is the basic framework of OC project.'
  s.homepage         = 'https://github.com/CherishSmile/ZTBase'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CherishSmile' => 'misteralvin@yeah.net' }
  s.source           = { :git => 'https://github.com/CherishSmile/ZTBase.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  
  s.subspec 'Core' do |core|
    core.source_files = 'ZTBase/Core/**/*.{h,m}'
    core.public_header_files = 'ZTBase/Core/**/*.h'
  end
  
  s.subspec 'Utilities' do |uti|
    uti.source_files = 'ZTBase/Utilities/**/*.{h,m}'
    uti.public_header_files = 'ZTBase/Utilities/**/*.h'
    uti.dependency 'ZTBase/Core'
  end
  
  s.resource_bundles = {'ZTBase' => ['ZTBase/**/*.{png,caf}']}
  
  s.dependency 'AFNetworking'
  s.dependency 'MJRefresh'
  s.dependency 'MJExtension'
  s.dependency 'Masonry'
  s.dependency 'IQKeyboardManager'
  s.dependency 'SDWebImage'
  s.dependency 'SDAutoLayout'
  s.dependency 'MBProgressHUD'
  s.dependency 'KMNavigationBarTransition'
  s.dependency 'DZNEmptyDataSet'

end
