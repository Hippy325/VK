import ProjectDescription

 let swiftlintScript = """
 export PATH="$PATH:/opt/homebrew/bin"
 if which swiftlint > /dev/null; then
  swiftlint
 else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
 fi
 """

extension TargetDependency {
	public static func services() -> Self {
		return .project(target: "Services", path: "../Services")
	}

//	public static func servicesMocks() -> Self {
//		return .project(target: "ServicesMocks", path: "../Services")
//	}

	public static func storage() -> Self {
		return .project(target: "Storage", path: "../Storage")
	}

//	public static func storageMocks() -> Self {
//		return .project(target: "StorageMocks", path: "../Storage")
//	}
}

extension Target {
	fileprivate static func featureTarget(
		name: String,
		dependencies: [TargetDependency] = [],
		coreDataModels: [CoreDataModel] = [],
		product: Product = .app
	) -> Self {
		Target(
			name: "\(name)",
			platform: .iOS,
			product: product,
			bundleId: "garibyanTigran.\(name)",
			deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
			infoPlist: "\(name)/Info.plist",
			sources: ["\(name)/Sources/**"],
			resources: [
				"\(name)/Resources/**",
				"\(name)/Sources/**/*.storyboard"
			],
			actions: [.pre(script: swiftlintScript, name: "Swiftlint")],
			dependencies: dependencies,
			coreDataModels: coreDataModels
		)
	}

	fileprivate static func featureTargetTest(
		name: String,
		dependencies: [TargetDependency] = [],
		isApp: Bool = false
	) -> Self {
		var dependency: [TargetDependency]
		if isApp {
			dependency = [
				.target(name: "\(name)"),
				.project(target: "TestUtilities", path: "../TestUtilities")
			]
		} else {
			dependency = [
				.target(name: "\(name)"),
//				.target(name: "\(name)Mocks"),
				.project(target: "TestUtilities", path: "../TestUtilities")
			]
		}

		return Target(
			name: "\(name)Tests",
			platform: .iOS,
			product: .unitTests,
			bundleId: "garibyanTigran.\(name).tests",
			deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
			infoPlist: "\(name)/Tests/Info.plist",
			sources: ["\(name)/Tests/**/*.swift"],
			actions: [.pre(script: swiftlintScript, name: "Swiftlint")],
			dependencies: dependency + dependencies
		)
	}

	fileprivate static func featureTargetMocks(
		name: String,
		dependencies: [TargetDependency] = []
	) -> Self {
		Target(
			name: "\(name)Mocks",
			platform: .iOS,
			product: .staticFramework,
			bundleId: "garibyanTigran.\(name).Mocks",
			deploymentTarget: .iOS(targetVersion: "14.0", devices: .iphone),
			infoPlist: "\(name)/Mocks/Info.plist",
			sources: ["\(name)/Mocks/**/*.swift"],
			actions: [.pre(script: swiftlintScript, name: "Swiftlint")],
			dependencies:
				[
					.target(name: "\(name)"),
					.project(target: "TestUtilities", path: "../TestUtilities")
				] + dependencies
		)
	}
}

extension Project {
	public static func makeFeatureProject(
		name: String,
		dependencies: [TargetDependency] = [],
		coreDataModels: [CoreDataModel] = [],
		testDependencies: [TargetDependency] = [],
		dependencyIO: [TargetDependency] = [],
		mocksDependency: [TargetDependency] = []
	) -> Self {

		let target = Target.featureTarget(
			name: name,
			dependencies: dependencies,
			coreDataModels: coreDataModels,
			product: .staticFramework
		)

		let targetTest = Target.featureTargetTest(
			name: name,
			dependencies: testDependencies
		)
//		let targetMocks = Target.featureTargetMocks(
//			name: name,
//			dependencies: mocksDependency
//		)

		return Project(
			name: name,
			targets: [target, targetTest]
		)
	}

	public static func makeApplicationProject(
		name: String,
		dependencies: [TargetDependency] = [],
		testDependencies: [TargetDependency] = []
	) -> Self {
		let target = Target.featureTarget(
			name: name,
			dependencies: dependencies
		)

		let targetTests = Target.featureTargetTest(
			name: name,
			dependencies: testDependencies,
			isApp: true
		)

		return Project(
			name: name,
			targets: [target, targetTests]
		)
	}

	public static func makeUtilitiesProject(
		name: String,
		dependencies: [TargetDependency] = []
	) -> Self {
		let target = Target.featureTarget(
			name: name,
			dependencies: dependencies,
			product: .staticFramework
		)

		return Project(
			name: name,
			targets: [target]
		)
	}
}
