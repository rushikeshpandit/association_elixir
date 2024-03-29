defmodule AssociationElixir.Mail.ForgotPasswordEmail do
  use Phoenix.Swoosh,
    template_root: "lib/association_elixir_web/controllers",
    template_path: "email_html"

  import Swoosh.Email
  alias AssociationElixir.Mailer

  def create_email(user, token) do
    url = "/sessions/reset_password?token=#{token}"

    new()
    |> to({user.first_name, user.email})
    |> from({"Rushikesh Pandit", "rushikesh.d.pandit@gmail.com"})
    |> subject("Rent cars - Reset Password")
    |> render_body("forgot_password.html", %{first_name: user.first_name, url: url})
  end

  def send_forgot_password_email(user, token) do
    user
    |> create_email(token)
    |> Mailer.deliver()
  end
end
