# pod lib lint --verbose --allow-warnings RaLogRouter.podspec
# pod trunk push --verbose --allow-warnings RaLogRouter.podspec

Pod::Spec.new do |s|
  
  s.name             = 'RaLogRouter'
  
  s.version          = '1.0.0-Router'
  
  s.summary          = 'MBCore RaLog 的路由库。'
  
  s.description      = 'MBCore RaLog 的路由库。包含 该库的 路由接口。'
  
  s.homepage         = 'https://git.pettyb.com/iOSModule//RaLog'
  
  s.license          = 'MIT'
  
  s.author           = { 'Rakuyo' => 'wugaoyu@mbcore.com' }
  
  s.source           = { :git => 'https://git.pettyb.com/iOSModule//RaLog.git', :tag => s.version.to_s }
  
  s.requires_arc     = true
  
  s.platform         = :ios, '10.0'
  
  s.swift_version    = '5.0'
  
  s.static_framework = true
  
  s.module_name      = 'RaLogRouter'
  
  s.source_files     = 'RaLogRouter/RaLogRouter/Router/'
  
  s.dependency 'RaRouter'
  
end
