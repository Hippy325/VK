import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeApplicationProject(
	name: "Application",
	dependencies: [
		.project(target: "Storage", path: "../Storage"),
		.project(target: "Services", path: "../Services"),
		.project(target: "UsersScreens", path: "../UsersScreens"),
		.project(target: "AuthorizeScreen", path: "../AuthorizeScreen"),
		.project(target: "Navigation", path: "../Navigation"),
		.project(target: "MessagesScreen", path: "../MessagesScreen")
	]
)
