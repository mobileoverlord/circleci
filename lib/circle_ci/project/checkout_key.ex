defmodule CircleCI.Project.CheckoutKey do

  alias CircleCI.Project

  @doc """
  Lists the checkout keys for a project
  """
  def list(%Project{} = project) do
    project
    |> basepath()
    |> CircleCI.get()
  end

  @doc """
  Creates a new checkout key. Only usable with a user API token.

  Params:
    type - The type of key to create. Can be 'deploy-key' or 'github-user-key'.
  """
  def create(%Project{} = project, type) when type in [:github, :deploy] do
    type =
      case type do
        :github -> "github-user-key"
        :deploy -> "deploy-key"
      end
    body = CircleCI.json_module().encode!(%{
        type: type
    })
    project
    |> basepath()
    |> CircleCI.post(body)
  end

  @doc """
  Gets the checkout key

  Params:
    fingerprint - The fingerprint of key
  """
  def get(%Project{} = project, fingerprint) do
    project
    |> basepath(fingerprint)
    |> CircleCI.get()
  end

  @doc """
  Deletes the checkout key

  Params:
    fingerprint - The fingerprint of key
  """
  def delete(%Project{} = project, fingerprint) do
    basepath(project, fingerprint)
    |> CircleCI.delete()
  end

  @doc false
  def basepath(%Project{} = project, fingerprint \\ "") do
    base =
      project
      |> Project.basepath()
    Path.join([base, "checkout-key", fingerprint])
  end

end
