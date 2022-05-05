defmodule Cs491hw2masteryWeb.DepartmentController do
  use Cs491hw2masteryWeb, :controller

  alias Cs491hw2mastery.Repo
  alias Cs491hw2mastery.Business
  alias Cs491hw2mastery.Business.Department

  def index(conn, _params) do
    departments = Business.list_departments() |> Repo.preload(:employees)
    employees = Business.list_employees()
    roles = Business.list_roles()

    render(conn, "index.html", departments: departments, employees: employees, roles: roles)
  end

  def new(conn, _params) do
    changeset = Business.change_department(%Department{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"department" => department_params}) do
    case Business.create_department(department_params) do
      {:ok, department} ->
        conn
        |> put_flash(:info, "Department created successfully.")
        |> redirect(to: Routes.department_path(conn, :show, department))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    department = Business.get_department!(id) |> Repo.preload(:employees)
    departments = Business.list_departments()
    employees = Business.list_employees()
    roles = Business.list_roles()
    render(conn, "show.html", departments: departments, employees: employees, roles: roles, department: department)
  end

  def edit(conn, %{"id" => id}) do
    department = Business.get_department!(id)
    changeset = Business.change_department(department)
    render(conn, "edit.html", department: department, changeset: changeset)
  end

  def update(conn, %{"id" => id, "department" => department_params}) do
    department = Business.get_department!(id)

    case Business.update_department(department, department_params) do
      {:ok, department} ->
        conn
        |> put_flash(:info, "Department updated successfully.")
        |> redirect(to: Routes.department_path(conn, :show, department))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", department: department, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    department = Business.get_department!(id) |> Repo.preload(:employees)
    {:ok, _department} = Business.delete_department(department)

    conn
    |> put_flash(:info, "Department deleted successfully.")
    |> redirect(to: Routes.department_path(conn, :index))
  end
end
