#!/bin/bash

# 获取当前脚本的目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/log"
LOG_FILE="$LOG_DIR/install_script.log"

# 确保日志&目录存在，如果不存在则自动生成
mkdir -p "$LOG_DIR"
touch "$LOG_FILE"

# 定义命令1的函数
run_command1() {
    os_type=$(uname)
    install_dependencies() {
        case "$os_type" in
            Linux)
                command -v apt-get &> /dev/null || { echo "install_dependencies 失败: apt-get 不存在" | tee -a "$LOG_FILE"; return 1; }
                packages=("jq" "curl" "git" "wget" "sed" "awk" "grep")
                for package in "${packages[@]}"; do
                    if ! dpkg -l | grep -q "$package"; then
                        echo "$package 未安装，正在执行安装脚本..." | tee -a "$LOG_FILE"
                        sudo apt-get update && sudo apt-get install -y "$package"
                        if [ $? -ne 0 ]; then
                            echo "$package 脚本执行失败" | tee -a "$LOG_FILE"
                            return 1
                        fi
                    fi
                done
                ;;
            *)
                echo "不支持的操作系统: $os_type" | tee -a "$LOG_FILE"
                return 1
                ;;
        esac
    } || { echo "install_dependencies 失败" | tee -a "$LOG_FILE"; return 1; }
}

# 定义命令2的函数
run_command2() {
    apt-get update
    echo "1Panel未安装，正在执行安装脚本..." | tee -a "$LOG_FILE"
    curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && sudo bash quick_start.sh
    if [ $? -ne 0 ]; then
        echo "1Panel安装脚本执行失败" | tee -a "$LOG_FILE"
        exit 1
    fi
}

# 定义命令3的函数
run_command3() {
	echo "DOCKER已安装，正在执行加速脚本..." | tee -a "$LOG_FILE"
	sudo mkdir -p /etc/docker
	sudo tee /etc/docker/daemon.json <<-'EOF'
	{
		"registry-mirrors": [
			"https://docker.1panel.live"
		]
	}
	EOF
	sudo systemctl daemon-reload && sudo systemctl restart docker
	if [ $? -ne 0 ]; then
		echo "Docker配置脚本执行失败" | tee -a "$LOG_FILE"
		cd /etc/docker/
		mv daemon.json daemon.conf
		systemctl restart docker
		return 1
	fi
}

# 定义命令4的函数
run_command4() {
    echo "1Panel已安装，正在执行更新脚本..." | tee -a "$LOG_FILE"
    git clone -b localApps https://github.com/okxlin/appstore /opt/1panel/resource/apps/local/appstore-localApps
    if [ $? -ne 0 ]; then
        echo "Panel3Git克隆文件失败" | tee -a "$LOG_FILE"
        exit 1
    fi
    cp -rf /opt/1panel/resource/apps/local/appstore-localApps/apps/* /opt/1panel/resource/apps/local/
    if [ $? -ne 0 ]; then
        echo "Panel3Git复制文件失败" | tee -a "$LOG_FILE"
        exit 1
    fi
    rm -r /opt/1panel/resource/apps/local/appstore-localApps
    if [ $? -ne 0 ]; then
        echo "Panel3Git删除缓存失败" | tee -a "$LOG_FILE"
        exit 1
    fi
}

# 检查是否安装了1panel
if command -v 1panel &> /dev/null; then
    run_command4
else
    run_command1
    run_command2
    run_command3
    run_command4
fi