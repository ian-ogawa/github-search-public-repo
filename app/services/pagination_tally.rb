module PaginationTally

	def get_last_page(splitted_link)
		last = splitted_link.find { |e| /last/ =~ e }
		last.nil? ? 0 : last.match(/page=(\d+).*$/)[1].to_i
	end

	def get_min(current, last_page)
		remain_pages = last_page - current

		if remain_pages < 2
			current - 3
		else
			current > 2 ? current - 2 : 1
		end
	end

	def get_max(current, last_page)
		current = current == 0 ? 1 : current
		last_page = last_page == 0 ? current : last_page

		if current < 3
			last_page > 4 ? 5 : last_page
		else
			last_page - current > 2 ? current + 2 : last_page
		end
	end
end