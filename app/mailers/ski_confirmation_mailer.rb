class SkiConfirmationMailer < ApplicationMailer

  def ski_confirmation_email
    @user = params[:user]
    @ski = params[:ski]

    mail(
      to: @user.email,
      subject: "Congrats #{@user.first_name}! Your ski has been created!"
    )
  end
end
