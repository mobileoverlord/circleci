defmodule CircleCI.User do
  alias CircleCI.Project

  @doc """
  Provides information about the signed in user.

  https://circleci.com/docs/api/v1-reference/#user
  """
  def me do
    CircleCI.get("me")
  end

  @doc """
  Follow a new project. CircleCI will then monitor the project for automatic
  building of commits.

  https://circleci.com/docs/api/v1-reference/#follow-project
  """
  def follow(%Project{} = project) do
    Project.basepath(project, "follow")
    |> CircleCI.post("")
  end

  @doc """
  List of all the projects you're following on CircleCI, with build information
  organized by branch.

  https://circleci.com/docs/api/v1-reference/#projects
  """
  def projects do
    CircleCI.get("projects")
  end

end
