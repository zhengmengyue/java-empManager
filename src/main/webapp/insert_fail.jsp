<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>添加失败 · 员工信息管理系统</title>
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
  .nav-right { display: flex; align-items: center; }
  .nav-user { font-size: 14px; color: #64748b; }
  .nav-user strong { color: #6366f1; }
  .main { padding: 80px 40px; display: flex; justify-content: center; }
  .fail-card {
    width: 100%; max-width: 480px;
    background: #ffffff; border: 1px solid #fecaca;
    border-radius: 20px; padding: 48px 44px; text-align: center;
    box-shadow: 0 8px 32px rgba(239,68,68,0.10);
  }
  .fail-icon {
    width: 64px; height: 64px; background: #fee2e2;
    border-radius: 50%; display: inline-flex; align-items: center; justify-content: center;
    font-size: 30px; margin-bottom: 24px;
  }
  .fail-title { font-size: 20px; font-weight: 700; color: #ef4444; margin-bottom: 10px; }
  .fail-desc  { font-size: 14px; color: #94a3b8; margin-bottom: 32px; line-height: 1.7; }
  .btn-actions { display: flex; gap: 12px; justify-content: center; }
  .btn {
    display: inline-flex; align-items: center; justify-content: center;
    height: 44px; padding: 0 24px; border-radius: 10px;
    font-size: 14px; font-weight: 600; text-decoration: none;
    border: none; cursor: pointer; transition: opacity .2s;
  }
  .btn-retry { background: linear-gradient(135deg,#6366f1,#8b5cf6); color: #fff; box-shadow: 0 4px 14px rgba(99,102,241,0.3); }
  .btn-retry:hover { opacity: .88; }
  .btn-home  { background: #f1f5f9; color: #64748b; border: 1px solid #e2e8f0; }
  .btn-home:hover { background: #e2e8f0; }
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
  </div>
</nav>
<div class="main">
  <div class="fail-card">
    <div class="fail-icon">✕</div>
    <div class="fail-title">添加员工失败</div>
    <div class="fail-desc">员工信息添加失败，可能原因：<br>工号已存在 / 必填字段为空 / 数据格式错误</div>
    <div class="btn-actions">
      <a href="insert.jsp" class="btn btn-retry">重新添加</a>
      <a href="FindAllEmployeeServlet" class="btn btn-home">返回列表</a>
    </div>
  </div>
</div>
</body>
</html>
