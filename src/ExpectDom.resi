type t = Dom.element
type assertion

type modifier<'a> = [
  | #Just('a)
  | #Not('a)
]

module Internal: {
  @val external expect: 'a => {..} = "expect"
  let affirm: (assertion) => Jest.assertion
}


type plainPartial<'a> = [#Just('a)]
type invertedPartial<'a> = [#Not('a)]
type partial<'a> = [
  | plainPartial<'a>
  | invertedPartial<'a>
]
let expect: 'a => plainPartial<'a>

let toHaveTextContentWithOptions: (
  [< partial<Dom.element>],
  @unwrap [< #Str(string) | #RegExp(Js.Re.t)],
  ~options: Options.TextContent.options
) => Jest.assertion

let toHaveTextContent: (
  [< partial<Dom.element>],
  @unwrap [< #Str(string) | #RegExp(Js.Re.t)],
) => Jest.assertion

let toContainElement: (
  [< partial<Dom.element>],
  'a,
) => Jest.assertion

let toHaveClassWithOptions: (
  [< partial<Dom.element>],
  string,
  ~options: Options.HaveClass.options
) => Jest.assertion
let toHaveClass: (
  [< partial<Dom.element>],
  string
) => Jest.assertion

let toBeDisabled: [< partial<Dom.element>] => Jest.assertion
let toBeChecked: [< partial<Dom.element>] => Jest.assertion
let toBeEnabled: [< partial<Dom.element>] => Jest.assertion
let toBeEmptyDOMElement: [< partial<Dom.element>] => Jest.assertion
let toBeInTheDocument: [< partial<Dom.element>] => Jest.assertion
let toBeValid: [< partial<Dom.element>] => Jest.assertion
let toBeInvalid: [< partial<Dom.element>] => Jest.assertion
let toBeRequired: [< partial<Dom.element>] => Jest.assertion
let toBeVisible: [< partial<Dom.element>] => Jest.assertion
let toHaveAttribute: (
  [< partial<Dom.element>],
  string,
  string
) => Jest.assertion
let toHaveFocus: [< partial<Dom.element>] => Jest.assertion

let toHaveStyle: (
  [< partial<Dom.element>], 
  @unwrap [< #Str(string) | #Obj({..})]
) => Jest.assertion
