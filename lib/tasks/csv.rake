namespace :csv do
  desc "Generate all CSVs from HTML files"
  task generate_all: :environment do
    Rake::Task["csv:generate_non_res"].invoke
    Rake::Task["csv:generate_edu"].invoke
    Rake::Task["csv:generate_citations"].invoke
  end

  desc "Generate citations CSV from HTML file"
  task generate_citations: :environment do
    doc = Nokogiri::HTML(File.read(Rails.root.join("tmp", "ezsearch_citations.html")))
    trs = doc.css("tr#DataTitleRow, tr#DataTitleRow ~ tr")

    headers = %w(activity_date name address city description)
    CSV.open(Rails.root.join("lib", "csvs", "citations.csv"), 'w',
             write_headers: true, headers: headers) do |csv|
      trs.each do |tr|
        csv << tr.children
          .map(&:text)
          .each { |t| t.gsub!("\u00A0", "") }
          .map(&:strip)
          .reject(&:blank?)
      end
    end
  end

  desc "Generate edu CSV from HTML file"
  task generate_edu: :environment do
    doc = Nokogiri::HTML(File.read(Rails.root.join("tmp", "media_coronavirus_locations.htm")))
    trs = doc.css("div#educational-settings + div.container-xl tbody tr").tap(&:pop)

    headers = %w(obs name address total_staff total_non_staff)
    CSV.open(Rails.root.join("lib", "csvs", "edu_data.csv"), 'w',
             write_headers: true, headers: headers) do |csv|
      trs.each do |tr|
        csv << tr.children.map(&:text)
      end
    end
  end

  desc "Generate non res CSV from HTML file"
  task generate_non_res: :environment do
    doc = Nokogiri::HTML(File.read(Rails.root.join("tmp", "media_coronavirus_locations.htm")))
    trs = doc.css("div#nonres-settings + div.container-xl tbody tr").tap(&:pop)

    headers = %w(obs name address total_staff total_non_staff)
    CSV.open(Rails.root.join("lib", "csvs", "non_res_data.csv"), 'w',
             write_headers: true, headers: headers) do |csv|
      trs.each do |tr|
        csv << tr.children.map(&:text)
      end
    end
  end

  desc "Parse all existing CSVs and load the data."
  task parse_all: :environment do
    ParserJob.perform_now(CitationParse.create!)
    ParserJob.perform_now(EduParse.create!)
    ParserJob.perform_now(NonResParse.create!)
  end
end
