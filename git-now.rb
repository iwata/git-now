require 'formula'

class GitNow < Formula
  url  'https://github.com/iwata/git-now.git', :tag => 'v0.1.0.8.1'
  version '0.1.0.8.1'
  head 'https://github.com/iwata/git-now.git', :branch => 'develop'
  homepage 'https://github.com/iwata/git-now'

  def options
    [
        ['--gnu-getopt', "Link a gnu-getopt formula"],
        ['--zsh-completion', "copy zsh completion function file to #{share}/zsh/functions"]
    ]
  end

  # for longopt
  if ARGV.include? '--gnu-getopt'
    depends_on 'gnu-getopt'
  end
  if ARGV.include? '--zsh-completion'
    depends_on 'zsh'
  end

  def install
    system "make", "prefix=#{prefix}", "install"
    if ARGV.include? '--gnu-getopt'
      system "brew ln gnu-getopt"
    end
    if ARGV.include? '--zsh-completion'
      zsh_functions_d = share + 'zsh/functions'
      zsh_functions_d.install "etc/_git-now"
    end
  end

end
