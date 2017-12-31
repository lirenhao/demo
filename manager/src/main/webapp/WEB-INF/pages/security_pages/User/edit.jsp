<%--
<%@ page import="com.yada.security.model.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<head>
<html>
<body class="claro">
<fieldset style="margin: 10px 0;padding: 10px;border: #DDD 1px solid" >
	<legend>用户编辑</legend>
	<mvc:form action="update.do" theme="simple"  method="post"  data-dojo-type="dijit.form.Form">
		<input type="hidden" name="id" value="${user.id}" />
		<script type="dojo/on" data-dojo-event="submit">
		if(this.validate()){
					if(check()){
					return confirm("确定保存？");
					}else{
					return false;
					}
				}
		</script>
		<script>
            var onsbmt = true;
            function check() {
                var loginName = document.getElementById("loginName").value;
                var oldLoginName = document.getElementById("oldLoginName").value;
                if (loginName == "") {
                    document.getElementById("checkMsg").innerHTML = "请输入用户登录名";
                    return false;
                }
                //清空提示信息
                var checkMsg = dojo.byId("checkMsg");
                checkMsg.innerHTML = "*";
                //验证是否可用
                dojo.xhrGet({
                    url: "AJAX_isLoginNameExist.do",
                    sync: true,
                    content: {loginName: loginName,oldLoginName:oldLoginName},
                    load: function(data){
                        //提示信息
                        checkMsg.innerHTML = data;
                        if("*" != data){
                            onsbmt = false;
                        }
                        else{
                            onsbmt = true;
						}
                    },
                    error: function(error){
                        alert(error);
                    }
                });
                return onsbmt;
            }

            /**
             机构联动用户分组
             @param 机构ID
             */
            function findGrpByOrg(orgId){
                if(orgId){

                    //清空select,添加[--请选择--]option
                    var node = dojo.byId("userGrpId");
                    dojo.empty(node);

					/*---------------创建元素节点--------------*/
                    dojo.create("option", {
                        value : "",
                        innerHTML : "--请选择--"
                    }, node);

                    dojo.xhrGet({
                        url: "AJAX_findGrpByOrg.do",
                        sync: true,
                        content: {orgId: orgId, t: new Date().getTime()},
                        load: function(data){
                            //用户名可用
                            dojo.byId("userGrpId").disabled = false;
                            if("" != data){
                                //解析用户分组
                                dojo.forEach(dojo.fromJson(data), function(userGrp){
                                    dojo.create("option", {
                                        value : userGrp.userGrpId,
                                        innerHTML : userGrp.name
                                    }, node);
                                });
                            }else{
                                dojo.byId("userGrpId").value = "该机构下无可用用户分组";
                                dojo.byId("userGrpId").disabled = true;
                            }
                        },
                        error: function(error){
                            alert(error);
                        }
                    });
                }
            }

		</script>
			<table class="grid">
				<tr>
					<td class="lgridlist">机构:</td>
					<td >&lt;%&ndash;onblur="isLoginNameExist(this.value);"&ndash;%&gt; &lt;%&ndash;onchange&ndash;%&gt;
						<select path="orgID" id="orgId" name="orgId" onblur="findGrpByOrg(this.value);">
							<option value="">--请选择--</option>
							<c:forEach items="${lowerOrgs}" var="item">
								<option value="${item.orgId}" ${item.orgId==model.userExt.orgId?"selected='selected'":""}>${item.name}</option>
							</c:forEach>
						</select>
						<span style="color: red" id="orgMsg">*</span>
					</td>
				</tr>
				&lt;%&ndash;<tr>
					<td class="lgridlist">分组:</td>
					<td >
							${model.name}
					</td>
				</tr>&ndash;%&gt;
				<tr>
					<td class="lgridlist">用户分组:</td>
					<td >
						<select id="userGrpId" name="userGrpId">
							<option value="" >--请选择--</option>
							<c:forEach items="${userGrp}" var="item">
								<option value="${item.userGrpId}" ${item.userGrpId==model.userGrpId?"selected='selected'":""}>${item.name}</option>
							</c:forEach>
						</select>
					</td>
				</tr>
				<tr>
					<td class="lgridlist">用户姓名:</td>
					<td >
						<input data-dojo-type="dijit.form.ValidationTextBox" required="true" data-dojo-props="trim:true" size="40" name="userName" value="${user.userName}" data-dojo-type="dijit.form.ValidationTextBox" required="true" data-dojo-props="trim:true"/>
						<span style="color: red">*</span>
					</td>
				</tr>
		    	<tr>
			        <td class="lgridlist">用户登录名:</td>
				    <td >
						<input type="hidden" id="oldLoginName" value="${user.loginName}"/>
			             <input data-dojo-type="dijit.form.ValidationTextBox" size="40" id="loginName" name="loginName" value="${user.loginName}" data-dojo-type="dijit.form.ValidationTextBox" onblur="isLoginNameExist(this.value);"/>
						<span id="checkMsg" style="color: red">*</span>
			        </td>
			   </tr>
		    	&lt;%&ndash;<tr>
			        <td class="lgridlist">用户密码:</td>
				    <td >
			             <input data-dojo-type="dijit.form.ValidationTextBox" required="true" data-dojo-props="trim:true" name="passWord" size="40"  />
			             <span style="color: red">如需更改,请输入新密码!</span>
			        </td>
		  		</tr>
&ndash;%&gt;
				<tr>
					<td></td>
					<td >
						<input type="hidden" name="passWord" size="40" value="${user.passWord}" />
					</td>
				</tr>

			</table>
			<table class="b">
				<tr  align="center">
					<td><input id="submitButton" name="submitButton" type="submit" value="保存" /></td>
					<td><input type="button" value="返回" onclick="window.location.href='list.do'"/></td>
				</tr>
			</table>
	</mvc:form>
</fieldset>

</body>


</html>--%>
