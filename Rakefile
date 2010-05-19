task :default => [:build]

ENVIRONMENT = ENV['ENV'] || nil

namespace :site do
  desc "delete _site"
  task :delete do
    puts "delete _site"
    system 'rm -r _site'
  end

  desc "build _site"
  task :build => :delete do |t, args|
    jekyll_args = []
    if ENVIRONMENT
      jekyll_args += ['--environment', ENVIRONMENT]
    end
    puts "build site (#{ENVIRONMENT})"
    puts "running jekyll #{jekyll_args.join(' ')}"
    system "jekyll", *jekyll_args
  end

  desc "handling asset transformations"
  namespace :assets do
    file "_site/css/combined.css" => ["_site/css/site.css", "_site/css/highlight.css"] do |t|
      puts "build #{t.name}"
      File.open t.name, 'w' do |f|
        t.prerequisites.each do |css|
          f.puts File.read(css)
        end
      end
    end

    desc "create combined CSS"
    task :combine => '_site/css/combined.css'

    require 'yui/compressor'
    desc 'create minified JS and CSS with YUI compressor'
    task :minify do
      puts 'minify JS and CSS with YUI Compressor'
      js_compressor = YUI::JavaScriptCompressor.new
      css_compressor = YUI::CssCompressor.new

      Dir['_site/css/*.css', '_site/js/*.js'].each do |filename|
        ext = File.extname filename
        compressor = (ext == '.js') ? js_compressor : css_compressor
        compressed = compressor.compress File.read(filename)

        File.open(filename, 'w') do |file|
          file.write compressed
        end
      end
    end

    desc 'create pre-gzipped files'
    task :gzip do
      puts "gzip HTML, JS and CSS"
      Dir['_site/**/*.html', '_site/**/*.css', '_site/**/*.js'].each do |filename|
        system 'pigz', '-0kf', filename
        system 'advdef', '-zq4', "#{filename}.gz"
      end
    end

    desc 'do all asset tasks'
    task :all => [:combine, :minify, :gzip]
  end
end

desc "build site and assets"
task :build => [:"site:build", :"site:assets:all"]

desc "build and deploy site"
task :deploy => :build do
  #todo
end
