defmodule PragmaticWeb.Admin.PartnerController do
  use PragmaticWeb, :controller

  alias Pragmatic.Partners
  alias Pragmatic.Partners.Partner

  plug(:put_root_layout, {PragmaticWeb.LayoutView, "admin.html"})
  plug(:put_layout, false)

  def index(conn, params) do
    render(conn, "index.html", partners: Pragmatic.Partners.list_partners())
    # case Partners.paginate_partners(params) do
    #   {:ok, assigns} ->
    #     render(conn, "index.html", assigns)
    #   error ->
    #     conn
    #     |> put_flash(:error, "There was an error rendering Partners. #{inspect(error)}")
    #     |> redirect(to: Routes.admin_partner_path(conn, :index))
    # end
  end

  def new(conn, _params) do
    changeset = Partners.change_partner(%Partner{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"partner" => partner_params}) do
    case Partners.create_partner(partner_params) do
      {:ok, partner} ->
        conn
        |> put_flash(:info, "Partner created successfully.")
        |> redirect(to: Routes.admin_partner_path(conn, :show, partner))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    partner = Partners.get_partner!(id)
    render(conn, "show.html", partner: partner)
  end

  def edit(conn, %{"id" => id}) do
    partner = Partners.get_partner!(id)
    changeset = Partners.change_partner(partner)
    render(conn, "edit.html", partner: partner, changeset: changeset)
  end

  def update(conn, %{"id" => id, "partner" => partner_params}) do
    partner = Partners.get_partner!(id)

    case Partners.update_partner(partner, partner_params) do
      {:ok, partner} ->
        conn
        |> put_flash(:info, "Partner updated successfully.")
        |> redirect(to: Routes.admin_partner_path(conn, :show, partner))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", partner: partner, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    partner = Partners.get_partner!(id)
    {:ok, _partner} = Partners.delete_partner(partner)

    conn
    |> put_flash(:info, "Partner deleted successfully.")
    |> redirect(to: Routes.admin_partner_path(conn, :index))
  end
end
