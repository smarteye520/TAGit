# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'
use_frameworks!

target 'TAGit' do
  # Pods for TAGit
  pod 'SwiftLint'
  pod 'SPPermission'
  pod 'Intercom'
  
  # 3rd Party
  pod 'GoogleSignIn'
  pod 'FBSDKLoginKit'

  # PromiseKit for asynchronization
  pod 'PromiseKit'
  
  # Core
  pod 'ObjectMapper'
  pod 'Alamofire'

  # UI
  pod 'SnapKit', '~> 4.2.0'
  pod 'SVProgressHUD'
  pod 'Kingfisher'
  pod 'XLPagerTabStrip'
#  pod 'SDWebImage'
  pod 'IQKeyboardManagerSwift', '6.0.4'
  pod 'Hero'
  pod 'Toast'
  
  #JSON Kit
  pod 'SwiftyJSON'
  # Localization
  pod 'Localize-Swift'
  #Keychain
  pod 'KeychainSwift'
  
  target 'TAGitTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TAGitUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '4.2'
    end
  end
end

