class TestController < ApplicationController

	def visit()
		#g_visit("test_visit")
		
	end

	def visit2()
		g_visit("test_visit2")
	end

	def visit3()
		g_visit("test_visit3")
	end

	def g_visit(name)
		visited = Visits.find_by_name(name)
		if visited.nil?
			visited = Visits.create(:name=>name,
				:times => 1)
		end
		visited.times += 1
		visited.save
		render :json => {'view'=>name, 'visited'=>visited.times}.to_json
	end
end
