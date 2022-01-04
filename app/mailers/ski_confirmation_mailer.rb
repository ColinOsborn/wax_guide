class SkiConfirmationMailer < ApplicationMailer

  def ski_creation_confirmation
    @user = params[:user]
    @ski = params[:ski]

    mail(
      to: @user.email,
      subject: "Congrats #{@user.first_name}! Your ski has been created!"
    )
  end
end
