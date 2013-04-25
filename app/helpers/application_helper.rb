module ApplicationHelper
	def flash_class(type)
		case type
		when :alert
			"alert-mess"
		when :notice
			"notice-mess"
		else
			""
		end
	end
end
