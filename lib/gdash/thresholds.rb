require 'graphite_graph'

class GraphiteGraphThresholds < GraphiteGraph
	attr_accessor :properties, :file

	def critical(options)
		raise "critical lines need a value" unless options[:value]
		
		if @critical_threshold.class != Array
			@critical_threshold = Array.new
		end

		threshold = {
			"name" => options[:name],
			"value" => options[:value]
		}

		@critical_threshold << threshold    
	end

	def defaults
		super()
		@properties.merge!({:hostname => nil})
	end
end