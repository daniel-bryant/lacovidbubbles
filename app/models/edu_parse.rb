class EduParse < Parse
  CSV_NAME = "edu_data.csv"

  def parse_doc!
    return if data.any?

    CSV.foreach(csv_path, headers: true) do |row|
      data.create!(row.to_h)
    end
  end

  private

  def csv_path
    Rails.root.join("lib", "csvs", CSV_NAME)
  end
end
