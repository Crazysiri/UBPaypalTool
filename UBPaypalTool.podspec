

Pod::Spec.new do |s|

  s.name         = "UBPaypalTool"
  s.version      = "0.0.1"
  s.summary      = "A short description of UBPaypalTool."

  s.description  = <<-DESC
A short description of UBPaypalTool.
                   DESC

  s.homepage     = "https://github.com/Crazysiri/UBPaypalTool.git"

  # s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "James" => "511121933@qq.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/Crazysiri/UBPaypalTool.git", :tag => "#{s.version}" }


  s.source_files  = "UBPaypalTool/**/*.{h,m}"
  
  s.subspec 'PayPalMobile' do |ss|
    ss.source_files = 'UBPaypalTool/PayPalMobile/*.{h,m}'
    ss.ios.vendored_libraries  = 'UBPaypalTool/PayPalMobile/libPayPalMobile.a','UBPaypalTool/CardIO/libopencv_core.a','UBPaypalTool/CardIO/libCardIO.a','UBPaypalTool/CardIO/libopencv_imgproc.a'
  end

  # s.framework  = "SomeFramework"
  s.frameworks = "MobileCoreServices", "Security","SystemConfiguration"

  s.library   = "xml2"

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
