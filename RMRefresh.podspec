Pod::Spec.new do |s|
s.name         = "RXSDK"
s.version      = "1.0.3"
s.summary      = "The easiest way to use pull-to-refresh"
s.homepage     = "https://github.com/Ryan0520/RMRefresh"
s.license      = "MIT"
s.author       = {"Ryan" => "CoderRxShen@126.com"}
s.platform     = :ios, '8.0'
s.source       = {:git => "https://github.com/Ryan0520/RMRefresh.git", :tag => s.version }
s.source_files = "RMRefresh/RMRefresh/Classes/**/*.{h,m}"
s.requires_arc = true
s.frameworks   = "Foundation","UIKit","MapKit","QuartzCore","CoreText","ImageIO","Security","CoreTelephony","CoreGraphics","SystemConfiguration"
s.libraries    = "iconv", "z","stdc++","sqlite3"
s.dependency 'AFNetworking', '~> 3.0.0-beta.2'
end