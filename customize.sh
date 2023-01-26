ui_print "################################"
ui_print "##### font completion      #####"
ui_print "##### writen by chanvstone #####"
ui_print "################################"

PATHS_OF_FONTS_XML="/system/etc/fonts.xml /system_root/system/etc/fonts.xml /system/system/etc/fonts.xml"
TARGET_PATH_OF_FONTS_XML=""
for path_of_fonts_xml in ${PATHS_OF_FONTS_XML}
do
    if [ -e ${path_of_fonts_xml} ]
    then
        ui_print "- ${path_of_fonts_xml} fonded"
        TARGET_PATH_OF_FONTS_XML=${path_of_fonts_xml}
        break
    fi
done

sed -e "
    /<family.*name=\"sans-serif\"/{
        :NEXT_SANS_SERIF
        N
        s/<family.*name=\"sans-serif\".*family>/REPLACEMARK_SANS_SERIF/
        t END_SANS_SERIF
        b NEXT_SANS_SERIF
        :END_SANS_SERIF
        /REPLACEMARK_SANS_SERIF/r ${MODPATH}/font-xml/roboto-sans-serif.xml
        /REPLACEMARK_SANS_SERIF/d
    }
    " -e "
    /<family.*name=\"sans-serif-condensed\"/{
        :NEXT_SANS_SERIF_CONDENSED
        N
        s/<family.*name=\"sans-serif-condensed\".*family>/REPLACEMARK_SANS_SERIF_CONDENSED/
        t END_SANS_SERIF_CONDENSED
        b NEXT_SANS_SERIF_CONDENSED
        :END_SANS_SERIF_CONDENSED
        /REPLACEMARK_SANS_SERIF_CONDENSED/r ${MODPATH}/font-xml/roboto-sans-serif-condensed.xml
        /REPLACEMARK_SANS_SERIF_CONDENSED/d
    }
    " -e "
    /<family.*name=\"serif\"/{
        :NEXT_SERIF
        N
        s/<family.*name=\"serif\".*family>/REPLACEMARK_SERIF/
        t END_SERIF
        b NEXT_SERIF
        :END_SERIF
        /REPLACEMARK_SERIF/{
            r ${MODPATH}/font-xml/noto-serif.xml
            r ${MODPATH}/font-xml/noto-serif-condensed.xml
        }
        /REPLACEMARK_SERIF/d
    }
    " -e "
        /<family.*name=\"monospace\"/{
        :NEXT_MONOSPACE
        N
        s/<family.*name=\"monospace\".*family>/REPLACEMARK_MONOSPACE/
        t END_MONOSPACE
        b NEXT_MONOSPACE
        :END_MONOSPACE
        /REPLACEMARK_MONOSPACE/r ${MODPATH}/font-xml/noto-monospace.xml
        /REPLACEMARK_MONOSPACE/d
        }
    " -e "
    /<family.*lang=\"zh-Hans\"/{
        :NEXT_CJK_SC
        N
        s/<family.*lang=\"zh-Hans\".*family>/REPLACEMARK_CJK_SC/
        t END_CJK_SC
        b NEXT_CJK_SC
        :END_CJK_SC
        /REPLACEMARK_CJK_SC/r ${MODPATH}/font-xml/noto-cjk-sc.xml
        /REPLACEMARK_CJK_SC/d
    }
    " -e "
    /<family.*lang=\"zh-Hant,zh-Bopo\"/{
        :NEXT_CJK_TC
        N
        s/<family.*lang=\"zh-Hant,zh-Bopo\".*family>/REPLACEMARK_CJK_TC/
        t END_CJK_TC
        b NEXT_CJK_TC
        :END_CJK_TC
        /REPLACEMARK_CJK_TC/r ${MODPATH}/font-xml/noto-cjk-tc.xml
        /REPLACEMARK_CJK_TC/d
    }
    " -e "
    /<family.*lang=\"ja\"/{
        :NEXT_CJK_JP
        N
        s/<family.*lang=\"ja\".*family>/REPLACEMARK_CJK_JP/
        t END_CJK_JP
        b NEXT_CJK_JP
        :END_CJK_JP
        /REPLACEMARK_CJK_JP/r ${MODPATH}/font-xml/noto-cjk-jp.xml
        /REPLACEMARK_CJK_JP/d
    }
    " -e "
    /<family.*lang=\"ko\"/{
        :NEXT_CJK_KR
        N
        s/<family.*lang=\"ko\".*family>/REPLACEMARK_CJK_KR/
        t END_CJK_KR
        b NEXT_CJK_KR
        :END_CJK_KR
        /REPLACEMARK_CJK_KR/r ${MODPATH}/font-xml/noto-cjk-kr.xml
        /REPLACEMARK_CJK_KR/d
    }
    " ${TARGET_PATH_OF_FONTS_XML} > "${MODPATH}/system/etc/fonts.xml"
ui_print "- replacement succeed"

rm -rf ${MODPATH}/font-xml

ui_print "- everything is done"
