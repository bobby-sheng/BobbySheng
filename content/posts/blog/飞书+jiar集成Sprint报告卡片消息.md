---
title: "飞书+jiar集成|Sprint报告卡片消息"
date: 2024-05-16
lastmod: 2024-05-16
tags:
  - Python
keywords:
  - Python
description: "飞书+jiar集成 Sprint报告卡片消息"
cover:
    image: "img/jirafeishu001.png"
---
# 背景

当前公司研发流程均在jira项目管理平台流转，每2周一个Sprint冲刺，Jira中不带具体的数据统计与人员在此Sprint中的完成度，每次Sprint冲刺结束后无法直观的看到人员的投入产出比，于是就想做一个Jira数据收集。由于公司通讯主要使用飞书，就结合了飞书卡片通知发送消息给到研发群组，供大家对上一个Sprint的投入产出与完成的工单量进行一个复盘。

# 需求分析

1. 收集当前活跃的Sprint冲刺下的所有工单
2. 统计工单数量，并且统计工单类型
3. 统计人员负责完成与未完成工单数量与百分比
4. 使用飞书机器人发送飞书卡片消息给到群组

# 需求调研

## Jira收集数据方法

在python中可以使用JIRA第三方库对Jira进行操作，通过GPT我们可知道JIRA的可操作情况
![img.png](../../../../img/feishujira007.png)
通过回答我们可知道是可以操作Sprint管理，熟悉JIRA这个包的知道，Sprint管理是可以获取到当前Sprint所有工单的key，通过key可以获取到这个工单的详情信息，有负责人、工单类型、优先级等数据。

## 如何发送飞书卡片消息

通过飞书应用机器人可调用飞书开发API发送消息接口，此接口可发送消息卡片类型的数据。消息卡片的数据需要在飞书消息卡片搭建中自行搭建，然后复制出卡片源代码给到消息接口发送即可

飞书卡片搭建地址：https://open.feishu.cn/cardkit

![img.png](../../../../img/feishujira001.png)
飞书发送消息API：https://open.feishu.cn/document/ukTMukTMukTM/uYzM3QjL2MzN04iNzcDN/send-message-card/send-messages-using-card-json-data

![img.png](../../../../img/feishujira002.png)
## 流程简介

通过python获取jira中需要的数据，通过python填充到卡片源代码，调用飞书发送消息接口，发送消息

# 实现步骤

## jira数据收集

1. jira登录 | jira_clent.py

```Bash
from jira import JIRA
from units.get_config_data import get_config_yaml_data
import jsonpath


def get_jira_client():
    json_data = get_config_yaml_data()
    server = jsonpath.jsonpath(json_data, "$.jira.url")[0]
    username = jsonpath.jsonpath(json_data, "$.jira.username")[0]
    password = jsonpath.jsonpath(json_data, "$.jira.password")[0]

    jira_cline = JIRA(server=server, basic_auth=(username, password))
    return jira_cline


if __name__ == '__main__':
    print(get_jira_client().search_issues(
        'project = INET AND issuetype = 故障 AND status in ("To Do", 开发中) AND assignee in (awen.cheng)',
        maxResults=-1))
```

1. 获取当前项目活跃的Sprint | jira_sprint_msg.py

