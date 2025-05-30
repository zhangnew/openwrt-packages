#!/bin/bash
function git_clone() {
  git clone --depth 1 $1 $2 || true
}

function git_sparse_clone() {
  branch="$1" rurl="$2" localdir="$3" && shift 3
  git clone -b $branch --depth 1 --filter=blob:none --sparse $rurl $localdir
  cd $localdir
  git sparse-checkout init --cone
  git sparse-checkout set $@
  mv -n $@ ../
  cd ..
  rm -rf $localdir
}

function mvdir() {
  mv -n `find $1/* -maxdepth 0 -type d` ./
  rm -rf $1
}

git clone --depth 1 https://github.com/derisamedia/luci-theme-alpha
git clone --depth 1 https://github.com/animegasan/luci-app-alpha-config
git clone --depth 1 https://github.com/riverscn/openwrt-iptvhelper && mvdir openwrt-iptvhelper
git clone --depth 1 https://github.com/tty228/luci-app-wechatpush
git clone --depth 1 https://github.com/esirplayground/luci-app-poweroff
git clone --depth 1 https://github.com/brvphoenix/luci-app-wrtbwmon wrtbwmon1 && mvdir wrtbwmon1
git clone --depth 1 https://github.com/brvphoenix/wrtbwmon wrtbwmon2 && mvdir wrtbwmon2
git clone --depth 1 https://github.com/jerrykuku/luci-theme-argon
git clone --depth 1 https://github.com/jerrykuku/luci-app-argon-config
git clone --depth 1 https://github.com/jerrykuku/lua-maxminddb
git clone --depth 1 https://github.com/sirpdboy/luci-app-advanced
git clone --depth 1 https://github.com/sirpdboy/luci-theme-opentopd
git clone --depth 1 https://github.com/sirpdboy/netspeedtest speedtest && mv -f speedtest/*/ ./ && rm -rf speedtest
git clone --depth 1 https://github.com/kenzok8/luci-theme-ifit ifit && mv -n ifit/luci-theme-ifit ./;rm -rf ifit
git clone --depth 1 https://github.com/kenzok78/luci-theme-argone
git clone --depth 1 https://github.com/kenzok78/luci-app-argone-config
git clone --depth 1 https://github.com/kenzok78/luci-app-adguardhome
git clone --depth 1 https://github.com/kenzok78/luci-theme-design
git clone --depth 1 https://github.com/kenzok78/luci-app-design-config
git clone --depth 1 https://github.com/muink/luci-app-homeproxy
git clone --depth 1 https://github.com/muink/luci-app-dnsproxy
git clone --depth 1 -b dev https://github.com/vernesong/OpenClash && mv -n OpenClash/luci-app-openclash ./; rm -rf OpenClash
git clone --depth 1 https://github.com/kenzok8/litte && mv -n litte/luci-theme-atmaterial_new litte/luci-theme-tomato ./ ; rm -rf litte
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall2 passwall2 && mv -n passwall2/luci-app-passwall2 ./;rm -rf passwall2
git clone --depth 1 https://github.com/xiaorouji/openwrt-passwall passwall1 && mv -n passwall1/luci-app-passwall  ./; rm -rf passwall1
git clone --depth 1 https://github.com/sirpdboy/luci-theme-kucat -b js --depth 1
git clone --depth 1 https://github.com/morytyann/OpenWrt-mihomo OpenWrt-mihomo && mv -n OpenWrt-mihomo/*mihomo ./ ; rm -rf OpenWrt-mihomo
git clone --depth 1 https://github.com/muink/openwrt-fchomo openwrt-fchomo && mv -n openwrt-fchomo/*homo ./ ; rm -rf openwrt-fchomo

svn export https://github.com/coolsnowwolf/luci/trunk/libs/luci-lib-ipkg
svn export https://github.com/Ysurac/openmptcprouter-feeds/trunk/luci-app-iperf
svn export https://github.com/QiuSimons/OpenWrt-Add/trunk/luci-app-irqbalance
svn export https://github.com/sirpdboy/sirpdboy-package/trunk/luci-app-control-speedlimit
svn export https://github.com/openwrt/luci/branches/openwrt-22.03/applications/luci-app-wireguard
svn export https://github.com/kenzok8/jell/trunk/vsftpd-alt
svn export https://github.com/kenzok8/jell/trunk/luci-app-bridge

git_sparse_clone master "https://github.com/coolsnowwolf/packages" "leanpack" net/miniupnpd net/mwan3 \
 net/frp net/vlmcsd net/dnsforwarder net/tcpping
mv -f miniupnpd miniupnpd-iptables

git_sparse_clone master "https://github.com/coolsnowwolf/luci" "leanluci" libs/luci-lib-fs

git_sparse_clone openwrt-23.05 "https://github.com/openwrt/packages" "22packages" \
utils/cgroupfs-mount utils/coremark utils/watchcat utils/dockerd net/nginx net/ddns-scripts \
admin/netdata

# update and pin netbird to 0.39.1
# git_sparse_clone master "https://github.com/openwrt/packages" "openwrt_master_packages" net/netbird
# patch -p1 < $GITHUB_WORKSPACE/.github/diy/patches/netbird.diff

git_sparse_clone openwrt-23.05 "https://github.com/openwrt/openwrt" "openwrt" package/libs/openssl

git_sparse_clone master "https://github.com/immortalwrt/packages" "immpack" net/dnsproxy net/cdnspeedtest \
admin/btop libs/wxbase libs/rapidjson libs/libcron libs/quickjspp libs/toml11 \
libs/libdouble-conversion libs/qt6base libs/cxxopts libs/jpcre2

git_sparse_clone master "https://github.com/x-wrt/com.x-wrt" "x-wrt" lua-ipops luci-app-macvlan luci-app-fakemesh

git_sparse_clone openwrt-23.05 "https://github.com/openwrt/luci" "opluci" applications/luci-app-watchcat \

#mv -n openwrt-passwall/* ./ ; rm -Rf openwrt-passwall
rm -rf openssl
mv -n openwrt-package/* ./ ; rm -Rf openwrt-package
sed -i \
-e 's?include \.\./\.\./\(lang\|devel\)?include $(TOPDIR)/feeds/packages/\1?' \
-e 's?2. Clash For OpenWRT?3. Applications?' \
-e 's?\.\./\.\./luci.mk?$(TOPDIR)/feeds/luci/luci.mk?' \
-e 's/ca-certificates/ca-bundle/' \
-e 's/php7/php8/g' \
-e 's/+docker /+docker +dockerd /g' \
*/Makefile

sed -i 's/+dockerd/+dockerd +cgroupfs-mount/' luci-app-docker*/Makefile
sed -i '$i /etc/init.d/dockerd restart &' luci-app-docker*/root/etc/uci-defaults/*
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile
sed -i 's/-beta//g' luci-theme-alpha/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-argon/' luci-app-argon-config/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-design/' luci-app-design-config/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-argone/' luci-app-argone-config/Makefile

patch -p1 < $GITHUB_WORKSPACE/.github/diy/patches/luci-theme-design.patch

find . -type f -name "update.sh" -exec rm -f {} \;
rm -rf adguardhome/patches
exit 0

