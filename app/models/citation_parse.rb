class CitationParse < Parse
  CSV_NAME = "citations.csv"

  def parse_doc!
    return if citations.any?

    CSV.foreach(csv_path, headers: true) do |row|
      citations.create!(row.to_h)
    end
  end

  private

  def csv_path
    Rails.root.join("lib", "csvs", CSV_NAME)
  end
end
