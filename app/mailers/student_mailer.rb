# class StudentMailer < ApplicationMailer
#   def ticket_email(student)
#     @student = student
#     ticket_path = Rails.root.join('public', 'tickets_users', "ticket_#{student.id}.png")
#     attachments["ticket_#{student.id}.png"] = File.read(ticket_path) if File.exist?(ticket_path)
#     mail(to: @student.email, subject: 'Seu Ingresso')
#   end
# end


class StudentMailer < ApplicationMailer
  def ticket_email(student)
    @student = student
    ticket_path = Rails.root.join('public', 'tickets_users', "ticket_#{student.id}.png")
    attachments["ticket_#{student.id}.png"] = File.read(ticket_path) if File.exist?(ticket_path)
    
    if mail(to: @student.email, subject: 'Seu Ingresso').deliver
      Rails.logger.info "Email enviado com sucesso para: #{@student.email}"
    else
      Rails.logger.error "Falha ao enviar o email para: #{@student.email}"
    end
  end
end


