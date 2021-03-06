
Pod::Spec.new do |s|

  s.name         = "RXSDK"
  s.version      = "1.2.4"
  s.summary      = "CoderRyan’s SDK"
  s.homepage     = "https://github.com/Ryan0520/RMRefresh"
  s.license      = "MIT"
  s.author       = { "Ryan" => "CoderRxShen@126.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/Ryan0520/RMRefresh.git", :tag => s.version }
  s.source_files  =  "RMRefresh/RMRefresh/RXSDK/**/*.{h,m}"
  s.libraries = "iconv", "z","stdc++","sqlite3"
  s.requires_arc = true
  s.dependency 'AFNetworking', '~> 3.0.4'
  s.dependency 'SVProgressHUD', '~> 2.0'
  s.dependency 'DZNEmptyDataSet', '~> 1.8.1'
  s.dependency 'FDFullscreenPopGesture', '~> 1.1'

end
