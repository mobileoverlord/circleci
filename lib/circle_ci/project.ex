defmodule CircleCI.Project do
  alias __MODULE__

  defstruct [vcs_type: "github", username: nil, project: nil]

  @type t :: %{
    vcs_type: String.t,
    username: String.t,
    project: String.t
  }

  def list do
    CircleCI.get("projects")
  end

  @doc """
  Build summary for each of the last 30 builds for a single git repo.

  https://circleci.com/docs/api/v1-reference/#recent-builds-project
  """
  def get(%Project{} = project) do
    basepath(project)
    |> CircleCI.get()
  end

  @doc """
  Clears the cache for a project

  https://circleci.com/docs/api/v1-reference/#clear-cache
  """
  def clear_cache(%Project{} = project) do
    basepath(project, "build-cache")
    |> CircleCI.delete()
  end

  @doc """
  Creates an ssh key that will be used to access the external system identified
  by the hostname parameter for SSH key-based authentication.

  https://circleci.com/docs/api/v1-reference/#ssh-keys
  """
  def create_ssh_key(%Project{} = project, hostname, private_key) do
    body = CircleCI.json_module().encode!(%{
      hostname: hostname,
      private_key: private_key
    })
    basepath(project, "ssh-key")
    |> CircleCI.post(body)
  end

  @doc false
  def basepath(%Project{vcs_type: vcs_type, username: username, project: project}, suffix \\ "") do
    Path.join(["project", vcs_type, username, project, suffix])
  end

end
