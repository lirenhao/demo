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

insert into role (id, remark, name) values (1, '管理员角色', 'admin');
insert into role_permit (role_id, permit_id) VALUES (1, 1);
insert into role_permit (role_id, permit_id) VALUES (1, 2);
insert into role_permit (role_id, permit_id) VALUES (1, 3);
insert into role_permit (role_id, permit_id) VALUES (1, 4);
insert into role_permit (role_id, permit_id) VALUES (1, 5);
insert into role_permit (role_id, permit_id) VALUES (1, 6);

INSERT INTO org (org_id, eacq_org_id, name, online_flag, org_lev, p_org_id, status, tel, zone_code) VALUES ('00', NULL, '总机构', NULL, 0, NULL, '1', NULL, NULL);

insert into user_grp (user_grp_id, iht_flag, name, org_id) values (1, '1', 'admin', '00');
INSERT INTO user_grp_role (user_grp_id, role_id) VALUES (1, 1);

insert into user (user_id, login_name, org_id, pwd, status, user_grp_id, user_name) values (1, 'admin', '00', 'C4CA4238A0B923820DCC509A6F75849B', '1', 1, 'admin');