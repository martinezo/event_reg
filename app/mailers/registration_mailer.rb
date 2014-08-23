class RegistrationMailer < ActionMailer::Base
  default from: "computo@inb.unam.mx"

  def participant_reg(participant, attach_file)
    # TODO Customize mail mesagger with field in catalogs course
    # TODO Add email contact in course as required field
    attachments[attach_file] = File.read(attach_file)
    @participant_name = participant.complete_name
    @course_title = participant.course.title
    @info_after_reg = participant.course.info_after_reg
    mail :from => 'computo@inb.unam.mx', :to => participant.mail, :subject => @course_name
  end

  def participant_reg_notification(participant, attach_file)
    attachments[attach_file] = File.read(attach_file)
    @course_title = participant.course.title
    @participant_name = participant.complete_name
    @participant_mail = participant.mail
    @course_contact = participant.course.contact
    case participant.price
      when 1
        @price = '%.2f' % participant.course.price1
      when 2
        @price = '%.2f' % participant.course.price2
      when 3
        @price = '%.2f' % participant.course.price3
    end
    mail :from => 'computo@inb.unam.mx', :to => participant.course.mail_notif_deposit, :subject => @course_name
  end
end
