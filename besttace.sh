#!/bin/bash
echo_help(){
besttrace=$1
red='\e[31m'
non='\e[0m'
clear
echo -e "执行${red}${besttrace} 域名/ip${non}开始运行
执行${red}${besttrace} -T 域名/ip${non}是测试TCP路由，否则是ICMP路由
例子如下：
北京电信:${red}${besttrace} 113.59.224.1${non}
北京联通:${red}${besttrace} 61.49.137.5${non}
北京移动:${red}${besttrace} 218.205.152.14${non}
上海电信:${red}${besttrace} 101.95.120.109${non}
上海联通:${red}${besttrace} 112.65.35.62${non}
上海移动:${red}${besttrace} 183.192.160.3${non}
广州电信:${red}${besttrace} 14.215.116.1${non}
广州联通:${red}${besttrace} 27.40.0.30${non}
广州移动:${red}${besttrace} 221.183.63.121${non}
成都教育网:${red}${besttrace} 202.112.14.151${non}"
}

dir=/tmp/besttrace4linux
dir2=/bin
[ "$(echo $PATH|grep /usr/local/bin)" ] && dir2=/usr/local/bin

#判断是否安装过了
[ "$(command -v $dir2/besttrace)" ] && besttrace=$dir2/besttrace && [ "$(command -v besttrace)" ] && besttrace=besttrace && [ "$(command -v trace)" ] && besttrace=trace
if [ "$besttrace" ]; then
echo_help "$besttrace"
exit 0 #安装过了就退出脚本
fi
file=$dir/besttrace4linux.zip
file2=$dir/besttrace
loc=$(curl -s http://104.19.19.19/cdn-cgi/trace|grep loc|cut -d '=' -f 2)
echo "Location:$loc"
if [[ -z "$loc" || "$loc" == "CN" ]]; then
url="https://cdn.ipip.net/17mon/besttrace4linux.zip"
else
url="https://raw.githubusercontent.com/haoduck.com/besttrace.sh/main/file/besttrace4linux.zip"
fi
mkdir -p $dir
wget $url -O $file
unzip $file -d $dir
chmod +x $file2
mv $file2 $dir2
ln -s $dir2/besttrace $dir2/trace
rm -rf $dir
[ "$(command -v $dir2/besttrace)" ] && besttrace=$dir2/besttrace && [ "$(command -v besttrace)" ] && besttrace=besttrace && [ "$(command -v trace)" ] && besttrace=trace
if [ "$besttrace" ]; then
echo_help "$besttrace"
else
echo -e "${red}好像安装失败了${non} -_-!"
fi
