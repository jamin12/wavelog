# 파이썬 버전
FROM myserverbase

RUN apt-get -y update && apt-get install -y libzbar-dev
# 이미지 내에서 명령어를 실행할(현 위치로 잡을) 디렉토리 설정
WORKDIR /usr/src/server/app

# 이미지 만들떄 다운 받을것들
RUN pip install -r requirements.txt


CMD [ "uvicorn","main:app","--host","0.0.0.0","--port","8080"]


# 이미지 생성 명령어 (현 파일과 같은 디렉토리에서)
# docker build -t {이미지 명} .

# 컨테이너 생성 & 실행 명령어
# docker run --name {컨테이너 명} -v ${pwd}:/usr/src/app -p 8080:8080 {이미지명} 