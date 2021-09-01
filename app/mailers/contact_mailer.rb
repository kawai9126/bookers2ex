class ContactMailer < ApplicationMailer
    def contact_mail(contact)
        @contact = contact
        mail to: 'iroha.9126@gmail.com', subject: 'お問合せだよん'
    end
end
