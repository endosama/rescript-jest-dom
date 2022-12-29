module HaveClass: {
  type options
  let make: (~exact: bool=?, ()) => options
}
module TextContent: {
  type options
  let make: (~normalizeWhitespace: bool=?, ()) => options
}