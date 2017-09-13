defmodule ExActivity.Activity do
  @moduledoc """
  Activity Ecto schema. Takes care of persisting the actual log.
  """
  use Ecto.Schema
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias ExActivity.Repo
  alias ExActivity.Activity

  schema "activity" do
    field :type, :string
    field :action, :string
    field :result, :string
    field :details, :string
    field :data, :string
    field :ip, :string
    field :user_agent, :string
    timestamps()
  end

  defp changeset(%Activity{} = activity, attrs) do
    activity
    |> cast(attrs, [:type, :action, :result, :details, :data, :ip, :user_agent])
    |> validate_required([:type, :action, :result])
  end

  def log(attrs) do
    repo = Application.get_env(:ex_activity, :repo, Repo)

    query = "SELECT SLEEP(5)"
    res = Ecto.Adapters.SQL.query!(Repo, query, [])

    %Activity{}
    |> changeset(attrs)
    |> repo.insert!
  end
end
