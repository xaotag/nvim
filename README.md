```bash
克隆仓库 git clone https://github.com/xaotag/nvim ~/.config/nvim

下载packer插件管理器
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

使用下面命令安装插件
nvim  -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```
