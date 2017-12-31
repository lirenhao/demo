insert into res_type (id, name, remark) values (1, 'menu', '菜单资源');
insert into res_type (id, name, remark) values (2, 'url', 'URL资源');

insert into action (id, name, order_no, value, res_type_id) values (1, '不可见', 1, '0', 1);
insert into action (id, name, order_no, value, res_type_id) values (2, '可见', 2, '1', 1);

insert into action (id, name, order_no, value, res_type_id) values (3, '不可操作', 1, '0', 2);
insert into action (id, name, order_no, value, res_type_id) values (4, '可操作', 2, '1', 2);

insert into res (id, name, res_type_id, p_id, action, order_no) values (1, '权限管理', 1, null, null, 1);
insert into permit (id, action_id, res_id, type_id) values (1, 1, 1, 1);
insert into permit (id, action_id, res_id, type_id) values (2, 2, 1, 1);

insert into res (id, name, res_type_id, p_id, action, order_no) values (2, '资源管理', 1, 1, '/res/list', 2);
insert into permit (id, action_id, res_id, type_id) values (3, 1, 2, 1);
insert into permit (id, action_id, res_id, type_id) values (4, 2, 2, 1);

insert into res (id, name, res_type_id, p_id, action, order_no) values (3, '角色管理', 1, 1, '/role/list', 3);
insert into permit (id, action_id, res_id, type_id) values (5, 1, 3, 1);
insert into permit (id, action_id, res_id, type_id) values (6, 2, 3, 1);

insert into res (id, name, res_type_id, p_id, action, order_no) values (4, '用户管理', 1, 1, '/user/list', 4);
insert into permit (id, action_id, res_id, type_id) values (7, 1, 4, 1);
insert into permit (id, action_id, res_id, type_id) values (8, 2, 4, 1);

insert into role (id, remark, name) values (1, '管理员角色', 'admin');
insert into role_permit (role_id, permit_id) values (1, 1);
insert into role_permit (role_id, permit_id) values (1, 2);
insert into role_permit (role_id, permit_id) values (1, 3);
insert into role_permit (role_id, permit_id) values (1, 4);
insert into role_permit (role_id, permit_id) values (1, 5);
insert into role_permit (role_id, permit_id) values (1, 6);
insert into role_permit (role_id, permit_id) values (1, 7);
insert into role_permit (role_id, permit_id) values (1, 8);

insert into user (id, login_name, pass_word, status, user_name) values (1, 'admin', 'C4CA4238A0B923820DCC509A6F75849B', '1', 'admin');

insert into user_role (user_id, role_id) values (1, 1);

insert into dict_list ( dict_type, dict_name) values ( 'USER_STATUS', '用户状态');

insert into dict_item ( dict_type, dict_code, dict_name, dict_order) values ( 'USER_STATUS', '0', '停用', '1');
insert into dict_item ( dict_type, dict_code, dict_name, dict_order) values ( 'USER_STATUS', '1', '启用', '2');