import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeatureProject(
	name: "Navigation",
	dependencies: [
		.project(target: "Utilities", path: "../Utilities"),
		.project(target: "UsersScreens", path: "../UsersScreens")
	]
)
