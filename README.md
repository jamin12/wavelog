# blog

Tae-Woong
Kyoung-Min

blog project initialized
2021-05-12

# Commit Record

[![commitcombo](http://commitcombo.com/get?user=Kmeoung&theme=Sunset-mini)](https://github.com/devxb/CommitCombo)

# 이전 작업에 대한 내용

지금 뭘 하고 있는지 잘 모르겠다
아무래도 Web에 대한 기초적인 강의를 정독하고
그 후 provider에 대한 기초적인 강의 듣고
다시 작업을 진행해야 맞는 것 같다
https://www.youtube.com/watch?v=rhq5yImWdBw&list=PLIKnSA4GMR4O9uTZvKLq9UWx3I8biurBr&index=9
여기 링크를 남긴다

# VIEW 해야할 일

<ol>
    <li>Splash Screen에서 사용자 클릭 시 선택되지 않은 사용자 사라지는 애니메이션 처리</li>
    <li>로그인 기능 생성
        <ul>
            <li>로그인 커스텀 팝업 디자인 및 구현</li>
            <li>로그인 버튼 Drawer에 구현</li>
        </ul>
    </li>
    <li>카테고리 추가 / 수정 페이지 구현</li>
    <li>게시글 추가 / 수정 페이지 구현</li>
    <li>게시글 페이지 구현</li>
    <li>서버 연동</li>
    <li>Performance 개선</li>
    <li>일단 전부 완성 후 웹에 맞게 대규모 코드 리뉴얼 진행</li>
    <li>코드 리뉴얼 단계에서 Provider or GetX 적용</li>
</ol>

# VIEW 문제 사항

<ol>
    <li>모바일 사이즈 화면 사이즈에서는 SVG에 색상이 들어가지 않음</li>
    <li>Web 및 Android의 기본 탑재된 뒤로가기 시 View 가 제대로 작동하지 않으며 작동한다 하더라도 다음번 부터는 뒤로가기 기능이 손실됨</li>
</ol>

# VIEW 수정 완료 사항

<ol>
    <li>
        <del>WEB 전체화면 모드에서 SEA -> BEACH 로 전환 시 배경이 깨지는 문제 발생 (Release 모드에서만 발생) (애니메이션 최적화 후 사라진듯 함)</del>
    </li>
    <li>
        <del>가장 작은 정 사각형 화면에서 BEACH -> SEA 로 전환 시 SEA 전환 애니메이션이 제대로 작동하지 않음</del>
    </li>
    <li>
        <del>WEB 화면 사이즈 변경 시 애니메이션 고장나는 오류</del>
    </li>
    <li>
        <del>화면 전환 버튼을 연속해서 누르게 되면 애니메이션 전환이 매끄럽지 않음<del>
    </li>
    <li>
        <del>애니메이션 작동 시 최적화가 필요함 (해결방법 : AnimatedBuilder를 써서 필요한 부분만 rebuild 시킴)</del>
    </li>
</ol>
