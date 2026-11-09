from urllib import request
from project import Project
import toml


class ProjectReader:
    def __init__(self, url):
        self._url = url

    def get_project(self):
        # tiedoston merkkijonomuotoinen sisältö
        content = request.urlopen(self._url).read().decode("utf-8")

        data = toml.loads(content)

        project = data["project"]

        name = project["name"].replace("-", " ").capitalize()
        description = project["description"]
        license = project["license"]

        authors = [author["name"] for author in project["authors"]]

        dependencies = [
            dependency.split(">=")[0]
            for dependency in project["dependencies"]
        ]

        dependencies = [
            "python" if dependency == "python" else
            "Flask" if dependency.lower() == "flask" else dependency
            for dependency in dependencies
        ]

        dependencies.insert(0, "python")

        dev_dependencies = [
            dependency.split(">=")[0]
            for dependency in data["dependency-groups"]["dev"]
        ]

        return Project(
            name,
            description,
            license,
            authors,
            dependencies,
            dev_dependencies
        )
