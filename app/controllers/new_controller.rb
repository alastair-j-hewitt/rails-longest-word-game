class NewController < ApplicationController
  def new_game
    ran_arr = print (0...8).map { (65 + rand(26)).chr };
  end

  def score
  end
end
