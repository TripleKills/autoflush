class Tasks < ActiveRecord::Base
	attr_accessible  :date, :target, :url_name, :current
end
