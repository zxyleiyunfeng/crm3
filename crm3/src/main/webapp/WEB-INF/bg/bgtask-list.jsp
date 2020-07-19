<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta name="renderer" content="webkit|ie-comp|ie-stand">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport" content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
<meta http-equiv="Cache-Control" content="no-siteapp" />
<!--[if lt IE 9]>
<script type="text/javascript" src="lib/html5shiv.js"></script>
<script type="text/javascript" src="lib/respond.min.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="static/h-ui/css/H-ui.min.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/H-ui.admin.css" />
<link rel="stylesheet" type="text/css" href="lib/Hui-iconfont/1.0.8/iconfont.css" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/skin/default/skin.css" id="skin" />
<link rel="stylesheet" type="text/css" href="static/h-ui.admin/css/style.css" />
<!--[if IE 6]>
<script type="text/javascript" src="lib/DD_belatedPNG_0.0.8a-min.js" ></script>
<script>DD_belatedPNG.fix('*');</script>
<![endif]-->
<title>任务发布管理</title>
</head>
<body>
<nav class="breadcrumb"><i class="Hui-iconfont">&#xe67f;</i> 首页 <span class="c-gray en">&gt;</span> 办公管理 <span class="c-gray en">&gt;</span> 任务发布管理 <a class="btn btn-success radius r" style="line-height:1.6em;margin-top:3px" href="javascript:location.replace(location.href);" title="刷新" ><i class="Hui-iconfont">&#xe68f;</i></a></nav>
<div class="page-container">
    <form action="bgexaminetaskctrl/selecttask.do" method="post" id="myform-task">
	<div class="text-c"> 日期范围：
		<input type="text" autocomplete="off" value="<fmt:formatDate value="${t1.datemin }" pattern="yyyy-MM-dd"/>" onfocus="WdatePicker({ maxDate:'#F{$dp.$D(\'datemax\')||\'%y-%M-%d\'}' })" id="datemin" name="datemin" class="input-text Wdate" style="width:120px;">
		-
		<input type="text" autocomplete="off" value="<fmt:formatDate value="${t1.datemax }" pattern="yyyy-MM-dd"/>" onfocus="WdatePicker({ minDate:'#F{$dp.$D(\'datemin\')}',maxDate:'%y-%M-%d' })" id="datemax" name="datemax" class="input-text Wdate" style="width:120px;">
		<input type="text" autocomplete="off" value="${t1.taskTitle }" class="input-text" style="width:250px" placeholder="输入任务标题" id="taskTitle" name="taskTitle">
		<input type="hidden" name="pageNum" id="pageNum" value="${p.pageNum }">
		<button type="submit" class="btn btn-success radius" id="" name=""><i class="Hui-iconfont">&#xe665;</i> 搜索任务</button>
	    <button type="reset" class="btn btn-success radius" id="" name="" class="btn-task"><i class="Hui-iconfont">&#xe68f;</i> 重置</button>
	</div>
	</form>
	<div class="cl pd-5 bg-1 bk-gray mt-20"> <span class="l"><a href="javascript:;" onclick="datadel()" class="btn btn-danger radius"><i class="Hui-iconfont">&#xe6e2;</i> 批量删除</a>
	<a href="javascript:;" onclick="member_add('发布任务','bgexaminetaskctrl/goaddtask.do','','610')" class="btn btn-primary radius"><i class="Hui-iconfont">&#xe600;</i> 发布任务</a></span>
	<span class="r">共有数据：<strong>${p.total }</strong> 条</span> </div>
	<div class="mt-20">
	<p class="btn btn-primary radius">已发布任务</p>
	<form action="bgexaminetaskctrl/deletetaskall.do" method="post" id="myform2">
	<table class="table table-border table-bordered table-hover table-bg table-sort">
		<thead>
			<tr class="text-c">
				<th width="25"><input type="checkbox" name="" value=""></th>
				<th width="50">任务编号</th>
				<th width="50">任务标题</th>
				<th width="100">任务具体内容</th>
				<th width="50">任务发布人</th>
				<th width="70">考核指标</th>
				<th width="70">任务开始时间</th>
				<th width="70">任务结束时间</th>
				<th width="50">公司编号</th>
				<th width="70">最后修改时间</th>
				<th width="80">操作</th>
			</tr>
		</thead>
		<tbody>
		    <c:forEach items="${p.list }" var="task">
			<tr class="text-c">
				<td><input type="checkbox" value="${task.taskId }" name="ids"></td>
				<td>${task.taskId }</td>
				<td><u style="cursor:pointer" class="text-primary" onclick="member_show('张三','member-show.html','10001','360','400')">${task.taskTitle }</u></td>
				<td>${task.taskSpecificContent }</td>
				<td>${task.taskPublishPerson }</td>
				<td>${task.examineTarget }</td>
				<td class="text-c">
				<fmt:formatDate value="${task.taskBeginTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
				<fmt:formatDate value="${task.taskEndTime }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="td-status">${task.companyId }</td>
				<td class="td-status">
				<fmt:formatDate value="${task.lastModifyDate }" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td class="td-manage">
				<a title="编辑" href="javascript:;" onclick="member_edit('编辑任务','bgexaminetaskctrl/goaddtask.do','${task.taskId }','','610')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6df;</i></a>
				<a title="删除" href="javascript:;" onclick="member_del(this,'${task.taskId }')" class="ml-5" style="text-decoration:none"><i class="Hui-iconfont">&#xe6e2;</i></a></td>
			</tr>
			</c:forEach>
		</tbody>
	</table>
	</form>
	</div>
	
	<div style="float: left;margin-bottom:10px;" class="dataTables_info" role="status" aria-live="polite">当前第${p.pageNum }/${p.pages }页，共${p.total }条</div>
	<div style="float: right;" class="paginate_button paging_simple_numbers" id="DataTables_Table_paginate">
	<a class="paginate_button" aria-controls="DataTables" id="DataTables_Table_previous" href="javascript:void(0)" onclick="gopage(${p.navigateFirstPage })">首页</a>
	<a class="paginate_button previous" aria-controls="DataTables" id="DataTables_Table_previous" href="javascript:void(0)" onclick="gopage(${p.prePage })">上一页</a>
	<a class="paginate_button next" aria-controls="DataTables" id="DataTables_Table_next" href="javascript:void(0)" onclick="gopage(${p.nextPage })">下一页</a>
	<a class="paginate_button" aria-controls="DataTables" id="DataTables_Table_previous" href="javascript:void(0)" onclick="gopage(${p.navigateLastPage })">尾页</a>
	</div>
	
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="lib/jquery/1.9.1/jquery.min.js"></script> 
<script type="text/javascript" src="lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="static/h-ui/js/H-ui.min.js"></script> 
<script type="text/javascript" src="static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="<%=basePath%>lib/My97DatePicker/4.8/WdatePicker.js"></script> 
<script type="text/javascript" src="<%=basePath%>lib/datatables/1.10.0/jquery.dataTables.min.js"></script> 
<script type="text/javascript" src="<%=basePath%>lib/laypage/1.2/laypage.js"></script>
<script type="text/javascript">
$(function(){
	$('.table-sort').dataTable({
		"aaSorting": [[ 1, "desc" ]],//默认第几个排序
		"bStateSave": true,//状态保存
		"aoColumnDefs": [
		  //{"bVisible": false, "aTargets": [ 3 ]} //控制列的隐藏显示
		  {"orderable":false,"aTargets":[0,10]}// 制定列不参与排序
		],
		paging:false,
		
	});
	$("#DataTables_Table_0_info").hide();
	$("#DataTables_Table_0_filter").hide();
	
});
/*任务-添加*/
function member_add(title,url,w,h){
	layer_show(title,url,w,h);
}
/*任务-查看*/
function member_show(title,url,id,w,h){
	layer_show(title,url,w,h);
}
/*任务-编辑*/
function member_edit(title,url,id,w,h){
    url=url+"?taskId="+id;
	layer_show(title,url,w,h);
}
/*任务-删除*/
function member_del(obj,id){
	layer.confirm('确认要删除吗？',function(index){
		$.ajax({
			type: 'POST',
			url: 'bgexaminetaskctrl/deletetask.do',
			data: "taskId="+id,
			dataType: 'json',
			success: function(data){
				$(obj).parents("tr").remove();
				layer.msg('已删除!',{icon:1,time:1000});
			},
			error:function(data) {
				console.log(data.msg);
			},
		});		
	});
}
//分页
function gopage(pageNum){
    $("#pageNum").val(pageNum);
    $("#myform-task").submit();
}

//批量删除
function datadel(){
    if($("input[name='ids']:checked").length>=1){
        layer.confirm('确认要删除这些数据吗？',function(index){
        $("#myform2").submit();
        });
    }else{
        layer.msg('请至少选择一条!',{icon:5,time:1000});
    }
}
//表单提交后重置
$("form").on("click", "button[type='reset']", function(){
    var $inputs = $("form").find("input[type='text']");
    for(var i = 0; i < $inputs.length;i++){
        $($inputs[i]).val("");
    }
    return false;
});


</script> 
</body>
</html>