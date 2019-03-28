Pod::Spec.new do |s|
  s.name             = 'ZTBase'
  s.version          = '0.1.45'
  s.summary          = 'ZTBase is the basic framework of OC project.'
  s.homepage         = 'https://github.com/CherishSmile/ZTBase'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ZWL' => '1332291552@qq.com' }
  s.source           = { :git => 'https://github.com/CherishSmile/ZTBase.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.requires_arc = true
  
  
  
  s.subspec 'Utilities' do |uti|
    uti.source_files = 'ZTBase/Utilities/**/*.{h,m}'
    uti.public_header_files = 'ZTBase/Utilities/**/*.h'
    uti.dependency 'ZTBase/Core'
  end
  
  s.subspec 'ZTBase' do |base|
    base.source_files = 'ZTBase/ZTBase/**/*.{h,m}'
    base.public_header_files = 'ZTBase/ZTBase/**/*.h'
    base.dependency 'ZTBase/Core'
  end
  
  s.resource_bundles = {'ZTBase' => ['ZTBase/**/*.{txt,png}']}
  
  s.dependency 'AFNetworking'
  s.dependency 'MJRefresh'
  s.dependency 'MJExtension'
  s.dependency 'Masonry'
  s.dependency 'IQKeyboardManager'
  s.dependency 'SDWebImage'
  s.dependency 'MBProgressHUD'
  s.dependency 'KMNavigationBarTransition'
  s.dependency 'DZNEmptyDataSet'

end
