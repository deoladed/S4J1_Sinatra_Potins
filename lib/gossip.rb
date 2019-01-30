require 'csv'
class Gossip
	attr_accessor :author, :content

	def initialize(author, content)
		@author = author
		@content = content
	end

	def save
		CSV.open("./db/gossip.csv", "ab") do |csv|
			csv << [@author, @content]
		end
	end

	def self.all
		@all_gossips = []
		CSV.read("./db/gossip.csv").each do |csv_line|
			@all_gossips << Gossip.new(csv_line[0], csv_line[1])
		end
		return @all_gossips
	end

	def self.id(id)
		Gossip.all[id - 1]
	end

	def self.editgossip(gossipnr, author, content)
		newgossip = []
		csv = CSV.read("./db/gossip.csv").each do |gossip|
			if gossip.include?(Gossip.id(gossipnr).content)
				newgossip << [author, content]
			else
				newgossip << gossip
			end
		end

		CSV.open('./db/gossip.csv', 'w+') do |csv_object|
			newgossip.each { |gossip|	csv_object << gossip}
		end
	end
end

# p Gossip.id(2).content
# Gossip.editgossip(2, "Juju", "A mort le metal")