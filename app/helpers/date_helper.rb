module DateHelper

  def self.included(klass)

    
    # this code adds a formatted_* field to each date stored in a model
    # so, for example, if a start_date field is in the model, this method
    # will generated a format_start_date method that has the format 
    # Month, Day, Year (e.g. Jan 12, 1933)
    if klass.respond_to?(:column_names) #line added to avoid mixin with modules
        
        # get all dates
        # Loop through the class's column names
        # then determine if each column is of the :date type.
        fields = klass.column_names.select do |k| 
                      klass.columns_hash[k].type == :date
                    end


        # for each of the fields we'll use class_eval to
        # define the methods.
        fields.each do |field|
          klass.class_eval <<-EOF
            def formatted_#{field}
              #{field}.strftime('%b %d, %Y') unless #{field}.nil?
            end

          EOF
        end
    end
  end
end

