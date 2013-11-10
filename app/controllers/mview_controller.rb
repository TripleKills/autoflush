class MviewController < ApplicationController

	def addurl
	  if params[:name].nil? or params[:url].nil? or params[:type].nil?
      	render :json => {'result_code'=>1, 'result_msg'=>'parameters error'}.to_json
      	return
  	  end

      url_record = Urls.find_by_name(params[:name])
      if !url_record.nil?
      	render :json => {'result_code'=>2, 'result_msg'=>'url exists'}.to_json
      	return
      end

      Urls.create(
      	:name=>params[:name],
      	:url=>params[:url],
      	:url_type=>params[:type]
      	)
      render :json => {'result_code'=>0, 'result_msg'=>'success'}.to_json
	end

	def delurl
		if params[:name].nil?
			render :json => {'result_code'=>1, 'result_msg'=>'parameters error'}.to_json
			return
		end

		url_record = Urls.find_by_name(params[:name])
      	if url_record.nil?
      		render :json => {'result_code'=>2, 'result_msg'=>'url not exists'}.to_json
      		return
      	end

      	url_record.destroy
      	render :json => {'result_code'=>0, 'result_msg'=>'success'}.to_json
	end

	def addtask
		if params[:name].nil?
      		render :json => {'result_code'=>1, 'result_msg'=>'parameters error'}.to_json
      		return
      	end

      	url_record = Urls.find_by_name(params[:name])
      	if url_record.nil?
      		render :json => {'result_code'=>2, 'result_msg'=>'url not exists'}.to_json
      		return
      	end

      	task_record = Tasks.find_by_url_name(params[:name])
      	if !task_record.nil?
      		render :json => {'result_code'=>3, 'result_msg'=>'task exists'}.to_json
      		return  		
      	end

      	params[:target] = 1000 unless !params[:target].nil?

      	date = DateTime.parse(Time.now.to_s).strftime('%Y-%m-%d')
      	Tasks.create(
      		:url_name=>params[:name],
      		:target=>params[:target],
      		:date=>date
      		)
      	render :json => {'result_code'=>0, 'result_msg'=>'success'}.to_json
	end

	def deltask
		if params[:name].nil?
      		render :json => {'result_code'=>1, 'result_msg'=>'parameters error'}.to_json
      		return
      	end

      	task_record = Tasks.find_by_url_name(params[:name])
      	if task_record.nil?
      		render :json => {'result_code'=>2, 'result_msg'=>'url not exists'}.to_json
      		return
      	end

      	task_record.destroy
      	render :json => {'result_code'=>0, 'result_msg'=>'success'}.to_json
	end
end
