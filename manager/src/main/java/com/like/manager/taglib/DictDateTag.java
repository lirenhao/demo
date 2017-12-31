package com.like.manager.taglib;

import org.springframework.web.servlet.tags.form.AbstractHtmlElementTag;
import org.springframework.web.servlet.tags.form.TagWriter;

import javax.servlet.jsp.JspException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DictDateTag extends AbstractHtmlElementTag {

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddhhmmss");

    private String defaultValue = "时间格式错错误";

    /**
     * 日期的值（yyyyMMddHHmmss）
     */
    private String value;

    /**
     * 日期转换的格式
     */
    private String format = "yyyy-MM-dd HH:mm:ss";

    /**
     * CSS样式
     */
    private String styleClass;

    private TagWriter tagWriter;

    @Override
    protected int writeTagContent(TagWriter tagWriter) throws JspException {
        this.tagWriter = tagWriter;
        tagWriter.startTag("span");
        if (styleClass != null) {
            tagWriter.writeAttribute("styleClass", styleClass);
        }
        return EVAL_BODY_INCLUDE;
    }

    @Override
    public int doEndTag() throws JspException {
        try {
            String times="";
            if (value!=null&&!"".equals(value)){
                times=value;
                if (times.substring(8,10).equals("12")){
                    Date date = sdf.parse(value);
                    SimpleDateFormat formatter = new SimpleDateFormat(format);
                    String now=formatter.format(date);
                    if (now.substring(11,13).equals("00")){
                        now=now.replace(" 00:"," 12:");
                    }
                    tagWriter.appendValue(now);
                }else {
                    Date date = sdf.parse(value);
                    SimpleDateFormat formatter = new SimpleDateFormat(format);
                    String now = formatter.format(date);
                    tagWriter.appendValue(now);
                }
            }else {
                Date date = sdf.parse(value);
                SimpleDateFormat formatter = new SimpleDateFormat(format);
                String now = formatter.format(date);
                tagWriter.appendValue(now);
            }
        } catch (ParseException e) {
            tagWriter.appendValue(value);
        }
        tagWriter.endTag();
        return EVAL_PAGE;
    }

    public String getDefaultValue() {
        return defaultValue;
    }

    public void setDefaultValue(String defaultValue) {
        this.defaultValue = defaultValue;
    }

    public String getValue() {
        return value;
    }

    public void setValue(String value) {
        this.value = value;
    }

    public String getFormat() {
        return format;
    }

    public void setFormat(String format) {
        this.format = format;
    }

    public String getStyleClass() {
        return styleClass;
    }

    public void setStyleClass(String styleClass) {
        this.styleClass = styleClass;
    }

    public TagWriter getTagWriter() {
        return tagWriter;
    }

    public void setTagWriter(TagWriter tagWriter) {
        this.tagWriter = tagWriter;
    }
}