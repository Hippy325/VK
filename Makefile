
open:
	rm -rf VK.xcworkspace VK.xcodeproj Derived
	swiftlint autocorrect
	tuist generate
	open VK.xcworkspace