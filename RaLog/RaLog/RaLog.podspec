# pod lib lint --verbose --allow-warnings RaLog.podspec
# pod trunk push --verbose --allow-warnings RaLog.podspec

Pod::Spec.new do |s|
  
  s.name             = 'RaLog'
  
  s.version          = '1.0.0'
  
  s.summary          = ''
  
  s.description      = ''
  
  s.homepage         = 'https://github.com/rakuyoMo/RaLog'
  
  s.license          = 'MIT'
  
  s.author           = { 'Rakuyo' => 'rakuyo.mo@gmail.com' }
  
  s.source           = { :git => 'https://github.com/rakuyoMo/RaLog.git', :tag => s.version.to_s }
  
  s.requires_arc     = true
  
  s.platform         = :ios, '10.0'
  
  s.swift_version    = '5.0'
  
  s.static_framework = true
  
  s.module_name      = 'RaLog'
  
  s.source_files     = 'RaLog/RaLog/Core/*'
  
end
