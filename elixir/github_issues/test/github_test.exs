defmodule GithubTest do
  use ExUnit.Case
  doctest GithubIssues.Github

  import GithubIssues.Github

  test "user issues url" do
    assert user_issues_url("aspin", "kbbz") == "https://api.github.com/repos/aspin/kbbz/issues" 
  end

end
