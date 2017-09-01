defmodule CircleCI do
  @moduledoc """
  An HTTP client for CircleCI.
  """

  use HTTPoison.Base

  @app Mix.Project.config[:app]
  @vsn Mix.Project.config[:vsn]

  @endpoint "https://circleci.com/api/v1.1/"

  @headers [
    {"User-Agent", "#{@app}/#{@vsn}"},
    {"Accept", "application/json"},
    {"Content-Type", "application/json"}
  ]

  @doc """
  Build summary for each of the last 30 recent builds, ordered by build_num.

  https://circleci.com/docs/api/v1-reference/#recent-builds
  """
  def recent_builds do
    CircleCI.get("recent-builds")
  end

  @doc """
  Creates the URL for our endpoint.
  Args:
    * endpoint - part of the API we're hitting
  Returns string
  """
  def process_url(endpoint) do
    @endpoint <> endpoint
  end

  def process_request_headers(headers) do
    headers ++ @headers
  end

  def process_request_options(options) do
    params =
      options
      |> Keyword.get(:params, %{})
      |> Map.put("circle-token", token())
    Keyword.put(options, :params, params)
  end

  def process_response_body(body) do
    json_module().decode!(body)
  end

  def token do
    Application.get_env(:circle_ci, :token) ||
      System.get_env("CIRCLECI_TOKEN")
  end

  def json_module() do
    Application.get_env(:circle_ci, :json_module) || JSX
  end

end
