use_frameworks!
inhibit_all_warnings!
platform :ios, '13.6'

target 'KSAChallenge' do

  pod 'Kingfisher', '~> 5.0'
  pod 'NVActivityIndicatorView', '5.1.1'
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'netfox', '1.21.0'
  
end

post_install do |installer|
  installer.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
          config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
  end
end
