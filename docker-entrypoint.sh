#!/bin/sh

# 1. go to application directory
cd /cot-pdfupload

# 2. prepare database connection details in application.properties

# depends on externally defined env vars DBSRV DBNAME DBUSER DBUSERPWD

# Password may contain special character so we should escape them before passing to sed
# see https://stackoverflow.com/questions/29613304/is-it-possible-to-escape-regex-metacharacters-reliably-with-sed
# I use | as regex delimiter
DBUSERPWDescaped=`sed 's/[&|]/\\&/g' <<< "${DBUSERPWD}"`

DBURLstr="spring.datasource.url=jdbc:mysql://${DBSRV}/${DBNAME}"
DBUSRstr="spring.datasource.username=${DBUSER}"
DBPWDstr="spring.datasource.password=${DBUSERPWDescaped}"

DBURLexp='^[[:space:]]*'                             # beginning
DBURLexp="${DBURLexp}"'spring.datasource.url'        # spring.datasource.url
DBURLexp="${DBURLexp}"'[[:space:]]*=[[:space:]]*'    #  = 
DBURLexp="${DBURLexp}"'jdbc:mysql://'                # jdbc:mysql://
DBURLexp="${DBURLexp}"'[^/]+/'                       # server:port/
DBURLexp="${DBURLexp}"'[^\?]*'                       # database
DBURLexp="${DBURLexp}"'((\?.*){0,1})$'               # ?options | saving this match

DBUSRexp='^[[:space:]]*'                             # beginning
DBUSRexp="${DBUSRexp}"'spring.datasource.username'   # spring.datasource.username
DBUSRexp="${DBUSRexp}"'[[:space:]]*=[[:space:]]*'    #  =
DBUSRexp="${DBUSRexp}"'.*$'                          # username

DBPWDexp='^[[:space:]]*'                             # beginning
DBPWDexp="${DBPWDexp}"'spring.datasource.password'   # spring.datasource.password
DBPWDexp="${DBPWDexp}"'[[:space:]]*=[[:space:]]*'    #  =
DBPWDexp="${DBPWDexp}"'.*$'                          # password


sed --in-place --regexp-extended \
		--expression="s|${DBURLexp}|${DBURLstr}\\1|" \
		--expression="s|${DBUSRexp}|${DBUSRstr}|" \
		--expression="s|${DBPWDexp}|${DBPWDstr}|" \
    src/main/resources/application.properties

# 3. run maven
mvn spring-boot:run

