env_paths = ['', "#{Rails.env}/"]
env_paths.each do |env_path|
  list_file = "#{Rails.root}/db/seed/#{env_path}_list.txt"
  p "list_file: #{list_file}"

  File.open(list_file) do |lists|
    lists.each_line do |list|
      p "list: #{list.chomp}"

      target_model = list.chomp.classify.constantize
      p "target_model: #{target_model}"

      yml_file = "#{Rails.root}/db/seed/#{env_path}#{list.chomp}.yml"
      p "yml_file: #{yml_file}"

      File.open(yml_file) do |file_contents|
        yaml_contents = YAML.safe_load(file_contents)
        count = yaml_contents.count
        p "count: #{count}"

        yaml_contents.each.with_index(1) do |yaml_record, index|
          id = yaml_record['id']
          target = "[#{index}/#{count}] id: #{id}"

          if target_model.find_by(id: id)
            p "#{target} Skip create"
            next
          end

          p "#{target} Create"
          target_model.create!(yaml_record)
        end
      end
    end
  end
end

common_table_name = %w(required_point)
common_table_name.each do |table_name|
  path = Rails.root.join('db', 'seed', "#{table_name}.rb")
  if File.exist?(path)
    puts "Creating #{table_name}....."
    require(path)
  end
end
