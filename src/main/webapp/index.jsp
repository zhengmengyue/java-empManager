<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>员工信息管理系统</title>
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; }
  body { background: #f0f4ff; color: #1e293b; font-family: 'Segoe UI','PingFang SC','Microsoft YaHei',sans-serif; min-height: 100vh; }

  /* 顶部导航 */
  .navbar {
    height: 64px; background: #ffffff;
    border-bottom: 1px solid #e8eaf0;
    display: flex; align-items: center; justify-content: space-between;
    padding: 0 40px; position: sticky; top: 0; z-index: 100;
    box-shadow: 0 1px 8px rgba(99,102,241,0.08);
  }
  .nav-brand { display: flex; align-items: center; gap: 12px; }
  .nav-brand .icon {
    width: 36px; height: 36px; background: linear-gradient(135deg,#6366f1,#8b5cf6);
    border-radius: 10px; display: flex; align-items: center; justify-content: center; font-size: 18px;
  }
  .nav-brand span { font-size: 17px; font-weight: 600; color: #1e293b; letter-spacing: .5px; }
  .nav-right { display: flex; align-items: center; gap: 20px; }
  .nav-user { font-size: 14px; color: #64748b; }
  .nav-user strong { color: #6366f1; }
  .btn-logout {
    padding: 7px 18px; border-radius: 8px; font-size: 13px;
    background: #fff0f0; color: #ef4444;
    border: 1px solid #fecaca; cursor: pointer;
    text-decoration: none; transition: background .2s;
  }
  .btn-logout:hover { background: #fee2e2; }

  /* 主内容 */
  .main { padding: 32px 40px; }
  .page-header { display: flex; align-items: center; justify-content: space-between; margin-bottom: 28px; }
  .page-title { font-size: 22px; font-weight: 700; color: #1e293b; }
  .page-title span { font-size: 14px; color: #94a3b8; font-weight: 400; margin-left: 10px; }
  .toolbar { display: flex; gap: 12px; }

  .btn {
    display: inline-flex; align-items: center; gap: 7px;
    padding: 9px 20px; border-radius: 9px; font-size: 14px; font-weight: 500;
    border: none; cursor: pointer; text-decoration: none; transition: opacity .2s, transform .1s;
  }
  .btn:active { transform: scale(.97); }
  .btn-primary { background: linear-gradient(135deg,#6366f1,#8b5cf6); color: #fff; box-shadow: 0 4px 14px rgba(99,102,241,0.35); }
  .btn-primary:hover { opacity: .88; }
  .btn-success { background: linear-gradient(135deg,#10b981,#059669); color: #fff; box-shadow: 0 4px 14px rgba(16,185,129,0.3); }
  .btn-success:hover { opacity: .88; }

  /* 统计卡片 */
  .stats { display: grid; grid-template-columns: repeat(4,1fr); gap: 18px; margin-bottom: 28px; }
  .stat-card {
    background: #ffffff; border: 1px solid #e8eaf0;
    border-radius: 14px; padding: 20px 24px;
    box-shadow: 0 2px 8px rgba(99,102,241,0.06);
  }
  .stat-label { font-size: 13px; color: #94a3b8; margin-bottom: 10px; }
  .stat-value { font-size: 28px; font-weight: 700; color: #1e293b; }
  .stat-value.purple { color: #a5b4fc; }
  .stat-value.green  { color: #6ee7b7; }
  .stat-value.blue   { color: #7dd3fc; }
  .stat-value.orange { color: #fcd34d; }

  /* 表格卡片 */
  .table-card {
    background: #ffffff; border: 1px solid #e8eaf0;
    border-radius: 16px; overflow: hidden;
    box-shadow: 0 2px 12px rgba(99,102,241,0.07);
  }
  .table-toolbar {
    padding: 18px 24px; border-bottom: 1px solid #f1f5f9;
    display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px;
  }
  .table-toolbar-title { font-size: 15px; font-weight: 600; color: #1e293b; }
  .dept-tabs { display: flex; gap: 8px; flex-wrap: wrap; }
  .dept-tab {
    padding: 5px 14px; border-radius: 20px; font-size: 13px; font-weight: 500;
    border: 1.5px solid #e2e8f0; background: #f8fafc; color: #64748b;
    cursor: pointer; transition: all .18s;
  }
  .dept-tab:hover { border-color: #6366f1; color: #6366f1; background: #ede9fe; }
  .dept-tab.active { background: linear-gradient(135deg,#6366f1,#8b5cf6); color: #fff; border-color: transparent; box-shadow: 0 2px 8px rgba(99,102,241,0.3); }
  table { width: 100%; border-collapse: collapse; }
  thead tr { background: #f8fafc; }
  th {
    padding: 14px 20px; text-align: left; font-size: 12px;
    color: #94a3b8; font-weight: 600; letter-spacing: .8px; text-transform: uppercase;
  }
  td { padding: 14px 20px; font-size: 14px; color: #334155; border-top: 1px solid #f1f5f9; }
  tbody tr { transition: background .15s; }
  tbody tr:hover { background: #f5f3ff; }
  .badge {
    display: inline-block; padding: 3px 10px; border-radius: 20px;
    font-size: 12px; font-weight: 500;
  }
  .badge-tech   { background: rgba(99,102,241,0.2);  color: #a5b4fc; }
  .badge-hr     { background: rgba(16,185,129,0.18); color: #6ee7b7; }
  .badge-fin    { background: rgba(245,158,11,0.18); color: #fcd34d; }
  .badge-mkt    { background: rgba(59,130,246,0.18); color: #93c5fd; }
  .badge-sales  { background: rgba(236,72,153,0.18); color: #f9a8d4; }
  .badge-ops    { background: rgba(20,184,166,0.18); color: #5eead4; }
  .badge-other  { background: rgba(148,163,184,0.15);color: #94a3b8; }
  .action-link {
    display: inline-flex; align-items: center; padding: 5px 13px;
    border-radius: 7px; font-size: 13px; text-decoration: none; transition: background .15s;
    margin-right: 6px;
  }
  .action-edit   { color: #6366f1; background: #ede9fe; }
  .action-edit:hover { background: #ddd6fe; }
  .action-delete { color: #ef4444; background: #fee2e2; }
  .action-delete:hover { background: #fecaca; }
  .empty { text-align: center; padding: 60px; color: #94a3b8; font-size: 15px; }
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
    <a href="LogoutServlet" class="btn-logout">退出登录</a>
  </div>
</nav>

<div class="main">
  <div class="page-header">
    <div class="page-title">员工列表 <span>Employee List</span></div>
    <div class="toolbar">
      <a href="find.jsp" class="btn btn-primary">🔍 查询员工</a>
      <a href="insert.jsp" class="btn btn-success">＋ 添加员工</a>
      <a href="FindAllEmployeeServlet" class="btn" style="background:#f1f5f9;color:#64748b;">↻ 刷新</a>
    </div>
  </div>

  <div class="stats">
    <div class="stat-card"><div class="stat-label">员工总数</div><div class="stat-value purple">${employees.size()}</div></div>
    <div class="stat-card"><div class="stat-label">技术部</div>
      <div class="stat-value blue"><c:set var="c1" value="0"/><c:forEach var="e" items="${employees}"><c:if test="${e.department=='技术部'}"><c:set var="c1" value="${c1+1}"/></c:if></c:forEach>${c1}</div></div>
    <div class="stat-card"><div class="stat-label">销售部</div>
      <div class="stat-value green"><c:set var="c2" value="0"/><c:forEach var="e" items="${employees}"><c:if test="${e.department=='销售部'}"><c:set var="c2" value="${c2+1}"/></c:if></c:forEach>${c2}</div></div>
    <div class="stat-card"><div class="stat-label">其他部门</div>
      <div class="stat-value orange"><c:set var="c3" value="0"/><c:forEach var="e" items="${employees}"><c:if test="${e.department!='技术部' and e.department!='销售部'}"><c:set var="c3" value="${c3+1}"/></c:if></c:forEach>${c3}</div></div>
  </div>

  <div class="table-card">
    <div class="table-toolbar">
      <span class="table-toolbar-title">全部员工</span>
      <div class="dept-tabs">
        <span class="dept-tab active" onclick="filterDept('all', this)">全部</span>
        <span class="dept-tab" onclick="filterDept('技术部', this)">技术部</span>
        <span class="dept-tab" onclick="filterDept('人事部', this)">人事部</span>
        <span class="dept-tab" onclick="filterDept('财务部', this)">财务部</span>
        <span class="dept-tab" onclick="filterDept('市场部', this)">市场部</span>
        <span class="dept-tab" onclick="filterDept('销售部', this)">销售部</span>
        <span class="dept-tab" onclick="filterDept('运营部', this)">运营部</span>
      </div>
    </div>
    <table>
      <thead>
        <tr>
          <th>工号</th><th>姓名</th><th>电子邮箱</th><th>部门</th><th>出生日期</th><th>操作</th>
        </tr>
      </thead>
      <tbody>
        <c:choose>
          <c:when test="${empty employees}">
            <tr><td colspan="6" class="empty">暂无员工数据，请先 <a href="insert.jsp" style="color:#6366f1;">添加员工</a></td></tr>
          </c:when>
          <c:otherwise>
            <c:forEach var="employee" items="${employees}">
            <tr data-dept="${employee.department}">
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
            </c:forEach>
          </c:otherwise>
        </c:choose>
      </tbody>
    </table>
  </div>
</div>

<script>
function filterDept(dept, el) {
  document.querySelectorAll('.dept-tab').forEach(function(t) { t.classList.remove('active'); });
  el.classList.add('active');
  document.querySelectorAll('tbody tr[data-dept]').forEach(function(tr) {
    tr.style.display = (dept === 'all' || tr.dataset.dept === dept) ? '' : 'none';
  });
}
</script>
</body>
</html>
