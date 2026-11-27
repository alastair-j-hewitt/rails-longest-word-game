require "set"

class GamesController < ApplicationController
  LETTERS = ("A".."Z").to_a
  GRID_SIZE = 10

  # Word list: WORDS_FILE if set, else db/words.txt, else the system dictionary
  # (macOS and most Linux systems ship /usr/share/dict/words).
  def self.dictionary_path
    candidates = [ENV["WORDS_FILE"], Rails.root.join("db", "words.txt").to_s, "/usr/share/dict/words"]
    candidates.compact.find { |path| File.exist?(path) }
  end

  def self.dictionary
    if @dictionary.nil?
      path = dictionary_path
      if path.nil?
        raise "No word list found. Set WORDS_FILE or add db/words.txt (see README)."
      end
      @dictionary = Set.new(File.readlines(path, chomp: true).map(&:upcase))
    end
    @dictionary
  end

  def new
    @letters = Array.new(GRID_SIZE) { LETTERS.sample }
  end

  def score
    @word = params[:word].to_s.strip.upcase
    @letters = params[:letters].to_s.split
    if !fits_grid?(@word, @letters)
      @result = "Sorry, #{@word} can't be built out of #{@letters.join(', ')}."
    elsif !self.class.dictionary.include?(@word)
      @result = "Sorry, #{@word} does not seem to be a valid English word."
    else
      @result = "Congratulations! #{@word} is a valid English word."
    end
  end

  private

  # Every letter of the word must be available in the grid, counting repeats.
  def fits_grid?(word, letters)
    if word.empty?
      return false
    end
    word.chars.uniq.all? { |letter| word.count(letter) <= letters.count(letter) }
  end
end
