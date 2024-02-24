class StudentsController < ApplicationController
  def new
    @student = Student.new
  end

  def new_send_ticket
    @student = Student.new
    render :new
  end


  def create
    @student = Student.new(student_params)

    if @student.save
      flash[:notice] = 'Aluno cadastrado com sucesso.'
      redirect_to root_path
    else
      flash[:alert] = 'Ocorreu um erro ao cadastrar o aluno.'
      render :new
    end
  end

  def send_ticket
    @student = Student.new(student_params)

    if @student.valid?
      generate_and_save_ticket(@student)
      StudentMailer.ticket_email(@student).deliver_now
      flash[:notice] = 'Ingresso enviado por email com sucesso.'
      redirect_to root_path
    else
      flash[:alert] = 'Ocorreu um erro ao enviar o email.'
      render :new
    end
  end

  private

  def student_params
    params.require(:student).permit(:name, :email, :phone)
  end

  def generate_and_save_ticket(student)
    # Lógica para gerar e salvar o ticket
    # Por exemplo:
    ticket_image = MiniMagick::Image.open(Rails.root.join('app', 'assets', 'images', 'template_ticket.png'))
    ticket_image.combine_options do |c|
      #c.gravity 'Center'
      c.pointsize '21'
      c.fill 'white' 
      c.draw "text 85,140 '#{student.name}'"
      c.fill 'yellow'
      c.pointsize '15'
      c.draw "text 117,238 '#{student.phone}'"
      # Adicione mais campos conforme necessário
    end
    ticket_image.write(Rails.root.join('public', 'tickets_users', "ticket_#{student.id}.png"))
    # Agora o ticket será salvo em public/tickets_users com o nome ticket_#{student.id}.png
  end
  
end
