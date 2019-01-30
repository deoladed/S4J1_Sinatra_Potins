class Coment
	attr_accessor :page, :user, :comment

	def initialize(page, user, comment)
		@page = page
		@user = user
		@comment = comment
	end

	def create_comment
		CSV.open("./db/comment.csv", "ab") do |csv|
			csv << [@page, @user, @comment]
		end
	end

	def self.all
		all_comment = []
		CSV.read("./db/comment.csv").each do |csv_line|
			all_comment << Coment.new(csv_line[0], csv_line[1], csv_line[2])
		end
		return all_comment
	end

	def self.delete_comment(coment)
		newall_comment = Array.new
		csv = CSV.read("db/comment.csv").each do |comment|
			newall_comment << comment unless comment.include?(coment)
		end

		CSV.open('db/comment.csv', 'w+') do |csv_object|
			newall_comment.each { |comment|	csv_object << comment}
		end
	end
end
