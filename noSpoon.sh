ROWS=$(tput lines)
COLS=$(tput cols)


while :
do
    RAND=${RANDOM}
    CHAR=$((32 + (${RAND} % 96)))
    HEXA=$(printf "%02X" "${CHAR}")
    CODE=$(printf "\x${HEXA}")
    SPACE=$(printf "\x20")
    echo "${ROWS} ${COLS} $((${RAND} % ${COLS})) ${CODE} ${SPACE}"
    sleep 0.05
done | gawk '{
    a[$3]=0;                                                          # initialize array a with 0 for each column
    for (x in a) {                                                    # for each column
        o=a[x];                                                       # save the old value
        a[x]=a[x]+1;                                                  # increment the value
        printf "\033[%s;%sH\033[2;32m%s",o,x,$4;                      # print the old value
        printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,$4;          # print the new value
        if (a[x] >= $1) {                                             # if the value is greater than the number of rows
            a[x]=0;                                                   # reset the value
            printf "\033[%s;%sH\033[2;32m%s",a[x],x,$5;               # print a space
        }
    } 


}}'

#    if (rand() < 0.075) {
#        col = int(rand() * $2) + 1;                    # random column
#        for (i = 1; i <= $1; i++) {                    # for each row
#            printf "\033[%s;%sH\033[1;37m ", i, col;   # clear the column
#        }
#    }