echo ''
echo '-------------------------------------'
echo 'Parsing data ......'
echo '-------------------------------------'

for i in $@
do
    echo 'Parsing '${i}' data ......'

    # xmllint --format ./tmp/checker/${i}.xml > ./tmp/checker/${i}.format.xml
    # ./util/xmlparser.sh ./tmp/checker/${i}.format.xml > ./tmp/parse/${i}.info

    # sed -i 's|        ELEMENT=manifest ATTRIBUTE=version VALUE=||g' ./tmp/parse/${i}.info
    # sed -i 's|        ELEMENT=url ATTRIBUTE=codebase VALUE=||g' ./tmp/parse/${i}.info
    # sed -i 's| ATTRIBUTE=hash |\n|g' ./tmp/parse/${i}.info
    # sed -i 's| ATTRIBUTE=name VALUE=|\n|g' ./tmp/parse/${i}.info
    # sed -i 's| ATTRIBUTE=required VALUE=true ATTRIBUTE=size VALUE=|\n|g' ./tmp/parse/${i}.info
    # sed -i 's| ATTRIBUTE=hash_sha256 VALUE=|\n|g' ./tmp/parse/${i}.info
    # sed -i 's|    ELEMENT=time ATTRIBUTE=checktime VALUE=||g' ./tmp/parse/${i}.info
    # sed -i 's|https://||g' ./tmp/parse/${i}.info
    # sed -i 's| ||g' ./tmp/parse/${i}.info

    # sed -n '14p' ./tmp/parse/${i}.info > ./tmp/parse/${i}-result.info
    # sed -n '8p' ./tmp/parse/${i}.info >> ./tmp/parse/${i}-result.info
    # sed -n '10p' ./tmp/parse/${i}.info >> ./tmp/parse/${i}-result.info
    # sed -n '23p' ./tmp/parse/${i}.info >> ./tmp/parse/${i}-result.info
    # sed -n '22p' ./tmp/parse/${i}.info >> ./tmp/parse/${i}-result.info
    # sed -n '24p' ./tmp/parse/${i}.info >> ./tmp/parse/${i}-result.info
    VERSION=$(xmllint --xpath "string(/response/app/updatecheck/manifest/@version)" ./tmp/checker/${i}.xml) 
    URL1=$(xmllint --xpath "string(/response/app/updatecheck/urls/url[starts-with(@codebase,'https://redirector.gvt1.com')]/@codebase)" ./tmp/checker/${i}.xml)
    URL2=$(xmllint --xpath "string(/response/app/updatecheck/urls/url[starts-with(@codebase,'https://dl.google.com')]/@codebase )" ./tmp/checker/${i}.xml)
    INSTALLER=$(xmllint --xpath "string(/response/app/updatecheck/manifest/actions/action[@event='install']/@run)" ./tmp/checker/${i}.xml)
    SHA256=$(xmllint --xpath "string(/response/app/updatecheck/manifest/packages/package/@hash_sha256)" ./tmp/checker/${i}.xml)
    SIZE=$(xmllint --xpath "string(/response/app/updatecheck/manifest/packages/package/@size)" ./tmp/checker/${i}.xml)
    echo $VERSION  > ./tmp/parse/${i}-result.info
    echo $URL1  >> ./tmp/parse/${i}-result.info
    #xmllint --xpath "string(/response/app/updatecheck/urls/url[starts-with(@codebase,'https://redirector.gvt1.com')]/@codebase)" ./tmp/checker/${i}.xml >> ./tmp/parse/${i}-result.info
    echo $URL2 >> ./tmp/parse/${i}-result.info
    #xmllint --xpath "string(/response/app/updatecheck/urls/url[starts-with(@codebase,'https://www.google.com')]/@codebase)" ./tmp/checker/${i}.xml >> ./tmp/parse/${i}-result.info
    sed -i 's|https://||g' ./tmp/parse/${i}-result.info
    echo $INSTALLER  >> ./tmp/parse/${i}-result.info
    echo $SHA256  >> ./tmp/parse/${i}-result.info
    echo $SIZE  >> ./tmp/parse/${i}-result.info
done
