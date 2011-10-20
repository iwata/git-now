require 'formula'

class GitNow < Formula
  url  'https://github.com/iwata/git-now.git', :tag => 'v0.1.0.4'
  version '0.1.0.4'
  head 'https://github.com/iwata/git-now.git', :branch => 'develop'
  homepage 'https://github.com/iwata/git-now'

  def options
    [['--ln-gnu-getopt', "Link a gnu-getopt formula"]]
  end

  # for longopt
  if ARGV.include? '--gnu-getopt'
    depends_on 'gnu-getopt'
  end

  def install
    system "make", "prefix=#{prefix}", "install"
    if ARGV.include? '--gnu-getopt'
      system "brew ln gnu-getopt"
    end
    if ARGV.include? '--zsh-completion'
        fpath = `echo $fpath |cut -d ' ' -f 1`
        system "cp etc/_git-now #{fpath}"
    end
  end

end
