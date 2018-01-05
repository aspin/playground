defmodule GithubIssues.CLI do
  @moduledoc """
  CLI processing module.
  """

  @default_count 4

  def run(argv) do
    parse_arguments(argv)
    |> process
    |> format
  end

  @doc """
  Parses `argv`. Returns :help by default or if the `-h` or `--help` switches
  are passed in, otherwise the parsed out `user`, `project`, and `count` arguments.

  ## Examples

      iex> GithubIssues.CLI.parse_arguments(["-h"])
      :help
      
      iex> GithubIssues.CLI.parse_arguments(["foo", "bar", "4"])
      {"foo", "bar", 4}
      
  """
  def parse_arguments(argv) do
    parsed_args = OptionParser.parse(argv, switches: [ help: :boolean ], aliases: [ h: :help ])
    case parsed_args do
      { [ help: true ], _, _ } -> :help
      { _, [ user, project, count ], _ } -> 
        { user, project, String.to_integer(count) }
      { _, [ user, project ], _ } -> { user, project, @default_count }
      _ -> :help
    end
  end

  def process(:help) do
    IO.puts """
    usage: github_issues [-h|--help] <user> <project> [count|#{@default_count}]
    """
    System.halt(0)
  end

  def process({ user, project, count }) do
    GithubIssues.Github.fetch(user, project)
    |> decode_response
    |> Enum.sort(&(&1["created_at"] <= &2["created_at"]))
    |> Stream.map(&(Map.take(&1, ["title", "created_at", "number"])))
    |> Enum.take(count)
  end

  def decode_response({ :ok, body }), do: body 

  def decode_response({ :error, body }) do
    IO.puts ~s(Error fetching from Github: #{body["message"]})
    System.halt(2)
  end

  def format(issues) do
    IO.inspect issues
  end

  def main(argv), do: run(argv)
end
