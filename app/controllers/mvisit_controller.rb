class MvisitController < ApplicationController

	def visitx
		tasks = Tasks.all
		t_urls = {}
		tasks.each do |task|
			url_record = Urls.find_by_name(task.url_name)
			if judge_need_show(task.target, task.current) 
				url = process_url(url_record.url, url_record.url_type)
				t_urls[url_record.name] = url
			end
		end

		s_urls = []
		url_names = nil
		t_urls.each {|k,v|
			if url_names.nil?
				url_names = k
			else
				url_names += ("-" + k)
			end
			s_urls.push(v)
		}

		#render :json => {'url_names'=>url_names, 's_urls'=>s_urls}.to_json
		@visit_inner = "http://127.0.0.1:3000/visitinner?tasks=" + url_names
		@s_urls = s_urls
	end

	def visitinner
		if params[:tasks].nil?
			render :json => {'result_code'=>1, 'result_msg'=>'parameters error'}.to_json
			return
		end

		task_names = params[:tasks].split(/-/)
		names = nil
		task_names.each {|task_name|
			o_visit(task_name)
			if names.nil?
				names = task_name
			else
				names += ("|" + task_name)
			end
		}
		render :json => {'result_code'=>0, 'result_msg'=>names}.to_json
	end

	private
	def process_url(url, url_type)
		url
	end


	#to determine whether need show this task
	def judge_need_show(target, current)
		current_target = calc_current_target(target, Time.now.hour, Time.now.min)
		current < current_target
	end

	#calculate show times must have at current
	def calc_current_target(target, hour, minute)
		#w = [70, 40, 10, 8, 7, 9, 15, 20, 50, 70, 90, 100, 100, 80, 70, 60, 70, 90, 100, 100, 95, 98, 85, 80]
		weights = [0.046, 0.026, 0.007, 0.005, 0.005, 0.006, 0.01, 0.013, 0.033, 0.046, 0.059, 0.066, 
				   0.066, 0.053, 0.046, 0.04, 0.046, 0.059, 0.066, 0.066, 0.063, 0.065, 0.056, 0.053]
	    hour = hour % 24
	    sum = 0
	    weights.each_index{|index|
	    	if index < hour
	    		sum += weights[index]
	    	elsif index == hour
	    		sum += (weights[index] * (minute/60.0))
	    	end
	    }
	    sum * target
	end

	#write visit record
	def o_visit(name)
		task = Tasks.find_by_url_name(name)
		if !task.nil?
			task.current += 1
			task.save
		end
	end
end