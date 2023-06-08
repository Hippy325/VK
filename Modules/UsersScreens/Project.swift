import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeatureProject(
	name: "UsersScreens",
	dependencies: [
		.project(target: "Storage", path: "../Storage"),
		.project(target: "Services", path: "../Services"),
		.project(target: "Utilities", path: "../Utilities")
	]
)
