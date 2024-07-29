{.pragma: ewdata, codegenDecl: DataInEwram.}
{.pragma: iwdata, codegenDecl: DataInIwram.}
{.pragma: ewcode, codegenDecl: ThumbCodeInEwram.}
{.pragma: iwcode, codegenDecl: ArmCodeInIwram.}

const DataInIwram* = "__attribute__((section(\".iwram.data\"))) $# $#"
const DataInEwram* = "__attribute__((section(\".ewram.data\"))) $# $#"
const ArmCodeInIwram* = "__attribute__((section(\".iwram.text\"), target(\"arm\"), long_call)) $# $#$#"
const ThumbCodeInEwram* = "__attribute__((section(\".ewram.text\"), target(\"thumb\"), long_call)) $# $#$#"