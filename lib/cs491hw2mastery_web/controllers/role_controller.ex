defmodule Cs491hw2masteryWeb.RoleController do
  use Cs491hw2masteryWeb, :controller
  alias Cs491hw2mastery.Repo
  alias Cs491hw2mastery.Business
  alias Cs491hw2mastery.Business.Role

  def index(conn, _params) do
    roles = Business.list_roles() |> Repo.preload(:employees)
    departments = Business.list_departments()
    employees = Business.list_employees()
    render(conn, "index.html", roles: roles, departments: departments, employees: employees)
  end

  def new(conn, _params) do
    changeset = Business.change_role(%Role{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"role" => role_params}) do
    case Business.create_role(role_params) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "Role created successfully.")
        |> redirect(to: Routes.role_path(conn, :show, role))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    role = Business.get_role!(id) |> Repo.preload(:employees)
    departments = Business.list_departments()
    employees = Business.list_employees()
    render(conn, "show.html", role: role, departments: departments, employees: employees)
  end

  def edit(conn, %{"id" => id}) do
    role = Business.get_role!(id)
    changeset = Business.change_role(role)
    render(conn, "edit.html", role: role, changeset: changeset)
  end

  def update(conn, %{"id" => id, "role" => role_params}) do
    role = Business.get_role!(id)

    case Business.update_role(role, role_params) do
      {:ok, role} ->
        conn
        |> put_flash(:info, "Role updated successfully.")
        |> redirect(to: Routes.role_path(conn, :show, role))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", role: role, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    role = Business.get_role!(id) |> Repo.preload(:employees)
    {:ok, _role} = Business.delete_role(role)

    conn
    |> put_flash(:info, "Role deleted successfully.")
    |> redirect(to: Routes.role_path(conn, :index))
  end
end
