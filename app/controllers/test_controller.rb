class TestController < ApplicationController

	def visit()
		#g_visit("test_visit")
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

		@v2 = "test_visit2 " + visit2.to_s
		@v3 = "test_visit3 " + visit3.to_s
		@localhost = get_local_ip
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

	require 'socket'  
def get_local_ip    
  orig, Socket.do_not_reverse_lookup = Socket.do_not_reverse_lookup, true    
# turn off reverse DNS resolution temporarily    
   
  UDPSocket.open do |s|    
    s.connect '64.233.187.99', 1  #google的ip  
    s.addr.last    
  end    
ensure    
  Socket.do_not_reverse_lookup = orig    
end
end
