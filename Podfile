platform :ios, '9.3'

target 'Thai Ko Gym' do
  use_frameworks!

  pod 'Alamofire', '~> 4.0'

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
