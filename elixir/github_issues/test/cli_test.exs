defmodule CliTest do
  use ExUnit.Case
  doctest GithubIssues.CLI

  import GithubIssues.CLI, only: [ parse_arguments: 1 ]

  test ":help returned if -h and --help" do
    assert parse_arguments(["-h"]) == :help
    assert parse_arguments(["--help"]) == :help
  end

  test "three values returned if three given" do
    assert parse_arguments(["one", "two", "33"]) == { "one", "two", 33 }
  end

  test "default count return if not provided" do
    assert parse_arguments(["one", "two"]) == { "one", "two", 4 }
  end

end
