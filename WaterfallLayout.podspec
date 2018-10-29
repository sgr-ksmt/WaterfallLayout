Pod::Spec.new do |s|
  s.name             = "WaterfallLayout"
  s.version          = "0.2"
  s.summary          = "Generate ElasticSearch query in Swift"
  s.homepage         = "https://github.com/sgr-ksmt/WaterfallLayout"
  # s.screenshots     = ""
  s.license          = 'MIT'
  s.author           = { "Suguru Kishimoto" => "melodydance.k.s@gmail.com" }
  s.source           = { :git => "https://github.com/sgr-ksmt/WaterfallLayout.git", :tag => s.version.to_s }
  s.platform         = :ios, '9.0'
  s.requires_arc     = true
  s.source_files     = "Sources/**/*"
  s.swift_version    = '4.2'
end
