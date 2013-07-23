defmodule Issues.GithubIssues.Formatter do

  @moduledoc """
  Formats a HashDict of issues from github and transforms them into
  a pretty table for printing.

       #  | created_at           | title
      ----+----------------------+-----------------------------------------
      889 | 2013-03-16T22:03:13Z | MIX_PATH environment variable (of sorts)
      892 | 2013-03-20T19:22:07Z | Enhanced mix test --cover
      893 | 2013-03-21T06:23:00Z | mix test time reports
      898 | 2013-03-23T19:19:08Z | Add mix compile --warnings-as-errors
  """
  @num_of_columns 80

  def format(list_of_issues) do
    Enum.map(list_of_issues, fn(issue) ->
      extract_fields(issue)
      |> trim_fields(@num_of_columns)
      |> concat_fields
      |> tablize_fields
    end 
    )
  end

  def extract_fields(issue) do
    [issue["number"], issue["created_at"], issue["title"] ]
  end

  def concat_fields(fields) do
    [number, created_at, title] = fields
    "#{number} | #{created_at} | #{title}"
  end

  def tablize_fields(line) do
    line
  end

 @doc"""
    # column is 3 wide
    6 more for formatting
    created_at column is 23 wide
    leaving 51 for title (including the pipe and space)
    """
  def trim_fields(issue, max_columns) do

    issue = [Enum.at(issue, 0), 
            Enum.at(issue, 1), 
            Enum.take(String.codepoints(List.last(issue)), 51)
            |> Enum.join
            ]
    issue
  end
  
end