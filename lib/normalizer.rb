module Normalizer
  class Engine
    def self.normalize(line)
      if line.scan(/\d{2}:\d{2},\s\d{2}\s\w{3}\s-\s[^:].+/)[0] == line
        line
      elsif line.include?("changed the subject") || line.scan(/joined$/).first == "joined"
        line = ""
      else
        self.change_format(line)
      end
    end

    def self.change_format(line)
      copy = line.dup.force_encoding("UTF-8")

      datetime, copy = copy.split('-', 2)
      name, msg = copy.split(':', 2) rescue ['','']

      datetime = datetime.strip.sub('de', '')
      datetime = DateTime.parse(datetime) rescue DateTime.new
      better_date = datetime.strftime("%H:%M, %m %b")

      name.strip! rescue nil
      msg.strip! rescue nil

      puts datetime
      puts better_date
      puts name
      puts msg

      return_value = "#{better_date} - #{name}: #{msg}"


      # date = copy.match(/(\d+\/\d+\/\d+),?\s(\d+:\d+:\d+)\s(\w+:)\s([^:].+):(.+)/) { $1 }
      # time = copy.match(/(\d+\/\d+\/\d+),?\s(\d+:\d+:\d+)\s(\w+:)\s([^:].+):(.+)/) { $2 }
      # name = copy.match(/(\d+\/\d+\/\d+),?\s(\d+:\d+:\d+)\s(\w+:)\s([^:].+):(.+)/) { $4 }
      # msg  = copy.match(/(\d+\/\d+\/\d+),?\s(\d+:\d+:\d+)\s(\w+:)\s([^:].+):(.+)/) { $5 }
      #
      # date_array = date.split("/") # Get an array like [21,12,13] from 12/12/13
      # time_array = time.split(":") # Get an array like [15,04,3] from 15:04:3
      #
      # if date_array[0].length == 4
      #   date_array_year = date_array[0].to_i
      #   date_array_month = date_array[1].to_i
      #   date_array_day = date_array[2].to_i
      # else
      #   date_array_year = date_array[2].to_i
      #   date_array_month = date_array[0].to_i
      #   date_array_day = date_array[1].to_i
      # end
      #
      # # Convert so that it's DateTime.new(yy,mm,dd)
      # better_date = DateTime.new(date_array_year,
      #                            date_array_month,
      #                            date_array_day,
      #                            time_array[0].to_i,
      #                            time_array[1].to_i,
      #                            time_array[2].to_i)
      #
      #
      #
      #
      # better_date = better_date.strftime("%H:%M, %m %b")
      # return_value = "#{better_date} - #{name}: #{msg}"
    end
  end
end