require 'formula'

class GitNow < Formula
  url  'https://github.com/iwata/git-now.git', :tag => 'v0.1.0.5'
  version '0.1.0.5'
  head 'https://github.com/iwata/git-now.git', :branch => 'develop'
  homepage 'https://github.com/iwata/git-now'

  def options
    [
        ['--gnu-getopt', "Link a gnu-getopt formula"],
        ['--zsh-completion', "copy zsh completion function file to $fpath"]
    ]
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
        fpath = `echo #{ENV['FPATH']} |cut -d ':' -f 1`
        system "cp etc/_git-now #{fpath}" unless fpath.chomp === ''
    end
  end

end
