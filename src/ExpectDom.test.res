open Jest
open Expect
open Webapi.Dom

let getById = id => document->Document.getElementById(id)->Belt.Option.getUnsafe

describe("ExpectDom", () => {
  describe("toHaveTextContent", () => {
    describe("String", () => {
      test("should return true when the element contains the correct text", () => {
        let documentElement = document->Document.documentElement
        documentElement->Element.setInnerHTML("<div id='element'><span>This text</span></div>")
        expect(getById("element"))->ExpectDom.toHaveTextContent(#Str("This text"))
      })
      test("should return true when the element contains a portion of the text", () => {
        let documentElement = document->Document.documentElement
        documentElement->Element.setInnerHTML("<div id='element'><span>This text</span></div>")
        expect(getById("element"))->ExpectDom.toHaveTextContent(#Str("This "))
      })
      test("should return false when the element does not contains the text", () => {
        let documentElement = document->Document.documentElement
        documentElement->Element.setInnerHTML("<div id='element'><span>This text</span></div>")
        expect(getById("element"))->not_->ExpectDom.toHaveTextContent(#Str("Those text"))
      })
    })
    describe("Regex", () => {
      test("should return true when the element text content match the regular expression", () => {
        let documentElement = document->Document.documentElement
        documentElement->Element.setInnerHTML("<div id='element'><span>This text</span></div>")
        expect(getById("element"))->ExpectDom.toHaveTextContent(#RegExp(Js.Re.fromString(`[A-Za-z ]{9}`)))
      })
      test("should return true when the element text content have a partial match match the regular expression", () => {
        let documentElement = document->Document.documentElement
        documentElement->Element.setInnerHTML("<div id='element'><span>This text</span></div>")
        expect(getById("element"))->ExpectDom.toHaveTextContent(#RegExp(Js.Re.fromString(`^This`)))
      })
      test("should return false when the element does not contains the text", () => {
        let documentElement = document->Document.documentElement
        documentElement->Element.setInnerHTML("<div id='element'><span>This text</span></div>")
        expect(getById("element"))->not_->ExpectDom.toHaveTextContent(#RegExp(Js.Re.fromString(`[0-9]{9}`)))
      })
    })
  })
  describe("toHaveClass", () => {
    test("should return true when the class is included", () => {
      let div = document->Document.createElement("div")
      div->Element.setAttribute("class", "hello")
      expect(div)->ExpectDom.toHaveClass("hello")
    })
    test("should return false when the class is NOT included", () => {
      let div = document->Document.createElement("div")
      div->Element.setAttribute("class", "something-else")
      expect(div)->not_->ExpectDom.toHaveClass("hello")
    })

    describe("withOptions - exact: true", () => {
      test("should return false when the some of the classes are matched", () => {
        let div = document->Document.createElement("div")
        div->Element.setAttribute("class", " hello something-else")
        expect(div)->not_->ExpectDom.toHaveClassWithOptions("hello", ~options=Options.HaveClass.make(~exact=true, ()))
      })
      test("should return true when all the classes are matched", () => {
        let div = document->Document.createElement("div")
        div->Element.setAttribute("class", " hello something-else")
        expect(div)->ExpectDom.toHaveClassWithOptions("hello something-else", ~options=Options.HaveClass.make(~exact=true, ()))
      })
      test("should return true when all the classes are matched in different order", () => {
        let div = document->Document.createElement("div")
        div->Element.setAttribute("class", " hello something-else")
        expect(div)->ExpectDom.toHaveClassWithOptions("something-else hello", ~options=Options.HaveClass.make(~exact=true, ()))
      })
    })
  })

  describe("toContainElement", () => {
    test("should return true when the element contains the child", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<div id='inside' />")
      let innerDiv = getById("inside")
      expect(documentElement)->ExpectDom.toContainElement(innerDiv)
    })
    test("should return false when the element does NOT contain the child", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML(
        "<div id='outside' /><div id='container'><div id='inside'/></div>",
      )
      let container = getById("container")
      let outside = getById("outside")
      expect(container)->not_->ExpectDom.toContainElement(outside)
    })
  })

  describe("toBeDisabled", () => {
    test("should return true when the element is disabled", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='input' disabled />")
      let input = getById("input")
      expect(input)->ExpectDom.toBeDisabled
    })

    test("should return false when the element is NOT disabled", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='input' />")
      let input = getById("input")
      expect(input)->not_->ExpectDom.toBeDisabled
    })
  })

  describe("toBeEnabled", () => {
    test("should return true when the element is enabled", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='input' />")
      let input = getById("input")
      expect(input)->ExpectDom.toBeEnabled
    })

    test("should return false when the element is NOT enabled", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='input' disabled />")
      let input = getById("input")
      expect(input)->not_->ExpectDom.toBeEnabled
    })
  })

  describe("toBeEmptyDOMElement", () => {
    test("should return true when the element is empty", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<div id='element' />")
      let element = getById("element")
      expect(element)->ExpectDom.toBeEmptyDOMElement
    })

    test("should return false when the element is NOT empty", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<div id='element'>Something</div>")
      let element = getById("element")
      expect(element)->not_->ExpectDom.toBeEmptyDOMElement
    })
  })

  describe("toBeInTheDocument", () => {
    test("should return true when the element is in the document", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<div id='element' />")
      let element = getById("element")
      expect(element)->ExpectDom.toBeInTheDocument
    })

    test("should return false when the element is NOT in the document", () => {
      let element = document->Document.createElement("div")
      expect(element)->not_->ExpectDom.toBeInTheDocument
    })
  })
  describe("toBeInvalid", () => {
    test("should return true when the element is invalid", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' aria-invalid />")
      let element = getById("element")
      expect(element)->ExpectDom.toBeInvalid
    })

    test("should return false when the element is valid", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<div id='element' />")
      let element = getById("element")
      expect(element)->not_->ExpectDom.toBeInvalid
    })
  })
  describe("toBeValid", () => {
    test("should return true when the element is valid", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<div id='element' />")
      let element = getById("element")
      expect(element)->ExpectDom.toBeValid
    })

    test("should return false when the element is invalid", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' aria-invalid />")
      let element = getById("element")
      expect(element)->not_->ExpectDom.toBeValid
    })
  })
  describe("toBeRequired", () => {
    test("should return true when the element is required", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' required />")
      let element = getById("element")
      expect(element)->ExpectDom.toBeRequired
    })

    test("should return false when the element is NOT required", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' />")
      let element = getById("element")
      expect(element)->not_->ExpectDom.toBeRequired
    })
  })
  describe("toBeVisible", () => {
    test("should return true when the element is visible", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' style='visibility: visible' />")
      let element = getById("element")
      expect(element)->ExpectDom.toBeVisible
    })

    test("should return false when the element is hidden", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' style='visibility: hidden' />")
      let element = getById("element")
      expect(element)->not_->ExpectDom.toBeVisible
    })
  })
  describe("toHaveAttribute", () => {
    test("should return true when the element has the attribute set", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' style='visibility: visible' />")
      let element = getById("element")
      expect(element)->ExpectDom.toHaveAttribute("style", "visibility: visible")
    })
    test("should return false when the element has the attribute with a different value", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' style='visibility: hidden' />")
      let element = getById("element")
      expect(element)->not_->ExpectDom.toHaveAttribute("style", "visibility: visible")
    })
    test("should return false when the element doesn't have the attribute set", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' style='visibility: hidden' />")
      let element = getById("element")
      expect(element)->not_->ExpectDom.toHaveAttribute("class", "something")
    })
  })

  describe("toHaveFocus", () => {
    test("should return true when the element has the attribute set", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' />")
      let element = getById("element")
      element
        ->Element.unsafeAsHtmlElement 
        ->HtmlElement.focus
        ->ignore
      expect(element)->ExpectDom.toHaveFocus
    })

    test("should return false when the element doesn't have the attribute set", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' style='visibility: hidden' />")
      let element = getById("element")
      expect(element)->not_->ExpectDom.toHaveFocus
    })
  })

  describe("toHaveStyle", () => {
    test("should return true when the element has the correct style - String", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' style='visibility: hidden' />")
      let element = getById("element")
      expect(element)->ExpectDom.toHaveStyle(#Str("visibility: hidden"))
    })
    test("should return false when the element has the wrong style - String", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' style='visibility: hidden' />")
      let element = getById("element")
      expect(element)->not_->ExpectDom.toHaveStyle(#Str("visibility: visible"))
    })
    test("should return true when the element has the correct style - Object", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' style='visibility: hidden' />")
      let element = getById("element")
      expect(element)->ExpectDom.toHaveStyle(#Obj({
        "visibility": "hidden"
      }))
    })
    test("should return false when the element has the wrong style - Object", () => {
      let documentElement = document->Document.documentElement
      documentElement->Element.setInnerHTML("<input id='element' style='visibility: hidden' />")
      let element = getById("element")
      expect(element)->not_->ExpectDom.toHaveStyle(#Obj({
        "visibility": "visible"
      }))
    })
  })
})
