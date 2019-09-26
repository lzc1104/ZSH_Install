
. ./include/color.sh # 设置颜色

# 安装oh-my-zsh 插件
function InstallOMSPlugins() {
  echo "${CSUCCESS}[INFO] ${CBLUE}安装oh-my-zsh 插件${CEND}"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone git://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  sed -i "s/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" ~/.zshrc
  source ~/.zshrc
}

InstallOMSPlugins()