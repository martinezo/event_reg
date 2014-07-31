class RegistrationMailer < ActionMailer::Base
  default from: "computo@inb.unam.mx"

  def participant_reg(participant, attach_file)
    # TODO Customize mail mesagger with field in catalogs couse
    attachments[attach_file] = File.read(attach_file)
    @participant = participant
    mail :from => 'computo@inb.unam.mx', :to => participant.mail, :subject => participant.course.name
  end

  def participant_reg_notification(participant, attach_file)
    attachments[attach_file] = File.read(attach_file)
    @participant = participant
    case @participant.price
      when 1
        @price = '%.2f' % @participant.course.price1
      when 2
        @price = '%.2f' % @participant.course.price2
      when 3
        @price = '%.2f' % @participant.course.price3
    end
    mail :from => 'computo@inb.unam.mx', :to => participant.course.mail_notif_deposit, :subject => participant.course.name
  end
end
