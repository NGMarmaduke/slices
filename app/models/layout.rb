class Layout
  def self.all
    files.map do |layout|
      layout = layout.split('/').last.gsub(Regexp.new(file_extension), '')
      [layout.titleize, layout]
    end
  end

  def self.files
    files = []
    SlicesController.view_paths.each do |resolver|
      query = File.join(resolver, 'layouts', "*#{file_extension}")
      files.concat(Dir.glob(query))
    end
    files.delete_if{|f| f.include?('admin.html.')}.uniq.sort
  end

  def self.file_extension
    '.html.*'
  end

  def initialize(name)
    @name = name
  end

  def path
    self.class.files.select do |path|
      Regexp.new("#{@name}#{self.class.file_extension}") =~ path.split('/').last
    end.first
  end

  def containers
    parser = Slices::ContainerParser.new(path)
    parser.parse
  end

end
