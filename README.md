# 오픈마켓 

## 🙋🏻‍♂️ 프로젝트 소개
이커머스 오픈마켓 앱 프로젝트 입니다.

> 프로젝트 기간: 2022-12-06 ~~ </br>
> 팀원:  [브래드](https://github.com/bradheo65) </br>

## 📑 목차

- [🧑🏻‍💻🧑🏻‍💻 개발자 소개](#-개발자-소개)
- [📑 파일 구조](#-파일-구조)
- [📱 동작 화면](#-동작-화면)
- [💡 키워드](#-키워드)
- [🤔 핵심경험](#-핵심경험)
- [📚 참고문서](#-참고문서)
- [🚀 TroubleShooting](#-TroubleShooting)
- [⚙️ 업데이트](#-업데이트)

## 🧑🏻‍💻🧑🏻‍💻 개발자 소개

||
|:---:|
|<image src = "https://user-images.githubusercontent.com/45350356/174251611-46adf61c-93fa-42a0-815b-2c998af1c258.png" width="250" height="250">|
|[브래드](https://github.com/bradheo65)|  
    
## 📑 파일 구조    

```
├── Common
│   └── Cancellable.swift
├── Data
│   ├── DTOs
│   │   ├── DetailProductDTO.swift
│   │   └── ProductListResponseDTO.swift
│   ├── Repositories
│   │   ├── MarketProductDeleteRepository.swift
│   │   ├── MarketProductDetailRepository.swift
│   │   ├── MarketProductListRepository.swift
│   │   ├── MarketProductPatchRepository.swift
│   │   └── MarketProductPostRepository.swift
│   └── Services
│       ├── NetworkService.swift
│       └── Utills
│           └── Enum
│               ├── OpenMarketAPI.swift
│               └── VendorInfo.swift
├── Domain
│   ├── Entities
│   │   ├── DetailProduct
│   │   │   ├── DetailImage.swift
│   │   │   ├── DetailProduct.swift
│   │   │   └── Vendors.swift
│   │   └── Product
│   │       ├── PatchProductInfo.swift
│   │       ├── Product.swift
│   │       ├── ProductInfo.swift
│   │       └── ProductListResponse.swift
│   ├── RepositoryInterface
│   │   ├── MarketProductDeleteRepositoryInterface.swift
│   │   ├── MarketProductDetailRepositoryInterface.swift
│   │   ├── MarketProductListRepositoryInterface.swift
│   │   ├── MarketProductPatchRepositoryInterface.swift
│   │   └── MarketProductPostRepositoryInterface.swift
│   └── UseCases
│       └── Open-market
│           ├── DeleteProductUseCase.swift
│           ├── FetchMarketListUseCase.swift
│           ├── FetchProductDetailUseCase.swift
│           ├── PatchMarketProductUseCase.swift
│           └── PostMarketProductUseCase.swift
├── Presentation
│   ├── OpenMarket
│   │   ├── Create
│   │   │   ├── View
│   │   │   │   └── ProductAddView.swift
│   │   │   └── ViewModel
│   │   │       └── ProductAddViewModel.swift
│   │   ├── Detail
│   │   │   ├── View
│   │   │   │   └── ProductDetailView.swift
│   │   │   └── ViewModel
│   │   │       └── ProductDetailViewModel.swift
│   │   └── List
│   │       ├── View
│   │       │   ├── ProductListCellView.swift
│   │       │   └── ProductListView.swift
│   │       └── ViewModel
│   │           ├── ProductListCellViewModel.swift
│   │           └── ProductListViewModel.swift
│   └── Utills
│       ├── CacheAsyncImage.swift
│       ├── Enum
│       │   └── Currency.swift
│       ├── Extensions
│       │   ├── Extension+Double.swift
│       │   ├── Extension+String.swift
│       │   └── Extension+View.swift
│       └── ImagePicker.swift
├── Preview Content
│   └── Preview Assets.xcassets
│       ├── Contents 2.json
│       └── Contents.json
└── Resources
    ├── Assets.xcassets
    │   ├── AccentColor.colorset
    │   │   └── Contents.json
    │   ├── AppIcon.appiconset
    │   │   └── Contents.json
    │   ├── Contents.json
    │   └── Image.imageset
    │       ├── Contents.json
    │       └── TestImage.png
    └── SwiftUI_open_marketApp.swift
```

## 📱 동작 화면

### 형태별 동작 화면
|GET|POST|
|:---:|:---:|
|<image src = "https://i.imgur.com/GIDWDQp.gif" width="250" height="500">| <image src = "https://i.imgur.com/DgTyvP7.gif" width="250" height="500">

|PATCH|Delete|
|:---:|:---:|
|<image src = "https://i.imgur.com/BbewsmB.gif" width="250" height="500">| <image src = "https://i.imgur.com/ea2k8I6.gif" width="250" height="500">

## 💡 키워드
- SwiftUI
- MVVM
- List
- HTTP
- Alamofire
- UIImagePicker
- ResizeImage
- Alert
    
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

## 🚀 TroubleShooting
    
### 🚀 `dismiss()` 시점
    
고민: 기존에는 'Done'버튼이 눌린 후 로직이 처리된 후 `dismiss()`가 실행되는 것이 아닌 바로 버튼이 눌린 순간 `dissmiss()`를 실행하기 때문에 화면 이동이 부자연스러웠습니다.
    
해결: "ViewModel에서 Api통신 시 작업 완료 되었을 때 Bool타입을 통해 관리하면 되겠다"라는 생각을 하게 되었고, `@Published` 프로퍼티 와퍼로 이용해 뷰모델의 프로퍼티 바인딩과 `alert`을 활용해 해결해주었습니다. 

|이전 POST dismiss|신규 POST dismiss|
|:---:|:---:|
|<image src = "https://i.imgur.com/k93HOGq.gif" width="300" height="400">| <image src = "https://i.imgur.com/DgTyvP7.gif" width="300" height="400">
    
## ⚙️ 업데이트
    
- '2022. 12. 08' - 가격, 할인금액, 재고수량 숫자만 입력 가능하게 끔 로직 추가 및 키보드 타입 변경
    
- '2022. 12. 10' - image Cache 구현
