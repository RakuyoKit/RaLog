# pod lib lint --verbose --allow-warnings RaLog.podspec
# pod trunk push --verbose --allow-warnings RaLog.podspec

Pod::Spec.new do |s|
  
  s.name             = 'RaLog'
  
  s.version          = '1.0.0'
  
  s.summary          = 'MBCore iOS 。'
  
  s.description      = 'MBCore iOS 。'
  
  s.homepage         = 'https://git.pettyb.com/iOSModule/RaLog'
  
  s.license          = 'MIT'
  
  s.author           = { 'Rakuyo' => 'wugaoyu@mbcore.com' }
  
  s.source           = { :git => 'https://git.pettyb.com/iOSModule/RaLog.git', :tag => s.version.to_s }
  
  s.requires_arc     = true
  
  s.platform         = :ios, '10.0'
  
  s.swift_version    = '5.0'
  
  s.static_framework = true
  
  s.module_name      = 'RaLog'
  
  s.source_files     = 'RaLog/RaLog/Core/*', 'RaLog/RaLog/Router/*'
  
  s.dependency 'RaLogRouter', '>= 1.0.0-Router'
  
end
