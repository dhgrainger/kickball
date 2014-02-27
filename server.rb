require 'sinatra'
require 'CSV'
require 'pry'



 def read
  teams = []
    CSV.foreach('lackp_starting_rosters.csv', headers: true) do |row|
      teams << row.to_hash
    end
  teams
end

def team_names
  team_names = []
      read.each do |hash|
        team_names << hash["team"]
      end
  team_names = team_names.uniq
end

def player_info(teams)
  team = []
  read.each do |hash|
    if hash["team"] == teams
      team << hash.values
    end
  end
  #binding.pry
  return team
end


team_names.each do |teams|
  get "/#{URI::encode(teams)}" do
    @players = player_info(teams)
    @current_team = teams
    #binding.pry
    erb :team
  end
end



get '/' do
   @teams = team_names
   erb :kickball
 end




