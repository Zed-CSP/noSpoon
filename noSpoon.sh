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
done | gawk '
    {
    a[$3]=0;
    for (x in a){o=a[x];
    a[x]=a[x]+1;
    printf "\033[%s;%sH\033[2;32m%s",o,x,$4;
    printf "\033[%s;%sH\033[1;37m%s\033[0;0H",a[x],x,$4;
    if (a[x] >= $1){a[x]=0;
    } 

    if (rand() < 0.075) {
        col = int(rand() * $2) + 1;  # Random column between 1 and $COLS
        for (i = 1; i <= $1; i++) {
            printf "\033[%s;%sH\033[1;37m ", i, col;
        }
    }
}}'