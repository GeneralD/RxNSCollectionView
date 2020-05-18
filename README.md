# RxNSCollectionView

## What's this

RxSwift + NSCollectionView

Why RxCocoa doesn't support NSCollectionView like UICollectionView? It's very inconvenient for me! You too right? Then I developed it from copy of some guy's codes.

## Usage

```swift
// Your subclass of NSViewController with NSCollectionView

let itemType = CollectionViewItem.self
collectionView.register(itemType: itemType)

output.items
	.bind(to: collectionView.rx.items(itemType))
	.disposed(by: disposeBag)
```

```swift
// Your subclass of NSCollectionViewItem

extension CollectionViewItem: NibLoadable, Reusable {}

extension CollectionViewItem: Configurable {

	func configure(with model: ItemModel) {
		let input: Input = model
		let output: Output = model

		disposeBag = DisposeBag()

		downloadButton.rx.tap
			.bind(to: input.downloadClick)
			.disposed(by: disposeBag)

		output.name
			.bind(to: nameLabel.rx.text)
			.disposed(by: disposeBag)

		output.version
			.bind(to: versionLabel.rx.text)
			.disposed(by: disposeBag)
	}
}
```

## Installation

```
pod 'RxNSCollectionView'
```

