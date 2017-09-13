# 적용할 기술
- TDD
- MVC
- auto layoutt

# 구현할 기능
- IFTTT의 CardView
- Inbox 의 매직버튼
- userDefault 에 저장
- app extension을 적용하여 사이트주소 저장

# CardListView
- Item를 탭하면 해당 사이트 주소로 이동
- Item에는 title과  생성날짜 표시
- Item 왼쪽 스와이프시 delete 버튼
- 오른쪽 하단 매직버튼 탭시 searchView로 이동하는 버튼 생성되고 기존의 매직버튼은 생성버튼으로 UI 변경돠어 탭하면 InputView로 이동

# InputView
- 사이트 주소 입력
- 태그 달기

# SearchView
- 태그 키워드로 Item 검색

# TDD 적용중
## model
### Item
- card 가 url, title, timestamp 를 갖는지
- url과 title, timestamp의 값이 존재하는지
- item을 바로 비교할 수 있도록 equatable 적용

### ItemManager
- 초기 count 가 0
- add 시에 count 1 증가
- add 시에 추가된 card 확인
- check 시 count 1 감소
- check 시 해당 item 사라짐

