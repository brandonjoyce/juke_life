defmodule JukeLife.Selection do
  use JukeLife.Web, :model

  schema "selections" do
    field :url, :string
    field :played, :boolean, default: false
    belongs_to :juke, JukeLife.Juke

    timestamps
  end

  @required_fields ~w(url played)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
