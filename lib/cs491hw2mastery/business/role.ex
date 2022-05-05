defmodule Cs491hw2mastery.Business.Role do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cs491hw2mastery.Business.Employee

  schema "roles" do
    field :name, :string
    has_many(:employees, Employee)

    timestamps()
  end

  @doc false
  def changeset(role, attrs) do
    role
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
