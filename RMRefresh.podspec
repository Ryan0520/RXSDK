
Pod::Spec.new do |s|

  s.name         = "RMRefresh"
  s.version      = "0.0.1"
  s.summary      = "这是一个很简单的freshSpec"

  s.description  = <<-DESC
                   A longer description of RMRefreshSpec in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "http://EXAMPLE/RMRefreshSpec"

  s.license      = "MIT"

  s.author       = { "沈文涛" => "CoderRxShen@126.com" }

  s.platform     = :ios, '7.0'

  s.source       = { :git => "https://github.com/Ryan0520/RMRefresh.git", :tag => "0.0.1" }

  s.source_files  = "RMRefresh/RMRefresh/Classes", "RMRefresh/RMRefresh/Classes/**/*.{h,m}"
  # s.exclude_files = "RMRefresh/RMRefresh/Classes/Exclude"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency "MJRefresh", "~> 2.4.11"

end
