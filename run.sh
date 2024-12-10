which_install_soft() {
    answer=-1
    WHICH_CMD=$(which apt)
    if [[ ! -z $WHICH_CMD ]]; then
    	answer=0
    fi
    WHICH_CMD=$(which dnf)
    if [[ ! -z $WHICH_CMD ]]; then
    	answer=1
    fi
    WHICH_CMD=$(which pacman)
    if [[ ! -z $WHICH_CMD ]]; then
    	answer=2
    fi
    WHICH_CMD=$(which apk)
    if [[ ! -z $WHICH_CMD ]]; then
    	answer=3
    fi
}

install_pck() {
    status="$(dpkg-query -W --showformat='${db:Status-Status}' "$pkg" 2>&1)"
    if [ ! $? = 0 ] || [ ! "$status" = installed ]; then
        which_install_soft
        echo $answer
        case $answer in
            0)
                sudo apt install $pkg
                ;;
            1)
                sudo dnf install $pkg
                ;;
            2)
                sudo pacman -S --noconfirm $pkg
                ;;
            3)
                apk add $pkg
                ;;
        esac
    fi
}

clean_up() {
    rm *.perf*
    rm *.version
    rm main
    rm maincustom
    rm main.go.run
    rm -rf ./target/
    rm MainJava.class
    rm usage.txt
    rm *.png
    rm -rf ./dotnet
    rm -rf ./go
    rm -rf ./bin/
    rm -rf ./obj/
}

install_languages() {
    pkg=python3
    install_pck
    pkg=sudo
    install_pck
    pkg=wget
    install_pck
    pkg=pypy
    install_pck
    pkg=g++
    install_pck
    pkg=jdk-openjdk
    install_pck
    pkg=curl
    install_pck
    pkg=julia
    install_pck
    pkg=nodejs
    install_pck
    pkg=py3-prettytable
    install_pck
    pkg=py3-psutil
    install_pck
    pkg=py3-matplotlib
    install_pck
    pkg=py3-pandas
    install_pck
    pkg=py3-distro
    install_pck

    pip install -r requirements.txt

    # https://go.dev/dl/
    if [ ! -f ./go1.23.4.linux-amd64.tar.gz ]; then
        wget https://go.dev/dl/go1.23.4.linux-amd64.tar.gz
    fi
    rm -rf ./go
    tar -C ./ -xzf go1.23.4.linux-amd64.tar.gz


    # https://dotnet.microsoft.com/en-us/download/dotnet
    which_install_soft
    case $answer in
        2)
            if [ ! -f ./dotnet-sdk-9.0.101-linux-x64.tar.gz ]; then
                wget https://download.visualstudio.microsoft.com/download/pr/d74fd2dd-3384-4952-924b-f5d492326e35/e91d8295d4cbe82ba3501e411d78c9b8/dotnet-sdk-9.0.101-linux-x64.tar.gz
            fi
            mkdir ./dotnet
            tar zxf dotnet-sdk-9.0.101-linux-x64.tar.gz -C ./dotnet
            ;;
        3)
            if [ ! -f ./dotnet-sdk-9.0.101-linux-musl-x64.tar.gz ]; then
                wget https://download.visualstudio.microsoft.com/download/pr/73c11b94-0188-458f-b599-f7591718fc28/c44e21ffbf353b50ef88a76122e89e24/dotnet-sdk-9.0.101-linux-musl-x64.tar.gz
            fi
            mkdir ./dotnet
            tar zxf dotnet-sdk-9.0.101-linux-musl-x64.tar.gz -C ./dotnet
            ;;
    esac

    export DOTNET_ROOT=./dotnet
    export PATH=$PATH:./dotnet

    # https://www.rust-lang.org/tools/install
    curl --proto '=https' --tlsv1.2 -sSf -y https://sh.rustup.rs >> rustup.sh
    sudo chmod +x rustup.sh
    rustup.sh -y
}

compile_source() {
    g++ main.c++ -o main -Ofast
    g++ maincustom.c++ -o maincustom -Ofast
    ./go/bin/go build -o main.go.run main.go
    $HOME/.cargo/bin/cargo build --release
    javac MainJava.java
    dotnet build --property:Configuration=Release
}

get_language_versions() {
    echo "(0,0)" >> custom\ c++.version
    g++ --version >> c++.version
    pypy --version >> pypy.version 2>&1
    ./go/bin/go version >> go.version
    $HOME/.cargo/bin/rustc --version >> rust.version
    perl --version >> perl.version
    java --version >> java.version
    dotnet --version >> c#.version
    julia --version >> julia.version
    node --version >> javascript.version
    python3 --version >> python3.version
}

clean_up

#exit 1

install_languages
compile_source
get_language_versions

python3 cpuusage.py &
PID=$!

for i in $(seq 5)
do
    echo 'Round' $i
    sleep 1
    ./main >> c++.perf$i
    sleep 1
    ./maincustom >> custom\ c++.perf$i
    sleep 1
    pypy main.py >> pypy.perf$i
    sleep 1
    ./main.go.run >> go.perf$i
    sleep 1
    ./target/release/dictionary_test >> rust.perf$i
    sleep 1
    perl main.perl >> perl.perf$i
    sleep 1
    java MainJava >> java.perf$i
    sleep 1
    ./bin/Release/net9.0/main >> c#.perf$i
    sleep 1
    julia main.julia >> julia.perf$i
    sleep 1
    node main.js >> javascript.perf$i
    sleep 1
    python3 main.py >> python3.perf$i
done

sleep 1
kill -9 $PID

python3 compare.py



