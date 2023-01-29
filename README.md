# SwiftUI-open-market

## 🖥️ 프로젝트 소개
e-commerce iOS 앱 프로젝트 입니다.

## 🕰️ 개발 기간

- 2022.12.06 ~ 2023. 01. 26 (51일)

## 🧑🏻‍💻 개발 멤버

|[브래드](https://github.com/bradheo65)|
|:---:|
|<image src = "https://i.imgur.com/35bM0jV.png" width="250" height="250">|
    
## ⚙️ 개발 환경

- `iOS 16.1`
- `API Server: Yagom Academy iOS - OpenMarket API`
- `외부 라이브러리 관리: Cocoa Pod`

## 📌 주요 기능

### HTTP API 통신

- GET
- POST
    - multpart/form-data
- PATCH
- DELETE


## 🚀 TroubleShooting
    
### 🚀 `dismiss()` 시점
    
기존 `Done`버튼 클릭 시 로직 실행 완료 후 화면 전환 되는 것이 아닌, 버튼이 눌린 순간 화면 전환이 되어 초기 화면에서의 List 뷰로 전환 시 어색해지는 현상 발생
    
해결: 버튼 클릭 시 api통신 성공, 실패에 따라 `alert`을 추가하여 로직 분리 처리로 해결 

|`이전 POST 화면 전환`|`개선 POST 화면 전환`|
|:---:|:---:|
|<image src = "https://i.imgur.com/k93HOGq.gif" width="250" height="400">| <image src = "https://i.imgur.com/DgTyvP7.gif" width="250" height="400">

## 📱 동작 화면

|`메인 화면`|`제품 추가 화면`|
|:---:|:---:|
|<image src = "https://i.imgur.com/GIDWDQp.gif" width="250" height="400">| <image src = "https://i.imgur.com/DgTyvP7.gif" width="250" height="400">

|`제품 수정 화면`|`제품 삭제 화면`|
|:---:|:---:|
|<image src = "https://i.imgur.com/BbewsmB.gif" width="250" height="400">| <image src = "https://i.imgur.com/ea2k8I6.gif" width="250" height="400">

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
