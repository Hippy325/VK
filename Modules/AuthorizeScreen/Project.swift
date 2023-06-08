import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeatureProject(
	name: "AuthorizeScreen",
	dependencies: [
		.project(target: "Storage", path: "../Storage"),
		.project(target: "Services", path: "../Services"),
		.project(target: "Navigation", path: "../Navigation")
	]
)
