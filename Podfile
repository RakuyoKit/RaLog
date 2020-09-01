source 'https://git.pettyb.com/iOSBasic/Space.git'
source 'https://git.pettyb.com/iOSUniversal/Space.git'
source 'https://cdn.cocoapods.org/'

workspace 'RaLog.xcworkspace'

platform :ios, '10.0'

use_frameworks!

#use_modular_headers!
inhibit_all_warnings!

install! 'cocoapods',
         :preserve_pod_file_structure => true,
         :generate_multiple_pod_projects => true
#         :incremental_installation => true

target 'RaLog' do
  
  project 'RaLog/RaLog.xcodeproj'
  
  pod 'MBCExtension'
  pod 'MBCHelper'
  pod 'MBCBase'
  
  #pod 'RaLogRouter', '>= 1.0.0-Router'
  
end

target 'RaLogRouter' do
  
  project 'RaLogRouter/RaLogRouter.xcodeproj'
  
  pod 'RaRouter'
  
end
