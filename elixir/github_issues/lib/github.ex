defmodule GithubIssues.Github do
  @moduledoc """
  Github HTTP service code.
  """

  @github_url Application.get_env(:github_issues, :github_url)
  @user_agent [ { "User-agent", "Elixir tsunami70875@gmail.com" } ]

  def fetch(user, project) do
    user_issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def user_issues_url(user, project) do
    "#{@github_url}/repos/#{user}/#{project}/issues"
  end

  def handle_response({ :ok, %{ status_code: 200, body: body } }) do
    { :ok, Poison.decode!(body) }
  end

  def handle_response({ _, %{ status_code: _, body: body } }) do
    { :error, Poison.decode!(body) }
  end
end
