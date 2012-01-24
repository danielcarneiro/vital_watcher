module ApplicationHelper

	def logo
		image_tag("logo.png", :alt => "Vital Watcher", :class => "round")
	end

	def title
		base_title = "Vital Watcher"
		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end
	end
end
