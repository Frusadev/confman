import strutils
import strformat
import os

type 
  FileNotFoundError = object of CatchableError

type 
  FileKind* = enum 
    DIRECTORY
    FILE

type 
  FileNode* = ref object 
    children*: seq[FileNode]
    fileType*: FileKind
    path*: string
    name*: string
    rootNode*: FileNode

type 
  DirTree* = ref object 
    root*: FileNode

proc initFileNode(path: string) : FileNode =
  if fileExists(path) or (dirExists(path)):
    result = new(FileNode)
    result.path = path
    result.name = split(path, '/')[path.len - 1]
    if getFileInfo(path).kind == pcDir:
      result.fileType = DIRECTORY
    else: 
      result.fileType = FILE


proc getChildren*(node: FileNode) : seq[FileNode] =
  result = node.children

proc addChild*(node: var FileNode, child: var FileNode) =
  child.rootNode = node
  node.children.add(child)

proc addChildren*(node: var FileNode, children: var seq[FileNode]) =
  for child in children:
    child.rootNode = node
  node.children.add(children)

proc getRoot*(node: FileNode) : FileNode =
  result = node.rootNode

proc getPath*(node: FileNode, pathConstruct: var string) =
  var 
    path: string = pathConstruct
  if not (getRoot(node) == nil):
    let 
      rootName = getRoot(node).name
    path.insert(fmt"{rootName}/", 0)
    getPath(node, path)

proc toFileNode*(pathTuple: (PathComponent, string)) : FileNode =
  let 
    filePath: string = pathTuple[1]
  result = new(FileNode)
  result.path = filePath
  if pathTuple[0] == pcDir:
    result.fileType = DIRECTORY
  else: result.fileType = FILE
  # Get the last word of the split
  result.name = split(filePath, '/')[filePath.len() - 1]
  

proc initDirNode*(rootNode: var FileNode) =
  # I get the list of dirs 
  # add them as child to the rootNode and get their list and repeat
  for dirs in walkDir(rootNode.path):
    var child = toFileNode(dirs)
    rootNode.addChild(child)
  # Repeat the process for each child in rootNode
  for child in mitems(rootNode.children):
    initDirNode(child)
