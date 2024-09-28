import ProjectDescription
import ProjectDescriptionHelpers

let project = Project.makeFeatureProject(
    name: "Services",
    dependencies: [
        .project(target: "Storage", path: "../Storage"),
        .project(target: "Utilities", path: "../Utilities")
    ]
)
