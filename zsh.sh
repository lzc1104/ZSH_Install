#!/bin/bash

. ./include/color.sh # 设置颜色

#关闭selinux
function Coloseselinux() {
  echo "${CSUCCESS}[INFO] ${CBLUE}关闭SELINUX${CEND}"
  [ -s /etc/selinux/config ] && sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0 >/dev/null 2>&1
}

# 安装常用依赖
function InstallDependency() {
   yum -y install wget zip unzip curl
}

# 安装oh-my-zsh 插件
function InstallOMSPlugins() {
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone git://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
  sed -i "s/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/" ~/.zshrc
  source ~/.zshrc
}

#设置时区并同步时间
function Settimezone() {
  echo "${CSUCCESS}[INFO] ${CBLUE}安装ntpdate${CEND}"
  yum -y install ntpdate
  echo "${CSUCCESS}[INFO] ${CBLUE}设置服务器时区${CEND}"
  rm -rf /etc/localtime
  ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
  echo "${CSUCCESS}[INFO] ${CBLUE}同步服务器时间${CEND}"
  ntpdate cn.ntp.org.cn
}

function InstallZSH() {
  echo "${CSUCCESS}[INFO] ${CBLUE}安装ZSH${CEND}"
  yum -y install git zsh
  yum -y groupinstall "Development tools"
  chsh -s /bin/zsh
}

function InstallOMS() {
  echo "${CSUCCESS}[INFO] ${CBLUE}安装oh-my-zsh${CEND}"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
}

function InstallSF() {
  echo '' > /etc/motd
  echo "${CSUCCESS}[INFO] ${CBLUE}安装screenFetch${CEND}"
  cp -r ./include/screenfetch-dev /usr/bin/
  chmod +x /usr/bin/screenfetch-dev
  cp -r ./include/logo.sh /etc/profile.d/
}



InstallDependency
Coloseselinux
Settimezone
InstallSF
InstallZSH
InstallOMS
InstallOMSPlugins
