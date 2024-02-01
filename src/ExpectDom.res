type t = Dom.element

type modifier<'a> = [
  | #Just('a)
  | #Not('a)
]

let mapMod = (f, x) =>
  switch x {
  | #Just(a) => #Just(f(a))
  | #Not(a) => #Not(f(a))
  }


type rec assertion =
  | ToHaveTextContentString(modifier<(Dom.element, string, Options.TextContent.options)>): assertion
  | ToHaveTextContentRegExp(modifier<(Dom.element, Js.Re.t, Options.TextContent.options)>): assertion
  | ToContainElement(modifier<(Dom.element, 'a)>): assertion
  | ToHaveClass(modifier<(Dom.element, 'b, Options.HaveClass.options)>): assertion
  | ToBeDisabled(modifier<Dom.element>): assertion
  | ToBeEnabled(modifier<Dom.element>): assertion
  | ToBeEmptyDOMElement(modifier<Dom.element>): assertion
  | ToBeInTheDocument(modifier<Dom.element>): assertion
  | ToBeInvalid(modifier<Dom.element>): assertion
  | ToBeValid(modifier<Dom.element>): assertion
  | ToBeRequired(modifier<Dom.element>): assertion
  | ToBeVisible(modifier<Dom.element>): assertion
  | ToHaveAttribute(modifier<(Dom.element, string, string)>): assertion
  | ToHaveFocus(modifier<Dom.element>): assertion
  | ToHaveStyleString(modifier<(Dom.element, string)>): assertion
  | ToHaveStyleObject(modifier<(Dom.element, {..})>): assertion
  | ToBeChecked(modifier<(Dom.element)>): assertion


module Internal = {
  @val external expect: 'a => {..} = "expect"

  let affirm = (x) => {
    let result:  Js.nullable<{..}> = switch x {
    | ToHaveTextContentString(#Just(a, b, options)) => expect(a)["toHaveTextContent"](. b, options)
    | ToHaveTextContentString(#Not(a, b, options)) => expect(a)["not"]["toHaveTextContent"](. b, options)
    | ToHaveTextContentRegExp(#Just(a, b, options)) => expect(a)["toHaveTextContent"](. b, options)
    | ToHaveTextContentRegExp(#Not(a, b, options)) => expect(a)["not"]["toHaveTextContent"](. b, options)
    | ToContainElement(#Just(a, b)) => expect(a)["toContainElement"](. b)
    | ToContainElement(#Not(a, b)) => expect(a)["not"]["toContainElement"](. b)
    | ToHaveClass(#Just(a, b, options)) => expect(a)["toHaveClass"](. b, options)
    | ToHaveClass(#Not(a, b, options)) => expect(a)["not"]["toHaveClass"](. b, options)
    | ToBeDisabled(#Just(a)) => expect(a)["toBeDisabled"]()
    | ToBeDisabled(#Not(a)) => expect(a)["not"]["toBeDisabled"]()
    | ToBeEnabled(#Just(a)) => expect(a)["toBeEnabled"]()
    | ToBeEnabled(#Not(a)) => expect(a)["not"]["toBeEnabled"]()
    | ToBeEmptyDOMElement(#Just(a)) => expect(a)["toBeEmptyDOMElement"]()
    | ToBeEmptyDOMElement(#Not(a)) => expect(a)["not"]["toBeEmptyDOMElement"]()
    | ToBeInTheDocument(#Just(a)) => expect(a)["toBeInTheDocument"]()
    | ToBeInTheDocument(#Not(a)) => expect(a)["not"]["toBeInTheDocument"]()
    | ToBeInvalid(#Just(a)) => expect(a)["toBeInvalid"]()
    | ToBeInvalid(#Not(a)) => expect(a)["not"]["toBeInvalid"]()
    | ToBeValid(#Just(a)) => expect(a)["toBeValid"]()
    | ToBeValid(#Not(a)) => expect(a)["not"]["toBeValid"]()
    | ToBeRequired(#Just(a)) => expect(a)["toBeRequired"]()
    | ToBeRequired(#Not(a)) => expect(a)["not"]["toBeRequired"]()
    | ToBeVisible(#Just(a)) => expect(a)["toBeVisible"]()
    | ToBeVisible(#Not(a)) => expect(a)["not"]["toBeVisible"]()
    | ToHaveAttribute(#Just(a, b, c)) => expect(a)["toHaveAttribute"](. b, c)
    | ToHaveAttribute(#Not(a, b, c)) => expect(a)["not"]["toHaveAttribute"](. b, c)
    | ToHaveFocus(#Just(a)) => expect(a)["toHaveFocus"]()
    | ToHaveFocus(#Not(a)) => expect(a)["not"]["toHaveFocus"]()
    | ToHaveStyleString(#Just(a, b)) => expect(a)["toHaveStyle"](b)
    | ToHaveStyleString(#Not(a, b)) => expect(a)["not"]["toHaveStyle"](b)
    | ToHaveStyleObject(#Just(a, b)) => expect(a)["toHaveStyle"](b)
    | ToHaveStyleObject(#Not(a, b)) => expect(a)["not"]["toHaveStyle"](b)
    | ToBeChecked(#Just(a)) => expect(a)["toBeChecked"]()
    | ToBeChecked(#Not(a)) => expect(a)["not"]["toBeChecked"]()
    }
    switch result->Js.Nullable.toOption {
    | Some(result) => Jest.fail(result["message"])
    | None => Jest.pass
    }
  }
}

type plainPartial<'a> = [#Just('a)]
type invertedPartial<'a> = [#Not('a)]
type partial<'a> = modifier<'a>

let expect = a => #Just(a)

let toHaveTextContentWithOptions = (expect, content, ~options) => switch content {
  | #Str(string) => ToHaveTextContentString(mapMod(a => (a, string, options), expect))->Internal.affirm
  | #RegExp(string) => ToHaveTextContentRegExp(mapMod(a => (a, string, options), expect))->Internal.affirm
}

let toHaveTextContent = (expect, content) => toHaveTextContentWithOptions(expect, content, ~options=Options.TextContent.make())

let toContainElement = (expect, element) => {
  ToContainElement(mapMod(a => (a, element), expect))->Internal.affirm
}

let toHaveClassWithOptions = (expect, class, ~options) => {
  ToHaveClass(mapMod(a => (a, class, options), expect))->Internal.affirm
}
let toHaveClass = (expect, class) => toHaveClassWithOptions(expect, class, ~options=Options.HaveClass.make())

let toBeDisabled = expect => {
  ToBeDisabled(mapMod(a => a, expect))->Internal.affirm
}

let toBeEnabled = expect => {
  ToBeEnabled(mapMod(a => a, expect))->Internal.affirm
}

let toBeEmptyDOMElement = expect => {
  ToBeEmptyDOMElement(mapMod(a => a, expect))->Internal.affirm
}

let toBeInTheDocument = expect => {
  ToBeInTheDocument(mapMod(a => a, expect))->Internal.affirm
}

let toBeInvalid = expect => {
  ToBeInvalid(mapMod(a => a, expect))->Internal.affirm
}

let toBeValid = expect => {
  ToBeValid(mapMod(a => a, expect))->Internal.affirm
}

let toBeRequired = expect => {
  ToBeRequired(mapMod(a => a, expect))->Internal.affirm
}

let toBeVisible = expect => {
  ToBeVisible(mapMod(a => a, expect))->Internal.affirm
}

let toHaveAttribute = (expect, attributeName, attributeValue) => {
  ToHaveAttribute(mapMod(a => (a, attributeName, attributeValue), expect))->Internal.affirm
}

let toHaveFocus = (expect) => {
  ToHaveFocus(mapMod(a => a, expect))->Internal.affirm
}

let toHaveStyle = (expect, matchStyle) => {
  switch matchStyle {
    | #Str(string) => ToHaveStyleString(mapMod(a => (a, string), expect))->Internal.affirm
    | #Obj(obj) => ToHaveStyleObject(mapMod(a => (a, obj), expect))->Internal.affirm
  }
}

let toBeChecked = expect => {
  ToBeChecked(mapMod(a => a, expect))->Internal.affirm
}
