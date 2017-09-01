defmodule CircleCI.Project.Env do
  alias CircleCI.Project
  
  @doc """
  Returns four 'x' characters plus the last four ASCII characters of the value,
  consistent with the display of environment variable values in the CircleCI
  website.

  https://circleci.com/docs/api/v1-reference/#list-environment-variables
  """
  def list(%Project{} = project) do
    project
    |> basepath()
    |> CircleCI.get()
  end

  @doc """
  Creates a new environment variable

  https://circleci.com/docs/api/v1-reference/#add-environment-variable
  """
  def create(%Project{} = project, name, value) do
    body = CircleCI.json_module().encode!(%{
      name: name,
      value: value
    })
    project
    |> basepath()
    |> CircleCI.post(body)
  end

  @doc """
  Gets the hidden value of environment variable :name

  https://circleci.com/docs/api/v1-reference/#get-environment-variable
  """
  def get(%Project{} = project, name) do
    project
    |> basepath(name)
    |> CircleCI.get()
  end

  @doc """
  Deletes the environment variable named ':name'

  https://circleci.com/docs/api/v1-reference/#delete-environment-variable
  """
  def delete(%Project{} = project, name) do
    project
    |> basepath(name)
    |> CircleCI.delete()
  end

  @doc false
  def basepath(%Project{} = project, suffix \\ "") do
    base =
      project
      |> Project.basepath()
    Path.join([base, "envvar", suffix])
  end
end
