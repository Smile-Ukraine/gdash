require 'graphite_graph'

class GraphiteGraphControlChart < GraphiteGraph
	attr_accessor :properties, :file, :control_chart

	def controlchart(options)
		raise "Control charts needs a stdev and average defined" unless (options[:stdev] || options[:average])

		@control_chart = {
			"stdev" => options[:stdev],
			"average" => options[:average]
		}
		unless options[:hide]
			for sigma in -3..3
				threshold = options[:stdev].to_f * sigma + options[:average].to_f
				line :caption => sigma != 0 ? "#{sigma}S" : "Average", :value => threshold, :color => "green", :dashed => true unless threshold <= 0
			end
		end
	end

	def defaults
		super()
		@properties.merge!({:hostname => nil})
	end
end