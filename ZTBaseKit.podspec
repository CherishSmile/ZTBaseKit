#
# Be sure to run `pod lib lint ZTBaseKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZTBaseKit'
  s.version          = '1.0.26'
  s.summary          = 'ZTBaseKit is the basic framework of OC project.'
  s.homepage         = 'https://github.com/CherishSmile/ZTBaseKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CherishSmile' => 'misteralvin@yeah.net' }
  s.source           = { :git => 'https://github.com/CherishSmile/ZTBaseKit.git', :tag => s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.requires_arc = true
  s.pod_target_xcconfig = {
    'VALID_ARCHS' => 'x86_64 armv7 arm64'
  }

  s.default_subspec = ['ZTBase','ZTBaseView','ZTAttributedLabel','ZTTextView','ZTBadgeView','ZTCollectionView','ZT3DBannerView','ZTAlertController','ZTRequest','ZTThirdLibCategories','ZTFileManager']
    
  s.subspec 'ZTBase' do |base|
    base.vendored_frameworks = 'ZTBaseKit/ZTBase/ZTBase.framework'
  end

  s.subspec 'ZTAttributedLabel' do |al|
    al.vendored_frameworks = 'ZTBaseKit/ZTAttributedLabel/ZTAttributedLabel.framework'
  end
  
  s.subspec 'ZTTextView' do |tv|
    tv.vendored_frameworks = 'ZTBaseKit/ZTTextView/ZTTextView.framework'
  end
  
  s.subspec 'ZTBadgeView' do |tlc|
    tlc.vendored_frameworks = 'ZTBaseKit/ZTBadgeView/ZTBadgeView.framework'
  end
  
  s.subspec 'ZTCollectionView' do |cv|
    cv.vendored_frameworks = 'ZTBaseKit/ZTCollectionView/ZTCollectionView.framework'
  end
  
  s.subspec 'ZTAlertController' do |ac|
    ac.vendored_frameworks = 'ZTBaseKit/ZTAlertController/ZTAlertController.framework'
    ac.resource = 'ZTBaseKit/ZTAlertController/ZTAlertController.bundle'
    ac.dependency 'ZTBaseKit/ZTBase'
    ac.dependency 'ZTBaseKit/ZTAttributedLabel'
    ac.dependency 'Masonry'
    ac.dependency 'SDWebImage'
    ac.dependency 'SDWebImage/GIF'
    ac.dependency 'SDWebImage/WebP'
  end
  
  s.subspec 'ZTRequest' do |nw|
    nw.vendored_frameworks = 'ZTBaseKit/ZTRequest/ZTRequest.framework'
    nw.dependency 'ZTBaseKit/ZTBase'
    nw.dependency 'AFNetworking'
  end
  
  s.subspec 'ZTBaseView' do |bv|
    bv.vendored_frameworks = 'ZTBaseKit/ZTBaseView/ZTBaseView.framework'
    bv.resource = 'ZTBaseKit/ZTBaseView/ZTBaseView.bundle'
    bv.dependency 'ZTBaseKit/ZTBase'
    bv.dependency 'DZNEmptyDataSet'
    bv.dependency 'MJRefresh'
    bv.dependency 'Masonry'
    bv.dependency 'KMNavigationBarTransition'
  end
  
  s.subspec 'ZTThirdLibCategories' do |tlc|
    tlc.vendored_frameworks = 'ZTBaseKit/ZTThirdLibCategories/ZTThirdLibCategories.framework'
    tlc.dependency 'SDWebImage'
    tlc.dependency 'SDWebImage/GIF'
    tlc.dependency 'SDWebImage/WebP'
  end
  
  s.subspec 'ZT3DBannerView' do |dbv|
    dbv.vendored_frameworks = 'ZTBaseKit/ZT3DBannerView/ZT3DBannerView.framework'
    dbv.dependency 'ZTBaseKit/ZTBase'
    dbv.dependency 'ZTBaseKit/ZTThirdLibCategories'
  end
  
  s.subspec 'ZTFileManager' do |fm|
    fm.vendored_frameworks = 'ZTBaseKit/ZTFileManager/ZTFileManager.framework'
  end
  
  s.subspec 'ZTLogManager' do |lm|
    lm.vendored_frameworks = 'ZTBaseKit/ZTLogManager/ZTLogManager.framework'
    lm.resource = 'ZTBaseKit/ZTLogManager/ZTLogManager.bundle'
  end
  
  s.subspec 'ZTScanViewController' do |sc|
    sc.vendored_frameworks = 'ZTBaseKit/ZTScanViewController/ZTScanViewController.framework'
    sc.resource = 'ZTBaseKit/ZTScanViewController/ZTScanViewController.bundle'
  end
  
end
