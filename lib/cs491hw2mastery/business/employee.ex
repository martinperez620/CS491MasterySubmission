defmodule Cs491hw2mastery.Business.Employee do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cs491hw2mastery.Business.Department
  alias Cs491hw2mastery.Business.Role

  schema "employees" do
    field :first_name, :string
    field :last_name, :string
    belongs_to(:department, Department)
    belongs_to(:role, Role)

    timestamps()
  end

  @doc false
  def changeset(employee, attrs) do
    employee
    |> cast(attrs, [:last_name, :first_name, :department_id, :role_id])
    |> validate_required([:last_name, :first_name, :department_id, :role_id])
  end
end
