function gitlg --wraps='git log --graph --abbrev-commit --pretty=oneline --decorate' --description 'alias gitlg git log --graph --abbrev-commit --pretty=oneline --decorate'
  git log --graph --abbrev-commit --pretty=oneline --decorate $argv
        
end
