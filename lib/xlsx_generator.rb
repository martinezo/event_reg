class XlsxGenerator

  def self.xlsx_participants(participants, course)

   package = Axlsx::Package.new
    workbook = package.workbook

    # participants = Catalogs::Participant.search(params[:search], params[:course_id]).order("#{sort_column} #{sort_direction}").for_course(params[:course_id])
    # participants = Catalogs::Participant.where(course_id: params[:course_id]).for_course(params[:course_id])
    # course = Catalogs::Course.find(params[:course_id])

    workbook.add_worksheet(name: "Participantes" ) do |sheet|
      # Styles for cells
      title = sheet.styles.add_style sz: 16, b: 1
      headers = sheet.styles.add_style sz: 12, alignment: { horizontal: :left }, b: 1, fg_color: '000000', bg_color: "dee1e3"

      # Course name and start date
      sheet.add_row ["#{course.title} (#{I18n.localize(course.start_date, :format => :long_only_date)})"], :style => title, :widths=>[6]
      sheet.add_row

      # Records header
      values = ['No.']
      Catalogs::Participant.fields_for_course(course.id).each do |f|
        case f
          when :opt_text
            values << course.opt_text
          when :opt_str1
            values << course.opt_str1
          when :opt_str2
            values << course.opt_str2
          when :opt_bol1
            values << course.opt_bol1
          when :opt_bol2
            values << course.opt_bol2
          when :opt_sel
            values << course.opt_sel
          when :upload_file1
            values << course.upload_file1_desc
          when :upload_file2
            values << course.upload_file2_desc
          when :upload_file3
            values << course.upload_file3_desc
          else
            values << I18n.t("activerecord.attributes.catalogs/participant.#{f.to_s}")
        end
      end

      sheet.add_row values, :style => headers

      # Records
      participants.each_with_index  do |r,i|
        values = [i+1]
        r.attributes.each do |f|
          case f[0]
            when 'inv_state_id'
              values << r.state.name
            else
              values << f[1]
          end
        end
        sheet.add_row values
      end
    end
    package.serialize('public/xlsx/participants.xlsx')
    # send_file("#{Rails.root}/public/xlsx/participants.xlsx", filename: "Participants.xlsx", type: "application/vnd.ms-excel")
  end
end