#!/bin/bash
echo "请先检查镜像是否放入光驱！！"
sleep 1
read -p "请输入所要创建的主机名：" h
rm -rf /etc/yum.repos.d/*
echo "[$h]
name=$h
baseurl=file:///mnt/$h
enabled=1
gpgcheck=0" >> /etc/yum.repos.d/$h.repo
yum clean all &> /dev/null
if [ $? -gt 0 ];then
        echo "yum配置失败，请检查！"
        exit 1
else
        echo "yum配置成功"
fi
`hostnamectl set-hostname $h`
mkdir /mnt/$h &> /dev/null
echo "/dev/cdrom /mnt/$h  iso9660 defaults 0 0" >> /etc/fstab
mount -a  &> /dev/null
if [ $? -gt 0 ];then
        echo "挂载失败，请检查!" 
        exit 2
else
        echo "挂载成功"
fi
yum repolist | tail -3
echo "配置完成"
