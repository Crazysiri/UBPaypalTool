

Pod::Spec.new do |s|

  s.name         = "UBPaypalTool"
  s.version      = "0.0.2"
  s.summary      = "A short description of UBPaypalTool."

  s.description  = <<-DESC
A short description of UBPaypalTool.
                   DESC

  s.homepage     = "https://github.com/Crazysiri/UBPaypalTool.git"

  # s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "James" => "511121933@qq.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/Crazysiri/UBPaypalTool.git", :tag => "#{s.version}" }


  s.source_files  = "UBPaypalTool/*.{h,m}"

  # s.framework  = "SomeFramework"
  s.frameworks = "MobileCoreServices", "Security","SystemConfiguration"

  s.library   = "xml2"

  s.xcconfig = { "LIBRARY_SEARCH_PATHS" => "${PODS_ROOT}/CardIO/CardIO" }
  s.dependency "PayPal-iOS-SDK"

end
