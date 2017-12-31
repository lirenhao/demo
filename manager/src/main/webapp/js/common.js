/**
 * 项目中统一用到的js
 * Created by lrh on 09/11/17.
 */
/**
 * 模态框隐藏后清除内容
 */
$("#myModal").on('hidden.bs.modal', function () {
    $(this).removeData('bs.modal');
});
/**
 * 删除的js
 * @param msg
 * @param url
 * @returns {boolean}
 */
function deleteClick(msg, url) {
    bootbox.confirm({
        message: msg ,
        buttons: {
            confirm: {
                label: '确定',
                className: 'btn btn-primary'
            },
            cancel: {
                label: '取消',
                className: 'btn btn-default'
            }
        },
        callback: function (result) {
            if (result) {
                $('#page').load(url);
            }
        }
    });
    return false;
}

/**
 * 提示的js
 * @param msg
 * @param url
 * @returns {boolean}
 */
function alertClick(msg) {
   bootbox.alert({
       message:msg,
       buttons:{
           ok:{
               label: '确定',
               className: 'btn btn-primary'
           }
       }
   })
    return false;
}

/**
 * 登出的js
 * @param msg
 * @param url
 * @returns {boolean}
 */
function logoutClick(msg, url) {
    bootbox.confirm({
        message: msg ,
        buttons: {
            confirm: {
                label: '确定',
                className: 'btn btn-primary'
            },
            cancel: {
                label: '取消',
                className: 'btn btn-default'
            }
        },
        callback: function (result) {
            if (result) {
                window.location.href=url;
            }
        }
    });
    return false;
}