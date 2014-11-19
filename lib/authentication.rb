module Authentication
  def authenticate(token)
    # load path is funky.
    whitelist = YAML.load_file(File.expand_path('whitelist.yml'))
    whitelist.include?(token)
  end
end
