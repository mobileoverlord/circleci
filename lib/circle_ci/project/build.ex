defmodule CircleCI.Project.Build do
  alias CircleCI.Project

  @doc """
  Full details for a single build. The response includes all of the fields from
  the build summary.

  https://circleci.com/docs/api/v1-reference/#build
  """
  def get(%Project{} = project, build_num) do
    project
    |> basepath(build_num)
    |> CircleCI.get
  end

  @doc """
  List the artifacts produced by a given build.

  https://circleci.com/docs/api/v1-reference/#build-artifacts
  """
  def artifacts(%Project{} = project, build_num) do
    project
    |> basepath(build_num, "artifacts")
    |> CircleCI.get
  end

  @doc """
  Retries the build, returns a summary of the new build.

  https://circleci.com/docs/api/v1-reference/#retry-build
  """
  def retry(%Project{} = project, build_num) do
    project
    |> basepath(build_num, "retry")
    |> CircleCI.post("")
  end

  @doc """
  Cancels the build, returns a summary of the build.

  https://circleci.com/docs/api/v1-reference/#cancel-build
  """
  def cancel(%Project{} = project, build_num) do
    project
    |> basepath(build_num, "cancel")
    |> CircleCI.post("")
  end

  @doc """
  Provides test metadata for a build

  https://circleci.com/docs/api/v1-reference/#test-metadata
  """
  def tests(%Project{} = project, build_num) do
    project
    |> basepath(build_num, "tests")
    |> IO.inspect
    |> CircleCI.get()
  end

  @doc false
  def basepath(%Project{} = project, build_num, suffix \\ "") do
    build_num = to_string(build_num)
    base =
      project
      |> Project.basepath()
    Path.join([base, build_num, suffix])
  end

end
