evaluate-commands %sh{
    foreground="black"
    fg_01="rgb:262626"      
    fg_02="rgb:3A3A3A"      
    fg_03="rgb:444444"      
    fg_04="rgb:585858"      
    fg_05="rgb:6C6C6C"      

    bg_05="rgb:808080"      
    bg_04="rgb:8A8A8A"      
    bg_03="rgb:AFAFAF"      
    bg_02="rgb:E4E4E4"      
    bg_01="rgb:EEEEEE"      
    background="white"

    literal="rgb:FF8700"       
    matching_char="rgb:FF875F+b"  
    string="rgb:A78000" 
    type="rgb:D70000"       
    keyword="rgb:119300"
    variable="rgb:007D93"         
    meta="rgb:AF87FF"       

    echo "
# For Code
face global value     ${literal}
face global type      ${type}
face global variable  ${variable}
face global module    ${keyword}
face global function  ${variable}
face global string    ${string}
face global keyword   ${keyword}
face global operator  ${keyword}
face global attribute ${variable}
face global comment   ${bg_05}
face global meta      ${keyword}
face global builtin   ${foreground}

# For markup
face global title  +u
# face global header default
face global bold   +b
face global italic +i
# face global mono   default
# face global block  default
# face global link   default
# face global bullet default
# face global list   default

# builtin faces
face global Default            ${fg_01},${bg_01}
face global PrimaryCursor      ${background},${foreground}
face global PrimarySelection   ${background},${fg_05}
face global SecondaryCursor    ${foreground},${bg_04}
face global SecondarySelection ${foreground},${bg_02}
face global PrimaryCursorEol   ${background},${foreground}
face global SecondaryCursorEol ${background},${bg_04}
face global LineNumbers        ${fg_04},default
face global LineNumberCursor   ${fg_04},default
face global LineNumbersWrapped ${bg_01},${bg_01}
face global MenuForeground     white,blue
face global MenuBackground     blue,white
face global MenuInfo           cyan
face global Information        black,yellow
face global Error              black,red
face global StatusLine         ${fg_01},${bg_03}
face global StatusLineMode     ${fg_01},${bg_03}
face global StatusLineInfo     ${fg_01},${bg_03}
face global StatusLineValue    ${fg_01},${bg_03}

# face global StatusCursor       black,cyan
# face global Prompt             yellow,default
face global MatchingChar       ${matching_char}
face global BufferPadding      ${fg_05},${bg_02}
"
}
