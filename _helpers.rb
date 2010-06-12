require 'cgi'
require 'grit'
require 'pathname'

module Helpers
  include Jekyll::Filters
  def format_date date
    date.strftime('%a, %d %B %Y')
  end

  def urlencode s
    CGI.escape s
  end

  def sort_categories categories
    categories.to_a.sort
  end

  def category_url category
    "/categories.html##{urlencode(category)}"
  end

  def mtime file
    File.mtime file
  end

  def latest_mtime files
    files.map{|file| mtime file}.sort.last
  end

  def last_commit file
    @repo ||= Grit::Repo.new '.'
    @file_index ||= Grit::Git::FileIndex.new '.git'

    working_dir = Pathname.new('.').realpath
    file_path = Pathname.new(file).realpath
    relative_path = file_path.relative_path_from(working_dir)

    commits = @file_index.commits_for relative_path.to_s
    return mtime file if !commits

    @repo.commit(commits.first).date
  end
end
