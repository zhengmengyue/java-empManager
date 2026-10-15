<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="net.empManager.service.EmployeeService, java.util.List, net.empManager.domain.Employee"%>
<%
  if (request.getAttribute("allEmployees") == null) {
    List allEmps = new EmployeeService().findAll();
    request.setAttribute("allEmployees", allEmps);
  }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>查询员工 · 员工信息管理系统</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { background: #f0f4ff; color: #1e293b; font-family: 'Segoe UI','PingFang SC','Microsoft YaHei',sans-serif; min-height: 100vh; }
  .navbar {
    height: 64px; background: #ffffff;
    border-bottom: 1px solid #e8eaf0;
    display: flex; align-items: center; justify-content: space-between;
    padding: 0 40px; position: sticky; top: 0; z-index: 100;
    box-shadow: 0 1px 8px rgba(99,102,241,0.08);
  }
  .nav-brand { display: flex; align-items: center; gap: 12px; }
  .nav-brand .icon { width: 36px; height: 36px; background: linear-gradient(135deg,#6366f1,#8b5cf6); border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 18px; }
  .nav-brand span { font-size: 17px; font-weight: 600; color: #1e293b; }
  .nav-right { display: flex; align-items: center; gap: 20px; }
  .nav-user { font-size: 14px; color: #64748b; }
  .nav-user strong { color: #6366f1; }
  .btn-back { padding: 7px 18px; border-radius: 8px; font-size: 13px; background: #f1f5f9; color: #64748b; border: 1px solid #e2e8f0; text-decoration: none; transition: background .2s; }
  .btn-back:hover { background: #e2e8f0; }
  .main { padding: 48px 40px; display: flex; flex-direction: column; align-items: center; }

  .search-card {
    width: 100%; max-width: 660px;
    background: #ffffff; border: 1px solid #e8eaf0;
    border-radius: 20px; padding: 36px 40px;
    box-shadow: 0 8px 32px rgba(99,102,241,0.10); margin-bottom: 36px;
  }
  .search-card h2 { font-size: 20px; font-weight: 700; color: #1e293b; margin-bottom: 6px; }
  .search-card p  { font-size: 13px; color: #94a3b8; margin-bottom: 24px; }

  .search-tabs { display: flex; gap: 0; margin-bottom: 20px; border: 1px solid #e2e8f0; border-radius: 10px; overflow: hidden; }
  .search-tab {
    flex: 1; height: 40px; display: flex; align-items: center; justify-content: center;
    font-size: 14px; font-weight: 500; color: #64748b; cursor: pointer;
    background: #f8fafc; border: none; transition: all .18s;
  }
  .search-tab.active { background: linear-gradient(135deg,#6366f1,#8b5cf6); color: #fff; }

  .search-panel { display: none; }
  .search-panel.active { display: block; }
  .search-row { display: flex; gap: 12px; }
  .search-row input {
    flex: 1; height: 46px; padding: 0 16px;
    background: #f8fafc; border: 1px solid #e2e8f0;
    border-radius: 10px; color: #1e293b; font-size: 14px;
    outline: none; transition: border-color .2s, box-shadow .2s;
  }
  .search-row input:focus { border-color: #6366f1; box-shadow: 0 0 0 3px rgba(99,102,241,0.2); }
  .btn-search {
    height: 46px; padding: 0 28px; background: linear-gradient(135deg,#6366f1,#8b5cf6);
    border: none; border-radius: 10px; color: #fff; font-size: 15px; font-weight: 600;
    cursor: pointer; transition: opacity .2s; box-shadow: 0 4px 14px rgba(99,102,241,0.35);
    white-space: nowrap;
  }
  .btn-search:hover { opacity: .88; }

  .result-card {
    width: 100%; max-width: 900px;
    background: #ffffff; border: 1px solid #e8eaf0;
    border-radius: 16px; overflow: hidden;
    box-shadow: 0 2px 12px rgba(99,102,241,0.07);
  }
  .result-header {
    padding: 18px 24px; border-bottom: 1px solid #f1f5f9;
    font-size: 14px; font-weight: 600; color: #1e293b;
    display: flex; align-items: center; gap: 10px;
  }
  .result-count { font-size: 12px; font-weight: 500; color: #fff; background: #6366f1; padding: 2px 8px; border-radius: 20px; }
  table { width: 100%; border-collapse: collapse; }
  colgroup col:nth-child(1) { width: 120px; }
  colgroup col:nth-child(2) { width: 120px; }
  colgroup col:nth-child(3) { width: 180px; }
  colgroup col:nth-child(4) { width: 90px; }
  colgroup col:nth-child(5) { width: 130px; }
  colgroup col:nth-child(6) { width: 160px; }
  th { padding: 14px 20px; text-align: left; font-size: 12px; color: #94a3b8; font-weight: 600; letter-spacing: .8px; text-transform: uppercase; background: #f8fafc; }
  td { padding: 16px 20px; font-size: 14px; color: #334155; border-top: 1px solid #f1f5f9; white-space: nowrap; }
  tbody tr { transition: background .15s; }
  tbody tr:hover { background: #f5f3ff; }
  .badge { display: inline-block; padding: 3px 10px; border-radius: 20px; font-size: 12px; font-weight: 500; }
  .badge-tech  { background: rgba(99,102,241,0.15); color: #6366f1; }
  .badge-hr    { background: rgba(16,185,129,0.15);  color: #059669; }
  .badge-fin   { background: rgba(245,158,11,0.15);  color: #d97706; }
  .badge-mkt   { background: rgba(59,130,246,0.15);  color: #2563eb; }
  .badge-sales { background: rgba(236,72,153,0.15);  color: #db2777; }
  .badge-ops   { background: rgba(20,184,166,0.15);  color: #0d9488; }
  .badge-other { background: rgba(148,163,184,0.15); color: #64748b; }
  .action-link { display: inline-flex; align-items: center; justify-content: center; width: 64px; padding: 5px 0; border-radius: 7px; font-size: 13px; text-decoration: none; transition: background .15s; margin-right: 6px; white-space: nowrap; }
  .action-edit   { color: #6366f1; background: #ede9fe; }
  .action-edit:hover { background: #ddd6fe; }
  .action-delete { color: #ef4444; background: #fee2e2; }
  .action-delete:hover { background: #fecaca; }
  .empty { text-align: center; padding: 50px; color: #94a3b8; font-size: 14px; }
</style>
</head>
<body>
<nav class="navbar">
  <div class="nav-brand">
    <div class="icon">👥</div>
    <span>员工信息管理系统</span>
  </div>
  <div class="nav-right">
    <span class="nav-user">欢迎，<strong>${sessionScope.user.username}</strong></span>
    <a href="FindAllEmployeeServlet" class="btn-back">← 返回列表</a>
  </div>
</nav>

<div class="main">
  <div class="search-card">
    <h2>查询员工</h2>
    <p>支持按工号精确查询，或按姓名查询（自动列出所有同名员工）</p>

    <div class="search-tabs">
      <button class="search-tab active" onclick="switchTab('empId', this)">🔢 按工号查询</button>
      <button class="search-tab"        onclick="switchTab('name',  this)">👤 按姓名查询</button>
      <button class="search-tab"        onclick="switchTab('dept',  this)">🏢 按部门查询</button>
    </div>

    <div id="panel-empId" class="search-panel active">
      <form action="FindByEmpIdServlet" method="post">
        <div class="search-row">
          <input type="text" name="empId" placeholder="请输入员工工号，如：E001"
                 value="${searchEmpId}">
          <button type="submit" class="btn-search">查询</button>
        </div>
      </form>
    </div>

    <div id="panel-name" class="search-panel">
      <form action="FindByNameServlet" method="post">
        <div class="search-row">
          <input type="text" name="name" placeholder="请输入员工姓名"
                 value="${searchName}">
          <button type="submit" class="btn-search">查询</button>
        </div>
      </form>
    </div>

    <div id="panel-dept" class="search-panel">
      <div class="search-row">
        <select id="deptSelect" onchange="filterByDept()" style="flex:1;height:46px;padding:0 14px;background:#f8fafc;border:1px solid #e2e8f0;border-radius:10px;color:#1e293b;font-size:14px;outline:none;appearance:none;">
          <option value="">-- 请选择部门 --</option>
          <option value="技术部">技术部</option>
          <option value="人事部">人事部</option>
          <option value="财务部">财务部</option>
          <option value="市场部">市场部</option>
          <option value="销售部">销售部</option>
          <option value="运营部">运营部</option>
        </select>
      </div>
      <div id="dept-error" style="display:none;color:#ef4444;font-size:14px;margin-top:12px;">请选择部门</div>
    </div>
  </div>

  <div class="result-card">
    <div class="result-header">
      查询结果
    </div>
    <table>
      <colgroup><col><col><col><col><col><col></colgroup>
      <thead>
        <tr><th>工号</th><th>姓名</th><th>电子邮箱</th><th>部门</th><th>出生日期</th><th>操作</th></tr>
      </thead>
      <tbody>
        <%-- 姓名查询结果（多条）--%>
        <c:if test="${not empty employees}">
          <c:forEach var="emp" items="${employees}">
          <tr>
            <td><span style="color:#6366f1;font-weight:600;">${emp.empId}</span></td>
            <td>${emp.name}</td>
            <td style="color:#94a3b8;">${emp.email}</td>
            <td>
              <c:choose>
                <c:when test="${emp.department=='技术部'}"><span class="badge badge-tech">${emp.department}</span></c:when>
                <c:when test="${emp.department=='人事部'}"><span class="badge badge-hr">${emp.department}</span></c:when>
                <c:when test="${emp.department=='财务部'}"><span class="badge badge-fin">${emp.department}</span></c:when>
                <c:when test="${emp.department=='市场部'}"><span class="badge badge-mkt">${emp.department}</span></c:when>
                <c:when test="${emp.department=='销售部'}"><span class="badge badge-sales">${emp.department}</span></c:when>
                <c:when test="${emp.department=='运营部'}"><span class="badge badge-ops">${emp.department}</span></c:when>
                <c:otherwise><span class="badge badge-other">${emp.department}</span></c:otherwise>
              </c:choose>
            </td>
            <td style="color:#94a3b8;">${emp.birthday}</td>
            <td>
              <a href="FindByIdEmployeeServlet?id=${emp.id}" class="action-link action-edit">✏ 修改</a>
              <a href="DeleteEmployeeServlet?id=${emp.id}" class="action-link action-delete"
                 onclick="return confirm('确定删除员工 ${emp.name} 吗？')">✕ 删除</a>
            </td>
          </tr>
          </c:forEach>
        </c:if>
        <%-- 工号查询结果（单条）--%>
        <c:if test="${not empty employee and empty employees}">
          <tr>
            <td><span style="color:#6366f1;font-weight:600;">${employee.empId}</span></td>
            <td>${employee.name}</td>
            <td style="color:#94a3b8;">${employee.email}</td>
            <td>
              <c:choose>
                <c:when test="${employee.department=='技术部'}"><span class="badge badge-tech">${employee.department}</span></c:when>
                <c:when test="${employee.department=='人事部'}"><span class="badge badge-hr">${employee.department}</span></c:when>
                <c:when test="${employee.department=='财务部'}"><span class="badge badge-fin">${employee.department}</span></c:when>
                <c:when test="${employee.department=='市场部'}"><span class="badge badge-mkt">${employee.department}</span></c:when>
                <c:when test="${employee.department=='销售部'}"><span class="badge badge-sales">${employee.department}</span></c:when>
                <c:when test="${employee.department=='运营部'}"><span class="badge badge-ops">${employee.department}</span></c:when>
                <c:otherwise><span class="badge badge-other">${employee.department}</span></c:otherwise>
              </c:choose>
            </td>
            <td style="color:#94a3b8;">${employee.birthday}</td>
            <td>
              <a href="FindByIdEmployeeServlet?id=${employee.id}" class="action-link action-edit">✏ 修改</a>
              <a href="DeleteEmployeeServlet?id=${employee.id}" class="action-link action-delete"
                 onclick="return confirm('确定删除员工 ${employee.name} 吗？')">✕ 删除</a>
            </td>
          </tr>
        </c:if>
        <%-- 无结果 --%>
        <c:if test="${empty employees and empty employee and empty searchName and empty searchEmpId}">
          <tr><td colspan="6" class="empty">请输入查询条件进行搜索</td></tr>
        </c:if>
        <%-- 工号查询无结果 --%>
        <c:if test="${not empty empIdError}">
          <tr><td colspan="6" class="empty" style="color:#ef4444;">${empIdError}</td></tr>
        </c:if>
        <%-- 姓名查询无结果 --%>
        <c:if test="${not empty nameError}">
          <tr><td colspan="6" class="empty" style="color:#ef4444;">${nameError}</td></tr>
        </c:if>
        <%-- 部门查询结果（JS内存过滤，初始隐藏）--%>
        <c:forEach var="emp" items="${allEmployees}">
        <tr class="dept-row" data-dept="${emp.department}" style="display:none;">
          <td><span style="color:#6366f1;font-weight:600;">${emp.empId}</span></td>
          <td>${emp.name}</td>
          <td style="color:#94a3b8;">${emp.email}</td>
          <td>
            <c:choose>
              <c:when test="${emp.department=='技术部'}"><span class="badge badge-tech">${emp.department}</span></c:when>
              <c:when test="${emp.department=='人事部'}"><span class="badge badge-hr">${emp.department}</span></c:when>
              <c:when test="${emp.department=='财务部'}"><span class="badge badge-fin">${emp.department}</span></c:when>
              <c:when test="${emp.department=='市场部'}"><span class="badge badge-mkt">${emp.department}</span></c:when>
              <c:when test="${emp.department=='销售部'}"><span class="badge badge-sales">${emp.department}</span></c:when>
              <c:when test="${emp.department=='运营部'}"><span class="badge badge-ops">${emp.department}</span></c:when>
              <c:otherwise><span class="badge badge-other">${emp.department}</span></c:otherwise>
            </c:choose>
          </td>
          <td style="color:#94a3b8;">${emp.birthday}</td>
          <td>
            <a href="FindByIdEmployeeServlet?id=${emp.id}" class="action-link action-edit">✏ 修改</a>
            <a href="DeleteEmployeeServlet?id=${emp.id}" class="action-link action-delete"
               onclick="return confirm('确定删除员工 ${emp.name} 吗？')">&#x2715; 删除</a>
          </td>
        </tr>
        </c:forEach>
        <%-- 部门无结果提示行 --%>
        <tr id="dept-empty-row" style="display:none;"><td colspan="6" class="empty" style="color:#ef4444;">请选择部门</td></tr>
      </tbody>
    </table>
  </div>
</div>

<script>
function filterByDept() {
  var dept = document.getElementById('deptSelect').value;
  var deptRows = document.querySelectorAll('tr.dept-row');
  var emptyRow = document.getElementById('dept-empty-row');
  // 先隐藏其他查询结果行
  document.querySelectorAll('tbody tr:not(.dept-row):not(#dept-empty-row)').forEach(function(tr) {
    tr.style.display = 'none';
  });
  if (!dept) {
    deptRows.forEach(function(tr) { tr.style.display = 'none'; });
    emptyRow.style.display = '';
    return;
  }
  emptyRow.style.display = 'none';
  var count = 0;
  deptRows.forEach(function(tr) {
    if (tr.dataset.dept === dept) { tr.style.display = ''; count++; }
    else { tr.style.display = 'none'; }
  });
}
function switchTab(type, el) {
  document.querySelectorAll('.search-tab').forEach(function(t) { t.classList.remove('active'); });
  document.querySelectorAll('.search-panel').forEach(function(p) { p.classList.remove('active'); });
  el.classList.add('active');
  document.getElementById('panel-' + type).classList.add('active');
}
// 部门查询返回后自动切换到部门Tab
<c:if test="${not empty searchDept}">
window.onload = function() {
  var tabs = document.querySelectorAll('.search-tab');
  switchTab('dept', tabs[2]);
};
</c:if>
// 工号查询返回后留在工号Tab
<c:if test="${not empty searchEmpId}">
window.onload = function() {
  var tabs = document.querySelectorAll('.search-tab');
  switchTab('empId', tabs[0]);
};
</c:if>
// 姓名查询返回后自动切换到姓名Tab
<c:if test="${not empty searchName}">
window.onload = function() {
  var tabs = document.querySelectorAll('.search-tab');
  switchTab('name', tabs[1]);
};
</c:if>
</script>
</body>
</html>
