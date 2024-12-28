# ------------------------------Heak------------------------------
#!/bin/bash
# 获取当前脚本的目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="$SCRIPT_DIR/log"
LOG_FILE="$LOG_DIR/install_script.log"
LOG_COST="$LOG_DIR/cost.log"

# 确保日志&目录存在，如果不存在则自动生成
mkdir -p "$LOG_DIR"
touch "$LOG_FILE"
touch "$LOG_COST"

# ------------------------------Mo[TWO]ok------------------------------
# Ubuntu&Debian-seew
debianseew() {
    install_dependencies() {
        packages=("jq" "curl" "git" "wget" "sed" "awk" "grep" "nodejs" "npm" "python3-dev" "python3-pip")
        for package in "${packages[@]}"; do
            if ! command -v "$package" &> /dev/null; then
                echo "$package 未安装，正在执行安装脚本..." | tee -a "$LOG_FILE"
                sudo apt-get install -y "$package"
                if [ $? -ne 0 ]; then
                    echo "$package 脚本执行失败" | tee -a "$LOG_FILE"
                    return 1
                fi
            fi
        done
    } || { echo "install_dependencies 失败" | tee -a "$LOG_FILE"; return 1; }
}

# CentOS&RedHat-seew
redhatseew() {
    install_dependencies() {
        packages=("jq" "curl" "git" "wget" "sed" "awk" "grep" "nodejs" "npm" "python3-dev" "python3-pip")
        for package in "${packages[@]}"; do
            if ! command -v "$package" &> /dev/null; then
                echo "$package 未安装，正在执行安装脚本..." | tee -a "$LOG_FILE"
                sudo yum install -y "$package"
                if [ $? -ne 0 ]; then
                    echo "$package 脚本执行失败" | tee -a "$LOG_FILE"
                    return 1
                fi
            fi
        done
    } || { echo "install_dependencies 失败" | tee -a "$LOG_FILE"; return 1; }
}


# Ubuntu&Debian-1Panel
debian-panel() {
    apt-get update
    echo "1Panel未安装，正在执行安装脚本..." | tee -a "$LOG_FILE"
    curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && sudo bash quick_start.sh
    if [ $? -ne 0 ]; then
        echo "1Panel安装脚本执行失败" | tee -a "$LOG_FILE"
        exit 1
    fi
}

# CentOS&RedHat-1Panel
redhat-panel() {
    yum check-update
    echo "1Panel未安装，正在执行安装脚本..." | tee -a "$LOG_FILE"
    curl -sSL https://resource.fit2cloud.com/1panel/package/quick_start.sh -o quick_start.sh && sh quick_start.sh
    if [ $? -ne 0 ]; then
        echo "1Panel安装脚本执行失败" | tee -a "$LOG_FILE"
        exit 1
    fi
}

# Docker加速函数
fastdocker() {
	echo "1Panel已安装，正在执行加速脚本..." | tee -a "$LOG_FILE"
	mkdir -p /etc/docker
	touch daemon.json
	touch daemon.conf
	cp /etc/docker/daemon.json /etc/djson.ini | tee -a "$LOG_FILE"
	cp /etc/docker/daemon.conf /etc/dconf.ini | tee -a "$LOG_FILE"
	tee /etc/docker/daemon.json <<-'EOF'
	{
		"registry-mirrors": [
			"https://docker.1panel.live"
		]
	}
	EOF
	systemctl daemon-reload | tee -a "$LOG_FILE"
	systemctl stop docker.service | tee -a "$LOG_FILE"
	systemctl stop docker.socket | tee -a "$LOG_FILE"
	systemctl start docker.service | tee -a "$LOG_FILE"
	systemctl start docker.socket | tee -a "$LOG_FILE"
	systemctl restart docker | tee -a "$LOG_FILE"
	if [ $? -ne 0 ]; then
		echo "Docker配置脚本执行失败" | tee -a "$LOG_FILE"
		cd /etc/docker/ 
		mv daemon.json daemon.conf -y
		cp /etc/djson.ini /etc/docker/daemon.json | tee -a "$LOG_FILE"
		cp /etc/dconf.ini /etc/docker/daemon.conf | tee -a "$LOG_FILE"
		systemctl stop docker.service | tee -a "$LOG_FILE"
		systemctl stop docker.socket | tee -a "$LOG_FILE"
		systemctl start docker.service | tee -a "$LOG_FILE"
		systemctl start docker.socket | tee -a "$LOG_FILE"
		systemctl restart docker | tee -a "$LOG_FILE"
		return 1
	fi
}

# 1panel三方加载函数
panel3apps() {
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
# ------------------------------Mo[ONE]ok------------------------------
# 定义DebianMook函数
Debianmook() {
	echo "Running Debianmook function" | tee -a "$LOG_FILE"
	if command -v 1panel &> /dev/null; then
		panel3apps
	else
		debianseew
		debian-panel
		fastdocker
		panel3apps
	fi
}

# 定义RedhatMook函数
Redhatmook() {
    echo "Running Redhatmook function" | tee -a "$LOG_FILE"
	if command -v 1panel &> /dev/null; then
		panel3apps
	else
		redhatseew
		redhat-panel
		fastdocker
		panel3apps
	fi
}
# ------------------------------ReskONE------------------------------
ReskONE() {
    while true; do
        if [ -f "$LOG_COST" ] && [ -s "$LOG_COST" ]; then
            OS_TYPE=$(cat "$LOG_COST")
            case $OS_TYPE in
                T)
                    Debianmook
                    break
                    ;;
                F)
                    Redhatmook
                    break
                    ;;
                *)
                    echo "Invalid log value: $OS_TYPE"
                    # 删除无效的日志文件以重新检测系统类型
                    rm "$LOG_COST"
                    ;;
            esac
        else
            # 判断系统类型并运行相应的函数
            if [ -f /etc/os-release ]; then
                . /etc/os-release
                OS=$ID
            else
                echo "Cannot determine OS type"
                exit 1
            fi

            log_and_run() {
                local log_value=$1
                local function_name=$2

                echo "$log_value" > "$LOG_COST"
                $function_name
            }

            case $OS in
                ubuntu|debian)
                    log_and_run "T"
                    ;;
                centos|redhat)
                    log_and_run "F"
                    ;;
                *)
                    echo "Unsupported OS: $OS"
                    echo "Please select the OS type:"
                    echo "Debian series (T) or RedHat series (F)"
                    while true; do
                        read -p "Enter your choice (T/F): " CHOICE
                        
                        case $CHOICE in
                            T)
                                log_and_run "T"
                                break
                                ;;
                            F)
                                log_and_run "F"
                                break
                                ;;
                            *)
                                echo "Invalid choice, please enter T or F."
                                ;;
                        esac
                    done
                    ;;
            esac
        fi
    done
}
# ------------------------------THEEND------------------------------
# 初始MOOK
ReskONE
