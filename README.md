# EZCarouselCollectionViewLayout
EZCarouselCollectionViewLayout is a layout for easy carousel effect implementation.
The purpose is to make it easy to implement natural carousel effect like app store.


## Installation

**Using [CocoaPods](https://cocoapods.org)**:

```bash
pod 'EZCarouselCollectionViewLayout'
```


## Usage

### Code

```swift
import EZCarouselCollectionViewLayout
```

Create a collectionViewLayout object and assign it to the collectionView.

```swift       
let layout = EZCarouselCollectionViewLayout()
layout.delegate = self
layout.itemSize = CGSize(width: 300, height: 500)
collectionView.collectionViewLayout = layout
```

You can create a layout that you want to implement by setting the properties you want.

```swift
layout.minimumLineSpacing = 10
collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
```


## License

**EZCarouselCollectionViewLayout** is under MIT license. 
See the [LICENSE](LICENSE) file for more info.

