module HaveClass = {
  type options = {"exact": Js.Undefined.t<bool>}

  let make = (~exact: bool=false, ()) : options => {
    "exact": exact->Js.Undefined.return
  }
}

module TextContent = {
  type options = {"normalizeWhitespace": Js.Undefined.t<bool>}

  let make = (~normalizeWhitespace=false, ()): options => {
    "normalizeWhitespace": normalizeWhitespace->Js.Undefined.return
  }
}