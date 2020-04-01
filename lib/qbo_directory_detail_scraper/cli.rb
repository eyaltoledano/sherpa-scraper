class QboDirectoryDetailScraper::CLI
  @@csv_files = []

  def run
    print_intro
    fetch_csv_files
    confirm_csv_files
  end

  def print_intro
    puts "QBO Directory - Details Page Scraper".colorize(:light_magenta)
    puts "------------------------------------".colorize(:light_magenta)
    puts "You can exit at any time by using the 'exit' or 'q' command."
    puts "Please ensure any CSV files in the 'puts_csv_files_here' folder have a URL column.".colorize(:white)
    puts "------------------------------------".colorize(:light_magenta)
  end

  def goodbye
    puts "Exiting tool. Goodbye."
    exit
  end

  def fetch_csv_files
    basedir = '.'
    csv_list = Dir.glob('*/*/*.csv')
    csv_list.each do |csv|
      if !@@csv_files.include?(csv)
        @@csv_files << csv
      end
    end
  end

  def csv_files_present?
    true if @@csv_files.count > 0
  end

  def confirm_csv_files
    if csv_files_present?
      print_found_csv_files
      request_input
    else
      puts "No CSV files were found.".colorize(:yellow)
      goodbye
    end
  end

  def shorthand(full_csv_filename)
    full_csv_filename.split('/')[2].colorize(:light_cyan)
  end

  def print_found_csv_files
    puts "Found these CSV files in the folder:"
    @@csv_files.each_with_index do |csv, index|
      file_name = shorthand(csv)
      puts "#{index + 1}. #{file_name}"
    end
  end

  def request_input
    input = nil

    until (input == "exit" || input == "EXIT" || input == "q")
      print "Enter the number of the file you want to scrape: "
      input = gets.chomp.downcase

      if input.to_i > 0
        if @@csv_files[input.to_i - 1].nil?
          puts "Incorrect selection."
          print_found_csv_files
          puts "You can use 'exit' or 'q' at any time."
        else
          puts "OK. Preparing to scrape #{shorthand(@@csv_files[input.to_i - 1])}"
          scrape_file_by_index(input.to_i - 1)
        end
      end

    end

    goodbye
  end

  def scrape_file_by_index(csv_file_index)
    print "Are you sure you want to scrape #{shorthand(@@csv_files[csv_file_index])} (Y/N)? "
    input = gets.chomp.downcase

    if (input == "y" || input == "Y")
      puts "OK. Here we go."
      ## CALL THE SCRAPE HERE
      puts "Scrape of #{shorthand(@@csv_files[csv_file_index])} completed"
    else
      puts "Cancelling scrape."
      print_found_csv_filesq
    end
  end


end
