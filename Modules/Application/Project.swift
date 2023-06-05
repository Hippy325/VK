import ProjectDescription

let swiftlintScript = """
export PATH="$PATH:/opt/homebrew/bin"
if which swiftlint > /dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi
"""

let target = Target(
	name: "Application",
	platform: .iOS,
	product: .app,
	bundleId: "garibyanTigran.App",
	deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
	infoPlist: "VK/Info.plist",
	sources: "VK/**",
	actions: [.pre(script: swiftlintScript, name: "SwiftLint")]
)

let project = Project(name: "Applicatio", targets: [target])
