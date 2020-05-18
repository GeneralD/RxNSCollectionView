Pod::Spec.new do |s|
	s.name = 'RxNSCollectionView'
	s.version = '0.0.1'
	s.license = { :type => "MIT", :file => "LICENSE" }
	s.summary = 'Supports reactive styled data sourcing for NSCollectionView.'
	s.homepage = 'https://github.com/GeneralD/RxNSCollectionView'
	s.social_media_url = 'https://twitter.com/TheDreamBoss'
	s.authors = { "Yumenosuke" => "yumejustice@gmail.com" }
	s.source = { :git => "https://github.com/GeneralD/RxNSCollectionView.git", :tag => s.version.to_s }

	s.osx.deployment_target = '10.14'
	s.requires_arc = true
	s.swift_versions = '5.0'

	s.dependency 'RxSwift', '~> 5.0'
	s.dependency 'RxCocoa', '~> 5.0'

	s.framework  = "Foundation"
	s.framework  = "Cocoa"

	s.subspec "Core" do |ss|
		ss.source_files  = "Sources/Core/*.swift"
	end

	s.subspec "Reusable" do |ss|
		ss.source_files  = "Sources/Reusable/*.swift"
	    ss.dependency "RxNSCollectionView/Core"
	end

	s.subspec "RxItems" do |ss|
		ss.source_files  = "Sources/RxItems/*.swift"
		ss.dependency "RxNSCollectionView/Reusable"
	end
end
