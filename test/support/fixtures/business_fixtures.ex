defmodule Cs491hw2mastery.BusinessFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cs491hw2mastery.Business` context.
  """

  @doc """
  Generate a department.
  """
  def department_fixture(attrs \\ %{}) do
    {:ok, department} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Cs491hw2mastery.Business.create_department()

    department
  end

  @doc """
  Generate a role.
  """
  def role_fixture(attrs \\ %{}) do
    {:ok, role} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> Cs491hw2mastery.Business.create_role()

    role
  end

  @doc """
  Generate a employee.
  """
  def employee_fixture(attrs \\ %{}) do
    {:ok, employee} =
      attrs
      |> Enum.into(%{
        first_name: "some first_name",
        last_name: "some last_name"
      })
      |> Cs491hw2mastery.Business.create_employee()

    employee
  end
end