```Bash
#!/usr/bin/env python3.10.6
# -*- coding: utf-8 -*-
# Author: Bobby Sheng <Bobby@sky-cloud.net>
import jsonpath
import copy

from units.get_config_data import get_config_yaml_data
from units.jira_clent import get_jira_client
from units.log_control import INFO, ERROR

PROJECT_KEY = 'INET'
EXCLUDED_SPRINT_ID = 61


def get_user_id(name_data):
    receive_id_data = jsonpath.jsonpath(get_config_yaml_data(), "$.userInfo")[0]

    receive_id = [i.get("user_id") for i in receive_id_data if str(i.get("username")) == str(name_data)][0]
    return receive_id


def get_sprint_issues(project_key: str):
    """
    获取项目下活跃的sprint
    :param project_key: 项目key
    :return: 活跃sprint的ID，如果没有找到则返回None
    """
    try:
        boards = get_jira_client().boards(projectKeyOrID=project_key)
    except Exception as e:
        ERROR.logger.error(f"获取boards时发生错误: {e}")
        return None

    board_id = boards[0].id if boards else None
    if board_id:
        try:
            active_sprints = get_jira_client().sprints(board_id, state='active')
        except Exception as e:
            ERROR.logger.error(f"获取sprints时发生错误: {e}")
            return None

        if not active_sprints:
            ERROR.logger.error("没有找到活跃的sprint。")
            return None

        for sprint in active_sprints:
            if sprint.state == "ACTIVE" and sprint.id != EXCLUDED_SPRINT_ID:
                return sprint.id, sprint.name
    else:
        ERROR.logger.error("没有找到符合条件的活跃sprint。")

    return None


def get_backlog_issues(project_key: str):
    """
    获取项目下指定sprint的backlog issues
    :param project_key: 项目key
    :return:
    """
    sprint_info_list = []
    try:
        sprint_id, sprint_name = get_sprint_issues(project_key)
        if not sprint_id:
            ERROR.logger.error("无法获取sprint ID。")
            return

        # 验证project_key和sprint_id的格式，这里假设它们都是符合一定规则的字符串
        # 这个验证可以根据实际情况调整
        if not isinstance(project_key, str) or not isinstance(sprint_id, int):
            ERROR.logger.error("项目键或sprint ID格式不正确。")
            return

        jql_str = f'project = {project_key} AND Sprint = {sprint_id} ORDER BY created DESC, 等级 ASC'
        backlog_issues = get_jira_client().search_issues(jql_str, maxResults=1000)

        count = 1
        for issue in backlog_issues:
            sprint_info = print_issue_info(issue)
            sprint_info_list.append(sprint_info)
            count += 1

        INFO.logger.info(f"共打印了 {count} 个事务。")
        return sprint_info_list, sprint_name
    except Exception as e:
        ERROR.logger.error(f"获取backlog issues时发生错误: {e}")


def print_issue_info(issue):
    """
    打印issue信息
    """
    sprint_info_data = {
        "key": issue.key,
        "issue_type": issue.fields.issuetype,
        "summary": issue.fields.summary,
        "assignee": issue.fields.assignee,
        "reporter": issue.fields.reporter,
        "priority": issue.fields.priority,
        "status": issue.fields.status,
        "customfield_10106": issue.fields.customfield_10106,
    }
    return sprint_info_data


def job_completion_rate(sprint_info_list: list):
    if not isinstance(sprint_info_list, list):
        raise ValueError("输入参数必须是一个列表")
    story_list, story_list_done, story_list_fail = [], [], []
    task_list, task_list_done, task_list_fail = [], [], []
    bug_list, bug_list_done, bug_list_fail = [], [], []

    completed_statuses = {"完成", "测试中", "暂不处理", "测试通过"}
    INFO.logger.info(f"正在获取项目的sprint type信息...")
    for i in sprint_info_list:
        if str(i.get("issue_type")) == "故事":
            story_list.append(i)
            if str(i.get("status")) in completed_statuses:
                story_list_done.append(i)
            else:
                story_list_fail.append(i)
        elif str(i.get("issue_type")) == "子任务":
            task_list.append(i)
            if str(i.get("status")) in completed_statuses:
                task_list_done.append(i)
            else:
                task_list_fail.append(i)
        else:
            bug_list.append(i)
            if str(i.get("status")) in completed_statuses:
                bug_list_done.append(i)
            else:
                bug_list_fail.append(i)
    all_done = len(bug_list_done) + len(task_list_done) + len(story_list_done)

    completion_rate = {
        "len_story": len(story_list),
        "len_task": len(task_list),
        "len_bug": len(bug_list),
        "len_all": len(sprint_info_list),
        "story_handle": {
            "done": len(story_list_done),
            "fail": len(story_list_fail),
            "rate": round((len(story_list_done) / len(story_list)) * 100, 2)
        },
        "task_handle": {
            "done": len(task_list_done),
            "fail": len(task_list_fail),
            "rate": round((len(task_list_done) / len(task_list)) * 100, 2)

        },
        "bug_handle": {
            "done": len(bug_list_done),
            "fail": len(bug_list_fail),
            "rate": round((len(bug_list_done) / len(bug_list)) * 100, 2)
        },
        "all_handle": {
            "done": all_done,
            "fail": len(bug_list_fail) + len(task_list_fail) + len(story_list_fail),
            "rate": round((all_done / len(sprint_info_list)) * 100, 2)

        }
    }
    return completion_rate


def user_msg_data(sprint_info_list: list):
    """
    人员的数据统计，返回卡片的json数据
    :param sprint_info_list: 包含任务信息的列表，每个元素是字典类型
    """
    if not isinstance(sprint_info_list, list):
        raise ValueError("输入参数必须是一个列表")

    if not all(isinstance(item, dict) for item in sprint_info_list):
        raise ValueError("列表中的每个元素都必须是一个字典")
    data_msg = {卡片中一列的代码，我这里做的是循环填充生成的} #TODO
    issue_types = ['故事', '故障', '子任务', '任务', '故事点']
    issue_status = ["完成", "测试中", "暂不处理", "测试通过", "待办", "产品验收中", "开发中"]
    done_status = {"完成", "测试中", "暂不处理", "测试通过", "产品验收中"}
    issue_types_dones = ['故事完成数', '故障完成数', '子任务完成数', '任务完成数']
    type_counts = {t: 0 for t in issue_types}  # 初始化计数
    status_counts = {t: 0 for t in issue_status}  # 初始化计数
    issue_types_counts = {t: 0 for t in issue_types_dones}  # 初始化计数
    user_counts = {}
    data_msg_list = []

    for user_data in sprint_info_list:
        assignee = user_data.get("assignee")
        if assignee is not None:
            if assignee not in user_counts:
                user_counts[assignee] = {'total': 0, **type_counts, **status_counts, **issue_types_counts}
            user_counts[assignee]['total'] += 1
            if user_data.get('customfield_10106'):
                user_counts[assignee]['故事点'] += float(user_data.get('customfield_10106'))
            for issue_type in issue_types:
                if str(user_data.get('issue_type')) == issue_type:
                    user_counts[assignee][issue_type] += 1
            for issue_statu in issue_status:
                if str(user_data.get('status')) == issue_statu:
                    user_counts[assignee][issue_statu] += 1
            for issue_types_done in issue_types_dones:
                issue_type_str = issue_types_done[:-3]
                if str(user_data.get('issue_type')) == issue_type_str and str(user_data.get('status')) in done_status:
                    user_counts[assignee][issue_types_done] += 1

        else:
            ERROR.logger.error("assignee字段为空")
    # 输出结果 one {'total': 22, '故事': 6, '故障': 6, '子任务': 10}
    for data_key, data_value in user_counts.items():
        count = 0
        for k, v in data_value.items():
            if k in done_status:
                count += v
        # print(data_key, data_value, count)
        task_num = int(data_value.get('任务')) + int(data_value.get('子任务'))
        done_task_num = int(data_value.get('子任务完成数')) + int(data_value.get('任务完成数'))
        userid = get_user_id(data_key)
        data_msg_copy = copy.deepcopy(data_msg)
        data_msg_copy["columns"][0]["elements"][0]["persons"][0]["id"] = userid
        data_msg_copy["columns"][1]["elements"][0]["columns"][0]["elements"][0]["text"][
            "content"] = f"{data_value.get('故事完成数')}/{data_value.get('故事')}个"
        data_msg_copy["columns"][2]["elements"][0]["columns"][0]["elements"][0]["text"][
            "content"] = f"{done_task_num}/{task_num}个"
        data_msg_copy["columns"][3]["elements"][0]["columns"][0]["elements"][0]["text"][
            "content"] = f"{data_value.get('故障完成数')}/{data_value.get('故障')}个"
        data_msg_copy["columns"][4]["elements"][0]["columns"][0]["elements"][0]["text"][
            "content"] = f"{data_value.get('故事点')}个"
        data_msg_copy["columns"][5]["elements"][0][
            "content"] = f"({int(count)}/{int(data_value.get('total'))}) <font color='red'>{round((int(count) / int(data_value.get('total'))) * 100, 2)}%</font>"
        data_msg_list.append(data_msg_copy)
    return data_msg_list
```

