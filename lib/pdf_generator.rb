class PdfGenerator
  require 'prawn'
  #require "prawn/measurement_extensions"
  #require 'prawn/table'

  def self.registration(model)
    Prawn::Document.generate('registration.pdf', left_margin: 1.in) do
      stroke_axis
      image "public/pdf/assets/pdf_header.jpg"
      pad(20) {text model.course.name, :align => :center, :style => :bold}
      table ['abc']
    end
  end
end