package com.like.manager.taglib;

import com.like.manager.model.DictItem;
import com.like.manager.util.DictUtil;
import org.springframework.web.servlet.tags.form.AbstractHtmlElementTag;
import org.springframework.web.servlet.tags.form.TagWriter;

import javax.servlet.jsp.JspException;
import java.util.List;

public class DictWriteTag extends AbstractHtmlElementTag {

	/** 下拉菜单缺省值 */
	protected String value;

	/** 不使用property时定义的下拉菜单名 */
	protected String name;

	/** 内存中字典数据名 */
	protected String dictName;
	
	/** CSS样式 */
	protected String styleClass;

	private String defaultValue = "";
	
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
		List<DictItem> list = null;
		if(dictName != null){
			 list = DictUtil.getDictByType(dictName);
		}
		if((list == null && list.size() != 0) || value == null || value.equals("")){
			tagWriter.appendValue(defaultValue);
		}else{
			for(DictItem dictItem :list){
				if(dictItem.getDictCode().equals(value)){
					tagWriter.appendValue(dictItem.getDictName());
				}
			}
		}
		
		tagWriter.endTag();
		return EVAL_PAGE;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getDictName() {
		return dictName;
	}

	public void setDictName(String dictName) {
		this.dictName = dictName;
	}

	public TagWriter getTagWriter() {
		return tagWriter;
	}

	public void setTagWriter(TagWriter tagWriter) {
		this.tagWriter = tagWriter;
	}

	public String getStyleClass() {
		return styleClass;
	}

	public void setStyleClass(String styleClass) {
		this.styleClass = styleClass;
	}

	public String getDefaultValue() {
		return defaultValue;
	}

	public void setDefaultValue(String defaultValue) {
		this.defaultValue = defaultValue;
	}

}
