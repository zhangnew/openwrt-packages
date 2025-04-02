<div align="center">
<h1 align="center">同步上游分支代码</h1>
<img src="https://img.shields.io/github/issues/zhangnew/openwrt-packages?color=green">
<img src="https://img.shields.io/github/stars/zhangnew/openwrt-packages?color=yellow">
<img src="https://img.shields.io/github/forks/zhangnew/openwrt-packages?color=orange">
<img src="https://img.shields.io/github/license/zhangnew/openwrt-packages?color=ff69b4">
<img src="https://img.shields.io/github/languages/code-size/zhangnew/openwrt-packages?color=blueviolet">
</div>


#### openwrt-packages

*  常用OpenWrt软件包源码合集，自动同步上游更新！

*  感谢 [kenzok8/small-package](https://github.com/kenzok8/small-package) 以及所有上游仓库开发者！

#### 使用方式：

```bash
 sed -i '$a src-git zpackage https://github.com/zhangnew/openwrt-packages' feeds.conf.default
```
对于强迫症的同学（有报错信息、或Lean源码编译出错的情况），请尝试删除冲突的插件

```bash
rm -rf feeds/zpackage/{base-files,dnsmasq,firewall*,fullconenat,libnftnl,nftables,ppp,opkg,ucl,upx,vsftpd*,miniupnpd-iptables,wireless-regdb}
```

#### Dev

Github Actions: [wall.yml](.github/workflows/wall.yml)
Sync Script: [main.sh](.github/diy/main.sh)
