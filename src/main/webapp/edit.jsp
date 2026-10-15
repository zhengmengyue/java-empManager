<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>修改员工 · 员工信息管理系统</title>
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
  .btn-back { padding: 7px 18px; border-radius: 8px; font-size: 13px; background: #f1f5f9; color: #64748b; border: 1px solid #e2e8f0; text-decoration: none; transition: background .2s; }
  .btn-back:hover { background: #e2e8f0; }
  .main { padding: 48px 40px; display: flex; justify-content: center; }
  .form-card {
    width: 100%; max-width: 560px;
    background: #ffffff; border: 1px solid #e8eaf0;
    border-radius: 20px; padding: 40px 44px;
    box-shadow: 0 8px 32px rgba(99,102,241,0.10);
  }
  .form-card h2 { font-size: 20px; font-weight: 700; color: #1e293b; margin-bottom: 6px; }
  .form-card p  { font-size: 13px; color: #94a3b8; margin-bottom: 32px; }
  .emp-id-badge {
    display: inline-block; padding: 2px 10px; background: #ede9fe;
    color: #6366f1; border-radius: 6px; font-size: 13px; font-weight: 600;
  }
  .form-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 0 20px; }
  .form-group { margin-bottom: 22px; }
  .form-group.full { grid-column: 1 / -1; }
  .form-group label { display: block; font-size: 13px; color: #64748b; margin-bottom: 8px; }
  .form-group input,
  .form-group select {
    width: 100%; height: 44px; padding: 0 14px;
    background: #f8fafc; border: 1px solid #e2e8f0;
    border-radius: 10px; color: #1e293b; font-size: 14px;
    outline: none; transition: border-color .2s, box-shadow .2s; appearance: none;
  }
  .form-group select option { background: #ffffff; color: #1e293b; }
  .form-group input:focus,
  .form-group select:focus { border-color: #6366f1; box-shadow: 0 0 0 3px rgba(99,102,241,0.2); }
  .form-actions { display: flex; gap: 12px; margin-top: 8px; }
  .btn-submit {
    flex: 1; height: 46px; background: linear-gradient(135deg,#10b981,#059669);
    border: none; border-radius: 10px; color: #fff; font-size: 15px; font-weight: 600;
    cursor: pointer; transition: opacity .2s, transform .1s;
    box-shadow: 0 6px 20px rgba(16,185,129,0.3);
  }
  .btn-submit:hover  { opacity: .88; }
  .btn-submit:active { transform: scale(.98); }
  .btn-cancel {
    height: 46px; padding: 0 24px; background: #f1f5f9;
    border: 1px solid #e2e8f0; border-radius: 10px;
    color: #64748b; font-size: 15px; cursor: pointer; text-decoration: none;
    display: inline-flex; align-items: center; transition: background .2s;
  }
  .btn-cancel:hover { background: #e2e8f0; }
</style>
</head>
<body>
<nav class="navbar">
  <div class="nav-brand">
    <div class="icon">👥</div>
    <span>员工信息管理系统</span>
  </div>
  <a href="FindAllEmployeeServlet" class="btn-back">← 返回列表</a>
</nav>
<div class="main">
  <div class="form-card">
    <h2>修改员工信息</h2>
    <p>当前编辑：<span class="emp-id-badge">${employee.name}</span></p>
    <form action="UpdateEmployeeServlet" method="post">
      <input type="hidden" name="id" value="${employee.id}">
      <div class="form-grid">
        <div class="form-group">
          <label>工号</label>
          <input type="text" name="empId" value="${employee.empId}">
        </div>
        <div class="form-group">
          <label>姓名</label>
          <input type="text" name="name" value="${employee.name}">
        </div>
        <div class="form-group">
          <label>密码</label>
          <input type="password" name="password" value="${employee.password}">
        </div>
        <div class="form-group">
          <label>出生日期</label>
          <input type="date" name="birthday" value="${employee.birthday}">
        </div>
        <div class="form-group full">
          <label>电子邮箱</label>
          <input type="email" name="email" value="${employee.email}">
        </div>
        <div class="form-group full">
          <label>部门</label>
          <select name="department">
            <option value="技术部"  ${employee.department=='技术部'  ? 'selected' : ''}>技术部</option>
            <option value="人事部"  ${employee.department=='人事部'  ? 'selected' : ''}>人事部</option>
            <option value="财务部"  ${employee.department=='财务部'  ? 'selected' : ''}>财务部</option>
            <option value="市场部"  ${employee.department=='市场部'  ? 'selected' : ''}>市场部</option>
            <option value="销售部"  ${employee.department=='销售部'  ? 'selected' : ''}>销售部</option>
            <option value="运营部"  ${employee.department=='运营部'  ? 'selected' : ''}>运营部</option>
          </select>
        </div>
      </div>
      <div class="form-actions">
        <button type="submit" class="btn-submit">保存修改</button>
        <a href="FindAllEmployeeServlet" class="btn-cancel">取消</a>
      </div>
    </form>
  </div>
</div>
</body>
</html>
