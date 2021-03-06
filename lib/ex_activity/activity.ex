defmodule ExActivity.Activity do
  @moduledoc """
  Activity Ecto schema. Takes care of persisting the actual log.
  """

  @type t :: %__MODULE__{
    type: String.t,
    action: String.t,
    details: String.t | integer,
    data: String.t,
    ip: String.t,
    user_agent: String.t
  }

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
    %Activity{}
    |> changeset(attrs)
    |> Repo.insert!
  end
end
