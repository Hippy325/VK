
import ProjectDescription

let target = Target(
	name: "VK",
	platform: .iOS,
	product: .app,
	bundleId: "garibyanTigran.App",
	deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
	infoPlist: "VK/Info.plist",
	sources: "VK/**"
)

let project = Project(name: "VK", targets: [target])
