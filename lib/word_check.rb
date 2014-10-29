module WordCheck
  class WordCheck

    SWEARWORDS = %w(shit piss fuck cunt cocksucker tits bitch asshole crap)

    COMMONWORDS = %w(el que y Y de la en lo q es a no d me con No un por si del se para Pero los
                     al esta bueno t Pero ha o ya Ya muy le bien Pero ver mas he te hay una
                     1 2 3 4 5 6 7 8 9 0 Pero tiene las Yo yo va dos eso hoy digo Como como
                     ok OK Ok creo Voy voy sale ser nos media-omitted)

    def self.count_for_user(word, line, user)
      (line.downcase.include?(word.downcase) && line.downcase.include?(user.downcase))? 1 : 0
    end

    def self.find_most_frequent(lines, iterator)
      huge_array, hash = [], Hash.new(0)
      lines.split('\n').each do |line|
        line = line.gsub(/(\d{2}:\d{2},\s\d{2}\s\w{3}\s-\s)([^:]+)/) {"#{$2.capitalize}"}
        line = line.gsub(/^.+:/,'')
        line = line.gsub(/\n/,"")
        line = line.gsub('<Media omitted>', 'media-omitted')
        line = line.gsub('<Archivo omitido>', 'media-omitted')
        split_up = line.split(" ") if line
        huge_array << split_up if split_up.length > 0
      end
      huge_array.flatten!
      huge_array.each { |word| hash[word] += 1 }
      array = hash.sort_by {|_key, value| value}.reverse[0..150]
      array = self.clear_common_words(array)
      iterator.set_most_frequent(array)
    end

    def self.clear_common_words(array)
      filtered_array = []
      array.each do |x|
        filtered_array << x unless WordCheck::COMMONWORDS.include?(x[0].downcase)
      end
      filtered_array[0,10].reverse
    end
  end
end