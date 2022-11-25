# 오픈마켓 

## 🙋🏻‍♂️ 프로젝트 소개
이커머스 오픈마켓 앱 프로젝트 입니다.

> 프로젝트 기간: 2022-11-18 ~ 2022-11-25</br>
> 팀원:  [브래드](https://github.com/bradheo65) </br>

## 📑 목차

- [🧑🏻‍💻🧑🏻‍💻 개발자 소개](#-개발자-소개)
- [📑 파일 구조](#-파일-구조)
- [📱 동작 화면](#-동작-화면)
- [💡 키워드](#-키워드)
- [🤔 핵심경험](#-핵심경험)
- [📚 참고문서](#-참고문서)


## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

||
|:---:|
|<image src = "https://user-images.githubusercontent.com/45350356/174251611-46adf61c-93fa-42a0-815b-2c998af1c258.png" width="250" height="250">|
|[브래드](https://github.com/bradheo65)|  
    
## 📑 파일 구조    

```
.
├── Assets.xcassets
│   ├── AccentColor.colorset
│   │   └── Contents.json
│   ├── AppIcon.appiconset
│   │   └── Contents.json
│   ├── Contents.json
│   └── Image.imageset
│       ├── Contents.json
│       └── TestImage.png
├── Enum
│   └── VendorInfo.swift
├── Extension
│   └── Extension+UIImage.swift
├── Model
│   ├── DetailProduct.swift
│   ├── Product.swift
│   ├── ProductAPI.swift
│   └── ProductListResponse.swift
├── Preview Content
│   └── Preview Assets.xcassets
│       └── Contents.json
├── SwiftUI_open_marketApp.swift
├── View
│   ├── ImagePicker.swift
│   ├── ProductAddView.swift
│   ├── ProductDetailView.swift
│   └── ProductListView.swift
└── ViewModel
    ├── ProductAddViewModel.swift
    ├── ProductDetailViewModel.swift
    └── ProductListViewModel.swift
```
    
## 📱 동작 화면

### 형태별 동작 화면
|GET|POST|
|:---:|:---:|
|<image src = "https://i.imgur.com/W0yCrKm.gif" width="250" height="500">| <image src = "https://i.imgur.com/ul5krtQ.gif" width="250" height="500">
    
|PATCH|POST|
|:---:|:---:|
|<image src = "https://i.imgur.com/1LTLY4P.gif" width="250" height="500">| <image src = "https://i.imgur.com/SBvAJeh.gif" width="250" height="500">


## 💡 키워드
- SwiftUI
- MVVM
- List
- HTTP
- Alamofire
- UIImagePicker
- ResizeImage
    
## 🤔 핵심경험
- [x] 파싱한 JSON 데이터와 매핑할 모델 설계
- [x] Alamofire을 활용한 서버와의 통신
- [x] CodingKeys 프로토콜의 활용
- [x] multipart/form-data의 구조 파악
- [x] Alamofire을 활용한 multipart/form-data 요청 전송
- [x] 사용자 친화적인 UI/UX 구현 (적절한 입력 컴포넌트 사용, 알맞은 키보드 타입 지정)


## 📚 참고문서
- API
    - Yagom Academy iOS - OpenMarket API

