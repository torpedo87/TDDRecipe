# 프로젝트 목표
- Test Driven iOS Development with Swift3 실습예제인 ToDo를 따라해보면서 TDD 학습


# 적용할 기술
- TDD
- MVC
- auto layout


# architecture

## Model
- ToDoItem
- Location
- ItemManager

## View
- ToDoItemCell

## Controller
- ListVC
- TaskDetailVC
- TaskInputVC

## Helper
- DataProvider


# tdd 적용 순서

## ToDoItem
- title이 주어졌을 때 값 확인
- description이 주어졌을 때 값 확인
- timestamp 가 주어졋을때 값 확인
- Location 이 주어졋을때 값 확인
- equatable 적용
- plistDict

## Location
- name 이 주어졋을때 값 확인
- coordinate 가 주어졌을 때 확인
- equatable 적용
- serialize

## ItemManager
- toDoCount
- doneCount
- func add
- func itemAt
- toDoItems
- func checkItemAt
- func uncheckitemat
- func doneItemAt
- doneItems
- Equatable (ToDoItem)
- func removeAll

## ItemListViewController
- tableView
- datasource
- delegate
- add button
- itemManager
- tableview reloaddata
- notification receiver

## ItemListDataProvider
- numberofsections = 2
- numberofrowsinfirstsection = itemmanager.todocount
- numberofrowsinsecondsection = itemmanager.donecount
- cellforrowat return custom cell
- itemcell dequeue
- itemcell configcell
- deletebutton
- check, uncheck event
- notification sender

## ItemCell
- titleLabel
- locationLabel
- datelabel
- configcell for unchecked item
- configcell for checked item

## DetailViewController
- titlelabel
- locationlabel
- datelabel
- descriptionlabel
- mapview
- label.text
- mapview.region
- func check

## InputViewController
- titletextfield
- datetextfield
- locationtextfield
- addresstextfield
- descriptiontextfield
- savebutton
- cancelbutton
- geocoder
- savebutton과 func save 연결
- 비동기 geocoder
- func save

## APIClient
- url
- token
- jsondata error 처리
- dataempty error 처리
- severside error 처리