## 飞书API发送

1. 飞书API认证

```Bash
#!/usr/bin/env python3.10.6
# -*- coding: utf-8 -*-
# Author: Bobby Sheng <Bobby@sky-cloud.net>
from units.get_config_data import get_config_yaml_data
import requests
import jsonpath

Config = get_config_yaml_data()


def tenant_access_token():
    """获取引用tenant_access_token
    :return: tenant_access_token
    """
    data = {"app_id": jsonpath.jsonpath(Config, "$.feishu.app_id")[0],
            "app_secret": jsonpath.jsonpath(Config, "$.feishu.app_secret")[0]}

    res = requests.post(jsonpath.jsonpath(Config, "$.feishu.webhook_token")[0], data=data).json()
    headers = {
        'Content-Type': 'application/json',
        'Authorization': "Bearer " + res["app_access_token"]
    }
    return headers
```

1. 飞书卡片消息发送

```Bash
#!/usr/bin/env python3.10.6
# -*- coding: utf-8 -*-
# Author: Bobby Sheng <Bobby@sky-cloud.net>
import requests
import json
import time
import jsonpath

from units.get_config_data import get_config_yaml_data
from units.log_control import INFO
from feushu_api.feishu_login import tenant_access_token
from jira_business.jira_sprint_msg import user_msg_data, get_backlog_issues, job_completion_rate

data_msg = {卡片源代码} #TODO


# ${sprint}  ${ALL} ${story_all} ${bug_all} ${task_all} ${story_fail} ${story_done} ${story_rate} ${bug_fail} ${bug_done} ${bug_rate}
# ${task_fail} ${task_done} ${task_rate} ${all_fail} ${all_done} ${all_rate}

def send_sprint_msg():
    sprint_info_list, sprint_name = get_backlog_issues('INET')

    # # 开发者数据统计
    data_msg_list = user_msg_data(sprint_info_list)

    c.get("i18n_elements").get('zh_cn').extend(data_msg_list)

    # 工单数据统计
    job_data = job_completion_rate(sprint_info_list)

    c1 = json.dumps(c).replace("${sprint}", sprint_name).replace("${ALL}", str(job_data["len_all"])).replace(
        "${story_all}",
        str(job_data[
                "len_story"])) \
        .replace("${bug_all}", str(job_data["len_bug"])).replace("${task_all}", str(job_data["len_task"])). \
        replace("${story_fail}", str(job_data["story_handle"]["fail"])).replace("${story_done}",
                                                                                str(job_data["story_handle"]["done"])). \
        replace("${story_rate}", str(job_data["story_handle"]["rate"])).replace("${bug_fail}",
                                                                                str(job_data["bug_handle"]["fail"])). \
        replace("${bug_done}", str(job_data["bug_handle"]["done"])).replace("${bug_rate}",
                                                                            str(job_data["bug_handle"]["rate"])). \
        replace("${task_fail}", str(job_data["task_handle"]["fail"])).replace("${task_done}",
                                                                              str(job_data["task_handle"]["done"])). \
        replace("${task_rate}", str(job_data["task_handle"]["rate"])).replace("${all_fail}",
                                                                              str(job_data["all_handle"]["fail"])). \
        replace("${all_done}", str(job_data["all_handle"]["done"])).replace("${all_rate}",
                                                                            str(job_data["all_handle"]["rate"]))

    headers = tenant_access_token()
    rich_text = {
        "receive_id": "6b9eab87",
        "msg_type": "interactive",
        "content": c1
    }
    # oc_17703b85be608b568b1fed1c3a2f3110 测试群
    # oc_672137dedd6b9104cdf1d99d5bdea47a 研发群
    INFO.logger.info(f"消息接受者：6b9eab87")
    post_data = json.dumps(rich_text)
    response = requests.post(
        jsonpath.jsonpath(get_config_yaml_data(), "$.feishu.webhook")[0],
        headers=headers,
        data=post_data,
        verify=False
    )
    result = response.json()
    INFO.logger.info(f"发送消息接返回{result}")
    if result.get('code') != 0:
        time_now = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime(time.time()))
        result_msg = result['errmsg'] if result.get('errmsg', False) else '未知异常'
        error_data = {
            "msgtype": "text",
            "text": {
                "content": f"[注意-自动通知]飞书机器人消息发送失败，时间：{time_now}，"
                           f"原因：{result_msg}，请及时跟进，谢谢!"
            },
            "at": {
                "isAtAll": False
            }
        }
        INFO.logger.error("消息发送失败，自动通知：%s", error_data)
        requests.post(jsonpath.jsonpath(get_config_yaml_data(), "$.feishu.webhook")[0], headers=headers,
                      data=json.dumps(error_data))


if __name__ == '__main__':
    send_sprint_msg()
```

1. 代码结构

![img.png](../../../../img/feishujira003.png)
# 效果展示

![img.png](../../../../img/feishujira004.png)
![img.png](../../../../img/feishujira005.png)
![img.png](../../../../img/feishujira006.png)
# 总结

空闲时间编写，没太多时间去构思代码设计，主要以实现功能为主，代码写的简单粗暴。更多的是提供一种思路。