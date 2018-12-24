## Adapted from https://raw.githubusercontent.com/leira/base16-kakoune/cda1583edc4eae387c17eb37f195496aa21ace2a/colors/base16-default-light.kak

evaluate-commands %sh{
    base00='rgb:f8f8f8'
    base01='rgb:e8e8e8'
    base02='rgb:d8d8d8'
    base03='rgb:b8b8b8'
    base04='rgb:585858'
    base05='rgb:383838'
    base06='rgb:282828'
    base07='rgb:181818'
    base08='rgb:ab4642' # red
    base09='rgb:dc9656' # orange
    base0A='rgb:f7ca88' # yellow-orange
    base0B='rgb:a1b56c' # green-brown
    base0C='rgb:86c1b9' # teal
    base0D='rgb:7cafc2' # blue
    base0E='rgb:ba8baf' # purple
    base0F='rgb:a16946' # brown

    ## code
    echo "
        face global attribute ${base0C}
        face global builtin ${base0D}
        face global comment ${base03}
        face global identifier ${base08}
        face global function ${base0D}
        face global keyword ${base0E}+b
        face global meta ${base0D}
        face global module ${base0E}
        face global operator ${base05}
        face global string ${base0B}
        face global type ${base0A}+b
        face global value ${base09}
        face global variable ${base08}
    "

    ## markup
    echo "
        face global block ${base0C}
        face global bold ${base0A}+b
        face global bullet ${base08}
        face global header ${base0D}+b
        face global italic ${base0E}
        face global link ${base09}
        face global list ${base08}
        face global mono ${base0B}
        face global title ${base0D}+b
    "

    ## builtin
    echo "
        face global BufferPadding ${base03},${base00}
        face global Default ${base05},${base00}
        face global Error ${base00},${base08}
        face global Information ${base00},${base0A}
        face global LineNumberCursor ${base0A},${base00}
        face global LineNumbers ${base02},${base00}
        face global MatchingChar ${base06},${base02}+b
        face global MenuBackground ${base00},${base0C}
        face global MenuForeground ${base00},${base0D}
        face global MenuInfo ${base02}
        face global PrimaryCursor ${base00},${base05}
        face global PrimaryCursorEol ${base00},${base03}+fg
        face global PrimarySelection ${base06},${base0D}
        face global Prompt ${base0D},${base01}
        face global SecondaryCursor ${base06},${base03}
        face global SecondaryCursorEol ${base06},${base02}+fg
        face global SecondarySelection ${base06},${base01}
        face global StatusCursor ${base00},${base05}
        face global StatusLine ${base04},${base01}
        face global StatusLineInfo ${base0D}
        face global StatusLineMode ${base0B}
        face global StatusLineValue ${base0C}
        face global Whitespace ${base0F}+f
    "
}
