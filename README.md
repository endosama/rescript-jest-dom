[![Release @endosama/rescript-jest-dom](https://github.com/endosama/rescript-jestdom/actions/workflows/release-package.yml/badge.svg?branch=main)](https://github.com/endosama/rescript-jestdom/actions/workflows/release-package.yml)

# rescript-jest-dom

A list of [jest-dom](https://testing-library.com/docs/ecosystem-jest-dom/) bindings for Rescript


## Installation

```js
# using npm
npm install @endosama/rescript-jest-dom

# using yarn
yarn add @endosama/rescript-jest-dom
```

and then add the package as a dependency in your `bsconfig.json` file:
```js
"bs-dependencies": [
  ...,
  "@endosama/rescript-jest-dom"
]
```
## Usage

```js
open Jest
open Expect
open JestDom

element->expect->toHaveTextContent(#Str("Hello there!")) // pass
```

# Documentation
Automatically generated using [chat-gpt](https://openai.com/blog/chatgpt/). If anything is missing check the [jest-dom Documentation](https://github.com/testing-library/jest-dom#custom-matchers)

## toBeInTheDocument
Asserts that the specified element is in the document.

```expect(dom)->ExpectDom.toBeInTheDocument()```

## toHaveClass
Asserts that the specified element has the given class.

```expect(dom)->ExpectDom.toHaveClass(className)```
### Parameters
- `className`: The class to check for.

## toHaveAttribute
Asserts that the specified element has the given attribute.

```expect(dom)->ExpectDom.toHaveAttribute(attributeName, attributeValue?)```

### Parameters
- `attributeName`: The attribute to check for.
- `attributeValue` (optional): The expected value of the attribute. If not provided, only the presence of the attribute is checked.


## toHaveTextContent
Asserts that the specified element has the given text content.

```expect(dom)->ExpectDom.toHaveTextContent(text)```

### Parameters
- `text`: The text content to check for.

## toHaveValue
Asserts that the specified element has the given value.

```expect(dom)->ExpectDom.toHaveValue(value)```

### Parameters
- `value`: The value to check for.

## toBeChcked
Asserts that the specified input element (of type checkbox or radio) is checked or not.

```expect(dom)->ExpectDom.toBeChecked```
