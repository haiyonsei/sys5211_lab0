#!/bin/bash

# --- 스크립트 기본 설정 ---
# 오류 발생 시 즉시 중단
set -e

# 터미널 출력을 위한 색상 설정
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# --- 시작 ---
echo -e "${GREEN}=================================================${NC}"
echo -e "${GREEN}Chisel Bootcamp 자동 설치 스크립트 (for macOS)를 시작합니다.${NC}"
echo -e "${GREEN}=================================================${NC}"

# =================================================
# Step 1: Homebrew 및 필수 프로그램 설치
# =================================================

# --- 1.1. Homebrew 설치 확인 및 설치 ---
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}Homebrew가 설치되어 있지 않습니다. 지금 설치합니다...${NC}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Apple Silicon Mac의 경우 PATH 설정
    if [ -d "/opt/homebrew/bin" ]; then
        echo -e "${CYAN}[INFO] Apple Silicon Mac을 위해 Homebrew 경로를 설정합니다.${NC}"
        export PATH="/opt/homebrew/bin:$PATH"
    fi
else
    echo -e "${CYAN}[INFO] Homebrew가 이미 설치되어 있습니다.${NC}"
fi

# --- 1.2. 필수 프로그램 설치 (JDK 8, Python, Git) ---
echo -e "${YELLOW}[1.2] Homebrew를 사용해 필수 프로그램을 설치합니다 (JDK 8, Python, Git)...${NC}"
# === 수정된 부분 ===
# Homebrew의 공식 패키지 이름인 'temurin@8'로 변경
brew install --cask temurin@8
brew install python git
echo -e "${GREEN}[SUCCESS] 필수 프로그램 설치 완료.${NC}"

# =================================================
# Step 2: Jupyter 및 Scala 커널 설치
# =================================================

# --- 2.1. Jupyter 설치 ---
echo -e "\n${YELLOW}[2.1] pip3를 사용해 Jupyter 및 JupyterLab을 설치합니다...${NC}"
pip3 install --upgrade pip
pip3 install jupyter jupyterlab
echo -e "${GREEN}[SUCCESS] Jupyter 설치 완료.${NC}"

# --- 2.2. Scala 커널 (Almond) 설치 ---
echo -e "\n${YELLOW}[2.2] Coursier를 다운로드하여 Almond 커널을 설치합니다...${NC}"

# 이전 작업 찌꺼기 파일 삭제
rm -f coursier almond

# Coursier 다운로드 및 실행 권한 부여
curl -fLo coursier https://git.io/coursier-cli
chmod +x coursier

# Almond 부트스트랩 (실행 파일 생성)
echo -e "${CYAN}[INFO] Almond 커널 부트스트랩 중...${NC}"
SCALA_VERSION=2.12.15
ALMOND_VERSION=0.13.1
./coursier bootstrap \
    -r jitpack \
    -i user -I user:sh.almond:scala-kernel-api_$SCALA_VERSION:$ALMOND_VERSION \
    sh.almond:scala-kernel_$SCALA_VERSION:$ALMOND_VERSION \
    --sources --default=true \
    -o almond

# Almond 커널을 Jupyter에 설치 (Chisel predef-code 포함)
echo -e "${CYAN}[INFO] Chisel 라이브러리와 함께 Almond 커널을 Jupyter에 설치합니다...${NC}"
./almond --install --force --predef-code '
import $ivy.`edu.berkeley.cs::chisel3:3.5.3`
import $ivy.`edu.berkeley.cs::chiseltest:0.5.3`
import chisel3._
'
echo -e "${GREEN}[SUCCESS] Scala (Almond) 커널 설치 완료.${NC}"

# 임시 파일 정리
rm -f coursier almond

# =================================================
# Step 3: 랩 환경 설정
# =================================================
echo -e "\n${YELLOW}[3.1] Git 리포지토리를 클론합니다...${NC}"

# 기존 폴더가 있다면 삭제하여 깨끗한 상태로 시작
if [ -d "sys5211_lab0" ]; then
    echo -e "${CYAN}[INFO] 기존 'sys5211_lab0' 폴더를 삭제합니다.${NC}"
    rm -rf "sys5211_lab0"
fi
git clone https://github.com/haiyonsei/sys5211_lab0
echo -e "${GREEN}[SUCCESS] 리포지토리 클론 완료.${NC}"

# =================================================
# Step 4: 완료 및 다음 단계 안내
# =================================================
echo -e "\n${GREEN}=================================================${NC}"
echo -e "${GREEN}🎉 모든 설치 및 설정이 성공적으로 완료되었습니다!${NC}"
echo -e "${GREEN}=================================================${NC}"
echo -e "이제 다음 명령어를 터미널에 순서대로 입력하여 Jupyter Notebook을 실행하세요."
echo -e "\n1. 새로 생성된 랩 폴더로 이동:"
echo -e "${CYAN}   cd sys5211_lab0${NC}"
echo -e "\n2. Jupyter Notebook 서버 실행:"
echo -e "${CYAN}   jupyter notebook${NC}"
echo -e "\n위 명령어를 실행하면 웹 브라우저가 자동으로 열립니다."
echo -e "================================================="
