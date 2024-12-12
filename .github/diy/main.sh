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
git clone --depth 1 -b openwrt-18.06 https://github.com/tty228/luci-app-wechatpush
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
git clone --depth 1 https://github.com/linkease/istore && mv -n istore/luci/* ./; rm -rf istore
git clone --depth 1 https://github.com/muink/luci-app-homeproxy
git clone --depth 1 https://github.com/muink/luci-app-dnsproxy
git clone --depth 1 https://github.com/vernesong/OpenClash && mv -n OpenClash/luci-app-openclash ./; rm -rf OpenClash
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
utils/cgroupfs-mount utils/coremark utils/watchcat utils/dockerd net/nginx net/uwsgi net/ddns-scripts \
net/netbird admin/netdata

git_sparse_clone openwrt-23.05 "https://github.com/openwrt/openwrt" "openwrt" \
package/base-files package/network/config/firewall4 package/network/config/firewall package/system/opkg package/network/services/ppp \
package/network/services/dnsmasq package/libs/openssl

git_sparse_clone master "https://github.com/immortalwrt/packages" "immpack" net/sub-web net/dnsproxy net/haproxy net/cdnspeedtest \
net/uugamebooster net/subconverter net/ngrokc net/oscam net/njitclient net/scutclient net/gowebdav net/udp2raw \
admin/btop libs/wxbase libs/rapidjson libs/libcron libs/quickjspp libs/toml11 libs/libtorrent-rasterbar \
libs/libdouble-conversion libs/qt6base libs/cxxopts libs/jpcre2 libs/alac \
utils/cpulimit devel/gn

git_sparse_clone develop "https://github.com/Ysurac/openmptcprouter-feeds" "enmptcp" luci-app-snmpd \
luci-app-packet-capture luci-app-mail msmtp

git_sparse_clone master "https://github.com/x-wrt/com.x-wrt" "x-wrt" natflow lua-ipops luci-app-macvlan luci-app-3ginfo-lite luci-app-fakemesh

git_sparse_clone master "https://github.com/immortalwrt/immortalwrt" "immortal" package/network/utils/nftables \
package/network/utils/fullconenat package/network/utils/fullconenat-nft \
package/utils/mhz package/libs/libnftnl package/firmware/wireless-regdb

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

sed -i 's/PKG_VERSION:=20240302/PKG_VERSION:=20240223/g; s/PKG_RELEASE:=$(AUTORELESE)/PKG_RELEASE:=1/g' webd/Makefile
sed -i 's/+dockerd/+dockerd +cgroupfs-mount/' luci-app-docker*/Makefile
sed -i '$i /etc/init.d/dockerd restart &' luci-app-docker*/root/etc/uci-defaults/*
sed -i 's/+libcap /+libcap +libcap-bin /' luci-app-openclash/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-argon/' luci-app-argon-config/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-design/' luci-app-design-config/Makefile
sed -i 's/\(+luci-compat\)/\1 +luci-theme-argone/' luci-app-argone-config/Makefile

find . -type f -name "update.sh" -exec rm -f {} \;
rm -rf adguardhome/patches
exit 0

