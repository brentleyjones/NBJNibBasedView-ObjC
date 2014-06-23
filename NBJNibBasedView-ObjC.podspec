
Pod::Spec.new do |s|

  s.name         = "NBJNibBasedView-ObjC"
  s.version      = "1.0.1"
  s.summary      = "Easy Nib based custom views"
  s.homepage     = "https://github.com/BrentleyJones/NBJNibBasedView-ObjC"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Brentley Jones" => "contact@brentleyjones.com" }
  s.social_media_url   = "http://twitter.com/BrentleyJones"
  s.ios.deployment_target = "6.0"
  s.osx.deployment_target = "10.8"
  s.source       = { :git => "https://github.com/BrentleyJones/NBJNibBasedView-ObjC.git", :tag => "1.0.1" }
  s.source_files = "NBJNibBasedView/**/*.{h,m}"
  s.requires_arc = false

end
