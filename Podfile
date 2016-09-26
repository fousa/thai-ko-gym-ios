platform :ios, '9.3'

target 'Thai Ko Gym' do
  use_frameworks!

  pod 'Alamofire',                  '~> 4.0'
  pod 'Keychain',                   '~> 0.3'
  pod 'BSGridCollectionViewLayout', '~> 1.1'
  pod 'MBProgressHUD',              '~> 1.0'

  # Waiting for Swift 3 version.
  pod 'Bond',        git:    'https://github.com/SwiftBond/Bond.git',
                     branch: 'bond5',
                     commit: 'dd80768'
  pod 'ModelMapper', git:    'https://github.com/lyft/mapper.git',
                     branch: 'swift-3.0',
                     commit: 'eead7f5'

  target 'Thai Ko Gym Tests' do
    inherit! :search_paths
  end
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
