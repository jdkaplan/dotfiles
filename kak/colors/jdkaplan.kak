%sh{
    black='black'
    gray_08='rgb:080808'      # 232
    gray_26='rgb:262626'      # 235
    gray_30='rgb:303030'      # 236
    gray_3A='rgb:3A3A3A'      # 237
    gray_44='rgb:444444'      # 238
    gray_4E='rgb:4E4E4E'      # 239
    gray_58='rgb:585858'      # 240
    gray_62='rgb:626262'      # 241
    gray_76='rgb:767676'      # 243
    gray_80='rgb:808080'      # 244
    gray_8A='rgb:8A8A8A'      # 245
    gray_A8='rgb:A8A8A8'      # 248
    gray_AF='rgb:AFAFAF'      # 145
    gray_E4='rgb:E4E4E4'      # 254
    gray_EE='rgb:EEEEEE'      # 255
    white='white'
    red='rgb:D70000'          # 160
    orange='rgb:FF8700'       # 208
    lightorange='rgb:FF875F'  # 209
    yelloworange='rgb:D7AF00' # 178
    yellow='rgb:D7D700'       # 184
    seafoam='rgb:5FD757'      # 77
    green='rgb:5ABC50'
    cyan='rgb:00D7FF'         # 45
    paleblue='rgb:AFD7FF'     # 117
    bluegray='rgb:D7D7FF'     # 181
    purple='rgb:AF87FF'       # 141

    echo "
# For Code
face global value     ${orange}
face global type      ${yellow}
face global variable  ${cyan}
face global module    ${seafoam}
face global function  ${cyan}
face global string    ${yelloworange}
face global keyword   ${green}
face global operator  ${green}
face global attribute ${cyan}
face global comment   ${gray_AF}
face global meta      magenta
face global builtin   +b

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
face global Default            ${gray_E4},${gray_26}
face global PrimaryCursor      ${black},${white}
face global PrimarySelection   ${black},${gray_80}
face global SecondaryCursor    ${white},${gray_58}
face global SecondarySelection ${white},${gray_3A}
face global PrimaryCursorEol   ${black},${white}
face global SecondaryCursorEol ${black},${gray_58}
face global LineNumbers        ${gray_8A},default
face global LineNumberCursor   ${gray_8A},default
face global LineNumbersWrapped ${gray_26},${gray_26}
face global MenuForeground     white,blue
face global MenuBackground     blue,white
face global MenuInfo           cyan
face global Information        black,yellow
face global Error              black,red
face global StatusLine         ${gray_EE},${gray_44}
face global StatusLineMode     ${gray_EE},${gray_44}
face global StatusLineInfo     ${gray_EE},${gray_44}
face global StatusLineValue    ${gray_EE},${gray_44}

# face global StatusCursor       black,cyan
# face global Prompt             yellow,default
face global MatchingChar       ${lightorange},${gray_26}+b
face global BufferPadding      ${gray_80},${gray_3A}
"
}
