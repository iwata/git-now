require 'formula'

class GitNow < Formula
  url  'https://github.com/iwata/git-now.git', :tag => 'v0.1.0.3'
  version '0.1.0.3'
  head 'https://github.com/iwata/git-now.git', :branch => 'develop'
  homepage 'https://github.com/iwata/git-now'

  def options
    [['--ln-gnu-getopt', "Link a gnu-getopt formula"]]
  end

  # for longopt
  if ARGV.include? '--ln-gnu-getopt'
    depends_on 'gnu-getopt'
  end

  def install
    system "make", "prefix=#{prefix}", "install"
    if ARGV.include? '--ln-gnu-getopt'
      system "brew ln gnu-getopt"
    end
  end

end
