Pod::Spec.new do |spec|

  spec.name         = "DDAlert"
  spec.version      = "0.0.1"
  spec.summary      = "Testing building a framework."

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author       = { "Thanh Duc Do" => "29248367+pokchy@users.noreply.github.com" }

  spec.platform     = :ios, "8.0"

  spec.source       = { :git => "https://github.com/pokchy/DDAlert.git", :tag => "#{spec.version}" }

  spec.source_files  = "Classes", "Classes/**/*.{h,m}"
  spec.exclude_files = "Classes/Exclude"
end
