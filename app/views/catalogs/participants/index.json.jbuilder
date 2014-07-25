json.array!(@catalogs_participants) do |catalogs_participant|
  json.extract! catalogs_participant, :id, :course_id, :name, :surnames, :mail, :phone_numbers, :workplace, :bachelor_deg, :master_deg, :phd_deg, :inv_name, :inv_rfc, :inv_address, :inv_city, :inv_municipality, :inv_state, :inv_email, :opt_text, :str_op1, :opt_str1, :opt_str2, :opt_bol1, :opt_bol2, :opt_sel, :confirmed, :price
  json.url catalogs_participant_url(catalogs_participant, format: :json)
end
