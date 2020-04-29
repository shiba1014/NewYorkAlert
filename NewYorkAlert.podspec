Pod::Spec.new do |spec|
  spec.name         = "NewYorkAlert"
  spec.version      = "1.0.0"
  spec.summary      = "A modern alert and action sheet for iOS written in Swift."
  spec.homepage     = "https://github.com/shiba1014/NewYorkAlert"

  spec.license      = { :type => 'MIT', :file => 'LICENSE' }

  spec.author             = { "shiba1014" => "shiba.png@gmail.com" }
  spec.social_media_url   = "https://twitter.com/shiba1014_"

  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/shiba1014/NewYorkAlert.git", :tag => spec.version.to_s }
  spec.source_files = 'Sources/**/*.swift'
  spec.swift_version = '5.1'

  spec.requires_arc = true
end
