use_frameworks! # Add this if you are targeting iOS 8+ or using Swift
platform :ios, '8.0'
target "QXJS" do

pod 'SQLite.swift', '~> 0.10.1'
pod 'Alamofire'

end

# disable bitcode in every sub-target
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
    end
end