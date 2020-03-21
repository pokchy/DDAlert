Pod::Spec.new do |spec|

  spec.name         = 'DDAlert'
  spec.version      = '0.4.0'
  spec.homepage     = 'https://github.com/pokchy/DDAlert'
  spec.summary      = 'Customize your alerts and have better user experience by optionally presenting them where user tapped.'

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author       = { "Thanh Duc Do" => "29248367+pokchy@users.noreply.github.com" }

  spec.swift_version = '5.1'
  spec.ios.deployment_target  = '9.0'

  spec.source       = { :git => "https://github.com/pokchy/DDAlert.git", :tag => "#{spec.version}" }

  spec.source_files  = 'DDAlert/Source/*.{swift,xib}'
end
