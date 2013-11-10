class TestController < ApplicationController

	def visit()
		#g_visit("test_visit")
		visited1 = Visits.find_by_name("test_visit")
		if visited1.nil?
			visit1 = 0
		else
			visit1 = visited1.times
		end

		visited2 = Visits.find_by_name("test_visit2")
		if visited2.nil?
			visit2 = 0
		else
			visit2 = visited2.times
		end

		visited3 = Visits.find_by_name("test_visit2")
		if visited3.nil?
			visit3 = 0
		else
			visit3 = visited3.times
		end

		@v1 = "test_visit " + visit1.to_s
		@v2 = "test_visit2 " + visit2.to_s
		@v3 = "test_visit3 " + visit3.to_s
		o_visit("test_visit")
	end

	def visit2()
		g_visit("test_visit2")
	end

	def visit3()
		g_visit("test_visit3")
	end

	def g_visit(name)
		times = o_visit(name)
		render :json => {'view'=>name, 'visited'=>times}.to_json
	end

	def o_visit(name)
		visited = Visits.find_by_name(name)
		if visited.nil?
			visited = Visits.create(:name=>name,
				:times => 1)
		end
		visited.times += 1
		visited.save
		visited.times
	end
end
