class WordChainer

  def initialize(dictionary_file_name)
    @dictionary = File.readlines(dictionary_file_name).map(&:chomp)
  end

  def adjacent_words(word)
    @dictionary.select{|wrd| wrd.length == word.length}.select do |wrd|
      diff = 0
      wrd.length.times{|i| diff += 1 if wrd[i] != word[i]}
      diff == 1
    end
  end

  def run(source, target)
    @source = source
    @target = target
    @current_words = [source]
    @all_seen_words = {source => nil}
    until @current_words.empty?
      @current_words = explore_current_words
    end

    build_path(target)
  end

  def explore_current_words
    new_current_words = []

    @current_words.each do |current_word|
      adjacent_words(current_word).each do |adjacent_word|
        next if @all_seen_words.include?(adjacent_word)

        new_current_words << adjacent_word
        @all_seen_words[adjacent_word] = current_word
        return [] if adjacent_word == @target
      end
    end

    new_current_words
  end

  def build_path(target)
    path = []

    until target == @source
      path.unshift(target)
      target = @all_seen_words[target]
    end

    path.unshift(@source)
  end

end

if __FILE__ == $PROGRAM_NAME
  word = WordChainer.new('./dictionary.txt')
  p word.run('market', 'rubber')
end
