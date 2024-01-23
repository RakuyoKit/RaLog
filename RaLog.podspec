# pod lib lint --verbose --allow-warnings RaLog.podspec
# pod trunk push --verbose --allow-warnings RaLog.podspec

Pod::Spec.new do |s|
  
  s.name             = 'RaLog'
  
  s.version          = '1.7.1'
  
  s.summary          = 'A logging framework.'
  
  s.description      = 'A lightweight, highly customizable, protocol-oriented logging framework.'
  
  s.homepage         = 'https://github.com/RakuyoKit/RaLog'
  
  s.license          = 'MIT'
  
  s.author           = { 'Rakuyo' => 'rakuyo.mo@gmail.com' }
  
  s.source           = { :git => 'https://github.com/RakuyoKit/RaLog.git', :tag => s.version.to_s }
  
  s.requires_arc     = true

  s.ios.deployment_target     = '12.0'
  s.tvos.deployment_target    = '12.0'
  s.osx.deployment_target     = '10.14'
  s.watchos.deployment_target = '5.0'
  
  # Wait for CocoaPods 1.13.0 (visionOS support)
  # s.visionos.deployment_target = '1.0'
  
  s.swift_version    = '5.0'
  
  s.module_name      = 'RaLog'
  
  s.source_files     = 'Sources/**/*.swift'
  
  s.resource_bundles = { 'RaLog' => ['Sources/PrivacyInfo.xcprivacy'] }
  
end
