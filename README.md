[![Release @endosama/rescript-jest-dom](https://github.com/endosama/rescript-jestdom/actions/workflows/release-package.yml/badge.svg?branch=main)](https://github.com/endosama/rescript-jestdom/actions/workflows/release-package.yml)

# rescript-jest-dom

A list of JestDom bindings for Rescript


## Installation

```js
# using npm
npm install rescript-jest-dom

# using yarn
yarn add rescript-jest-dom
```

## Usage

```js
open Jest
open Expect
open JestDom

element->expect->toHaveTextContent(#Str("Hello there!")) // pass
```

# Functions

This list contains the currently supported jest-dom assertions:

  - toHaveTextContent
  - toContainElement
  - toHaveClassWithOptions
  - toHaveClass
  - toBeDisabled
  - toBeEnabled
  - toBeEmptyDOMElement
  - toBeInTheDocument
  - toBeValid
  - toBeInvalid
  - toBeRequired
  - toBeVisible
  - toHaveAttribute
  - toHaveFocus
  - toHaveStyle