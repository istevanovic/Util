Pod::Spec.new do |s|

  s.name         = "Util"
  s.version 	 = '1.0.0'
  s.license      = { :type => 'PROPRIETARY', :file => 'LICENSE' }
  s.homepage     = 'https://github.com/istevanovic'
  s.authors      = { 'Ilija Stevanovic' => 'https://github.com/istevanovic' }
  s.summary      = "Utilites framework"
  s.source 	 = { :git => "https://github.com/istevanovic/Util", :tag => s.version.to_s }

  base_dir = 'Util/Util/Util'
  s.source_files = base_dir + '/**/*.{h,m,swift}'
  s.public_header_files = base_dir + '/**/*.h'
  s.resources = base_dir + '/**/*.xcdatamodeld'

  s.platform = :ios, '10.0'
  # s.static_framework = true


end
