# pod lib lint --verbose --allow-warnings RaLog.podspec
# pod trunk push --verbose --allow-warnings RaLog.podspec

Pod::Spec.new do |s|
  
  s.name             = 'RaLog'
  
  s.version          = '1.5.1'
  
  s.summary          = 'A logging framework.'
  
  s.description      = 'A lightweight, highly customizable, protocol-oriented logging framework.'
  
  s.homepage         = 'https://github.com/rakuyoMo/RaLog'
  
  s.license          = 'MIT'
  
  s.author           = { 'Rakuyo' => 'rakuyo.mo@gmail.com' }
  
  s.source           = { :git => 'https://github.com/rakuyoMo/RaLog.git', :tag => s.version.to_s }
  
  s.requires_arc     = true

  s.platform         = :ios, '10.0'
  
  s.swift_version    = '5.0'
  
  s.module_name      = 'RaLog'
  
  s.source_files     = 'Sources/RaLog/*'
  
end
