class PdfGenerator

  require 'prawn'
  require 'prawn/table'
  require 'prawn/measurement_extensions'

  def self.registration(r, filename)
    Prawn::Document.generate(filename, left_margin: 1.in) do
      #stroke_axis
      img = "public/pdf/assets/pdf_header.jpg"
      table [[{image: img, fit: [500, 200]}]], position: :center,
            cell_style: {background_color: r.course.color_theme1, padding: 0, border_width: 0}

      pad(20) { text r.course.name, align: :center, style: :bold, size: 14 }

      # TABLE FORMAT
      c_style = {height: (0.25).in, padding: 3, size: 10, border_color: r.course.color_theme1, valign: :middle}
      c_style_h = {background_color: r.course.color_theme_l(2, 0.5), align: :right, font_style: :bold_italic}
      c_style_d = {}
      alt_1, alt_2= r.course.color_theme_l(2, 0.7), r.course.color_theme_l(2, 0.8)

      # REGISTRATION DATE
      headers = [[I18n.t('pdf.reg_date')]]
      data = [[I18n.localize(r.created_at, :format => :long_only_date)]]
      col_1 = make_table headers, column_widths: 2.in, cell_style: c_style.merge(c_style_h)
      col_2 = make_table data, column_widths: 2.in, cell_style: c_style.merge(c_style_d)
      table [[col_1, col_2]], position: :right

      # EVENT START DATE
      headers = [[I18n.t('pdf.start_date')]]
      data = [[I18n.localize(r.course.start_date, :format => :long_only_date)]]
      col_1 = make_table headers, column_widths: 2.in, cell_style: c_style.merge(c_style_h)
      col_2 = make_table data, column_widths: 2.in, cell_style: c_style.merge(c_style_d)
      table [[col_1, col_2]], position: :right

      move_down (0.12).in

      # GENERAL INFO
      pad(10) { text I18n.t('pdf.general_info'), style: :bold, size: 12 }

      headers = [[I18n.t('pdf.name')], [I18n.t('pdf.mail')], [I18n.t('pdf.phone_numbers')], [I18n.t('pdf.workplace')]]
      data = [[r.complete_name], [r.mail], [r.phone_numbers], [r.workplace]]
      col_1 = make_table headers, column_widths: 2.in, cell_style: c_style.merge(c_style_h)
      col_2 = make_table data, column_widths: 5.in, row_colors: [alt_1, alt_2], cell_style: c_style.merge(c_style_d)
      table [[col_1, col_2]]

      move_down (0.12).in

      # ACADEMIC INFO
      if r.course.academic_data_required
        pad(10) { text I18n.t('pdf.academic_info'), style: :bold, size: 12 }
        headers = [[I18n.t('pdf.bachelor_deg')], [I18n.t('pdf.master_deg')], [I18n.t('pdf.phd_deg')]]
        data = [[r.bachelor_deg], [r.master_deg], [r.phd_deg]]
        col_1 = make_table headers, column_widths: 2.in, cell_style: c_style.merge(c_style_h)
        col_2 = make_table data, column_widths: 5.in, row_colors: [alt_1, alt_2], cell_style: c_style.merge(c_style_d)
        table [[col_1, col_2]]
      end

      # INVOICE INFO
      if r.invoice_required
        pad(10) { text I18n.t('pdf.invoice_info'), style: :bold, size: 12 }
        headers = [[I18n.t('pdf.inv_name')], [I18n.t('pdf.inv_rfc')], [I18n.t('pdf.inv_address')],
                   [I18n.t('pdf.inv_municipality')], [I18n.t('pdf.inv_city')],
                   [I18n.t('pdf.inv_state')], [I18n.t('pdf.inv_mail')]]
        data = [[r.inv_name], [r.inv_rfc], [r.inv_address], [r.inv_municipality], [r.inv_city], [r.inv_state], [r.inv_mail]]
        col_1 = make_table headers, column_widths: 2.in, cell_style: c_style.merge(c_style_h)
        col_2 = make_table data, column_widths: 5.in, row_colors: [alt_1, alt_2], cell_style: c_style.merge(c_style_d)
        table [[col_1, col_2]]
      end

      # ADDITIONAL INFO
      if !(r.course.opt_text+r.course.opt_str1+r.course.opt_str2+r.course.opt_bol1+r.course.opt_bol2+r.course.opt_sel).strip.empty?

        pad(10) { text I18n.t('pdf.additional_info'), style: :bold, size: 12 }

        # FORMAT FOR OPTIONAL FIELDS
        c_style1 = {padding: 3, size: 10, border_color: r.course.color_theme1, valign: :middle}
        c_style_h1 = {background_color: r.course.color_theme_l(2, 0.5), align: :right, font_style: :bold_italic}

        if !r.course.opt_text.strip.empty?
          headers = [[r.course.opt_text]]
          data = [[r.opt_text]]
          col_1 = make_table headers, column_widths: 2.in, cell_style: c_style1.merge(c_style_h)
          col_2 = make_table data, column_widths: 5.in, row_colors: [alt_1, alt_2], cell_style: c_style1.merge(c_style_d)
          table [[col_1, col_2]], cell_style: {border_width: 0}
        end

        if !r.course.opt_str1.strip.empty?
          headers = [[r.course.opt_str1]]
          data = [[r.opt_str1]]
          col_1 = make_table headers, column_widths: 2.in, cell_style: c_style1.merge(c_style_h)
          col_2 = make_table data, column_widths: 5.in, row_colors: [alt_1, alt_2], cell_style: c_style1.merge(c_style_d)
          table [[col_1, col_2]], cell_style: {border_width: 0}
        end

        if !r.course.opt_str2.strip.empty?
          headers = [[r.course.opt_str2]]
          data = [[r.opt_str2]]
          col_1 = make_table headers, column_widths: 2.in, cell_style: c_style1.merge(c_style_h)
          col_2 = make_table data, column_widths: 5.in, row_colors: [alt_1, alt_2], cell_style: c_style1.merge(c_style_d)
          table [[col_1, col_2]], cell_style: {border_width: 0}
        end

        if !r.course.opt_bol1.strip.empty?
          headers = [[r.course.opt_bol1]]
          data = [[r.opt_bol1 ? I18n.t('pdf.yes_') : I18n.t('pdf.no_')]]
          col_1 = make_table headers, column_widths: 2.in, cell_style: c_style1.merge(c_style_h)
          col_2 = make_table data, column_widths: 5.in, row_colors: [alt_1, alt_2], cell_style: c_style1.merge(c_style_d)
          table [[col_1, col_2]], cell_style: {border_width: 0}
        end

        if !r.course.opt_bol2.strip.empty?
          headers = [[r.course.opt_bol2]]
          data = [[r.opt_bol2 ? I18n.t('pdf.yes_') : I18n.t('pdf.no_')]]
          col_1 = make_table headers, column_widths: 2.in, cell_style: c_style1.merge(c_style_h)
          col_2 = make_table data, column_widths: 5.in, row_colors: [alt_1, alt_2], cell_style: c_style1.merge(c_style_d)
          table [[col_1, col_2]], cell_style: {border_width: 0}
        end

        if !r.course.opt_sel.strip.empty?
          headers = [[r.course.opt_sel]]
          data = [[r.opt_sel]]
          col_1 = make_table headers, column_widths: 2.in, cell_style: c_style1.merge(c_style_h)
          col_2 = make_table data, column_widths: 5.in, row_colors: [alt_1, alt_2], cell_style: c_style1.merge(c_style_d)
          table [[col_1, col_2]], cell_style: {border_width: 0}
        end
      end

      # LEGEND INVOICE REQUIRED / NOT REQUIRED
      if r.invoice_required
        pad(10) { text I18n.t('pdf.invoice_required'), align: :center, style: :bold, size: 12 }
      else
        pad(10) { text I18n.t('pdf.invoice_not_required'), align: :center, style: :bold, size: 12 }
      end

      # PRICE
      move_down (0.12).in
      cost = 0
      case r.price
        when 1
          cost = r.course.price1 || 0
        when 2
          cost = r.course.price2 || 0
        when 3
          cost = r.course.price3 || 0
      end
      if cost > 0
        headers = [["#{I18n.t('pdf.cost')} (#{eval("r.course.price#{r.price}_desc")})"]]
        data = [["$ #{'%.2f' % cost}"]]
        c_style_d = {align: :right}
        col_1 = make_table headers, cell_style: c_style.merge(c_style_h)
        col_2 = make_table data, column_widths: 1.in, cell_style: c_style.merge(c_style_d)
        table [[col_1, col_2]], position: :right
      end
    end
  end
end