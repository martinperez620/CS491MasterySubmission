defmodule Cs491hw2masteryWeb.EmployeeController do
  use Cs491hw2masteryWeb, :controller

  alias Cs491hw2mastery.Repo
  alias Cs491hw2mastery.Business
  alias Cs491hw2mastery.Business.Employee

  def index(conn, _params) do
    employees = Business.list_employees()
    departments = Business.list_departments()
    roles = Business.list_roles()
    render(conn, "index.html", employees: employees, departments: departments, roles: roles)
  end

  def new(conn, _params) do
    changeset = Business.change_employee(%Employee{})
    departments = Business.list_departments()
    roles = Business.list_roles()
    render(conn, "new.html", changeset: changeset, departments: departments, roles: roles)
  end

  def create(conn, %{"employee" => employee_params}) do
    case Business.create_employee(employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Employee created successfully.")
        |> redirect(to: Routes.employee_path(conn, :show, employee))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    employee = Business.get_employee!(id) |> Repo.preload([:department, :role])
    employees = Business.list_employees()
    departments = Business.list_departments()
    roles = Business.list_roles()
    render(conn, "show.html", employee: employee, departments: departments, roles: roles, employees: employees)
  end

  def edit(conn, %{"id" => id}) do
    employee = Business.get_employee!(id) |> Repo.preload([:department, :role])
    changeset = Business.change_employee(employee)
    departments = Business.list_departments()
    roles = Business.list_roles()
    render(conn, "edit.html", employee: employee, changeset: changeset, departments: departments, roles: roles)
  end

  def update(conn, %{"id" => id, "employee" => employee_params}) do
    employee = Business.get_employee!(id)

    case Business.update_employee(employee, employee_params) do
      {:ok, employee} ->
        conn
        |> put_flash(:info, "Employee updated successfully.")
        |> redirect(to: Routes.employee_path(conn, :show, employee))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", employee: employee, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    employee = Business.get_employee!(id) |> Repo.preload([:department, :role])
    {:ok, _employee} = Business.delete_employee(employee)

    conn
    |> put_flash(:info, "Employee deleted successfully.")
    |> redirect(to: Routes.employee_path(conn, :index))
  end
end
