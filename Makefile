
open:
	rm -rf VK.xcworkspace VK.xcodeproj Derived
	tuist generate
	open VK.xcworkspace