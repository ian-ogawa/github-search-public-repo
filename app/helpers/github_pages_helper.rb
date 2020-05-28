module GithubPagesHelper
	def get_sort_list
		['best-match', 'stars', 'forks', 'help-wanted-issues', 'updated']
	end

	def format_time(time)
		return time.blank? ? '' : "updated on #{time.to_date.to_formatted_s(:month_day_comma_year)}"
	end

	def min_page(pagination)
		min = pagination[:current].to_i % 5 == 0 && pagination[:current].present? ? pagination[:current].to_i - 1 : pagination[:current].to_i
		group_number = (min / 5) * 5 + 1

		# return pagination[:current].to_i % 5 == 0 && pagination[:current].present? ? group_number - 2 : group_number + 1
	end

	def max_page(min)
		min + 4
	end

	def prev_page(min)
		min == 1 ? 1 : min - 4
	end

	def next_page(min)
		min == 1 ? 1 : min - 4
	end
end
