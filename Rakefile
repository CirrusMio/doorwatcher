desc 'Get new secure key'
task :secret do
  require 'securerandom'
  puts SecureRandom.hex
end

# log:clear shamelessly stolen from rails
namespace :log do
  desc "Truncates all *.log files in log/ to zero bytes"
  task :clear do
    log_files.each do |file|
      clear_log_file(file)
    end
  end

  def log_files
    FileList["log/*.log"]
  end

  def clear_log_file(file)
    f = File.open(file, "w")
    f.close
  end
end
