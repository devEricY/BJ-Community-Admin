<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<div class="app-sidebar sidebar-shadow">
    <div class="app-header__logo">
        <div class="logo-src"></div>
        <div class="header__pane ml-auto">
            <div>
                <button type="button" class="hamburger close-sidebar-btn hamburger--elastic" data-class="closed-sidebar">
                        <span class="hamburger-box">
                            <span class="hamburger-inner"></span>
                        </span>
                </button>
            </div>
        </div>
    </div>
    <div class="app-header__mobile-menu">
        <div>
            <button type="button" class="hamburger hamburger--elastic mobile-toggle-nav">
    <span class="hamburger-box">
    <span class="hamburger-inner"></span>
    </span>
            </button>
        </div>
    </div>
    <div class="app-header__menu">
    <span>
    <button type="button" class="btn-icon btn-icon-only btn btn-primary btn-sm mobile-toggle-header-nav">
    <span class="btn-icon-wrapper">
    <i class="fa fa-ellipsis-v fa-w-6"></i>
    </span>
    </button>
    </span>
    </div>    <div class="scrollbar-sidebar">
    <div class="app-sidebar__inner">
        <ul class="vertical-nav-menu">
            <li class="app-sidebar__heading">Dashboards</li>
            <li>
                <a href="/admin/dashboard" <c:if test="${curUrl eq '/admin/dashboard'}"> class="mm-active" </c:if> >
                    <i class="metismenu-icon pe-7s-news-paper"></i>
                    Dashboard
                </a>
            </li>
            <li class="app-sidebar__heading">Admin Menu</li>
            <li>
                <a href="#">
                    <i class="metismenu-icon pe-7s-cash"></i>
                    Reservation
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/admin/rsv/list">
                            <i class="metismenu-icon"></i>
                            Reservation list
                        </a>
                    </li>
                    <%--<li>
                        <a href="/admin/rsv/addRsv">
                            <i class="metismenu-icon"></i>
                            Reservation Calender
                        </a>
                    </li>--%>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class="metismenu-icon pe-7s-help1"></i>
                    QNA
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <li <c:if test="${(curUrl eq '/admin/qnaList') || (curUrl eq '/admin/qnaInfo')}"> class="mm-active" </c:if>>
                        <a href="/admin/qnaList">
                            <i class="metismenu-icon"></i>
                            QNA list
                        </a>
                    </li>
                    <%--<li>
                        <a href="/admin/rsv/addRsv">
                            <i class="metismenu-icon"></i>
                            Reservation Calender
                        </a>
                    </li>--%>
                </ul>
            </li>
            <%--<li >
                <a href="#">
                    <i class="metismenu-icon pe-7s-portfolio"></i>
                    Portfolio
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <li>
                        <a href="components-tabs.html">
                            <i class="metismenu-icon">
                            </i>DEVAHA-JEWELLERY
                        </a>
                    </li>
                    <li>
                        <a href="components-accordions.html">
                            <i class="metismenu-icon">
                            </i>SKONEC MORTALBLITZ
                        </a>
                    </li>
                    <li>
                        <a href="components-accordions.html">
                            <i class="metismenu-icon">
                            </i>Maeil D'ertte 뚜아뚜지
                        </a>
                    </li>
                    <li>
                        <a href="components-accordions.html">
                            <i class="metismenu-icon">
                            </i>LITHUANIA
                        </a>
                    </li>
                    <li>
                        <a href="components-accordions.html">
                            <i class="metismenu-icon">
                            </i>VR SQUARE
                        </a>
                    </li>
                    <li>
                        <a href="components-accordions.html">
                            <i class="metismenu-icon">
                            </i>Eindruck
                        </a>
                    </li>
                </ul>
            </li>--%>

            <c:if test="${authCd eq 1}">
            <li>
                <a href="#">
                    <i class="metismenu-icon pe-7s-graph2"></i>
                    Main-Contents
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <li <c:if test="${(curUrl eq '/admin/mainManage') }"> class="mm-active" </c:if>>
                        <a href="/admin/mainManage">
                            <i class="metismenu-icon"></i>
                            Main Image
                        </a>
                    </li>
                    <%--<li>
                        <a href="/admin/rsv/addRsv">
                            <i class="metismenu-icon"></i>
                            Reservation Calender
                        </a>
                    </li>--%>
                </ul>
            </li>
            <li <c:if test="${(curUrl eq '/admin/edit/rentEdit') or (curUrl eq '/admin/edit/rentB') or (curUrl eq '/admin/edit/rentC')}"> class="mm-active" </c:if>>
                <a href="#">
                    <i class="metismenu-icon pe-7s-upload"></i>
                    Rent-Contents
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <li>
                        <a href="/admin/edit/rentEdit?seqNo=1" <c:if test="${curFullUrl eq '/admin/edit/rentEdit?seqNo=1'}">  class="mm-active" </c:if>>
                            <i class="metismenu-icon">
                            </i>rent-A
                        </a>
                    </li>
                    <li>
                        <a href="/admin/edit/rentEdit?seqNo=2" <c:if test="${curFullUrl eq '/admin/edit/rentEdit?seqNo=2'}">  class="mm-active" </c:if>>
                            <i class="metismenu-icon">
                            </i>rent-B
                        </a>
                    </li>
                    <li>
                        <a href="/admin/edit/rentEdit?seqNo=3" <c:if test="${curFullUrl eq '/admin/edit/rentEdit?seqNo=3'}">  class="mm-active" </c:if>>
                            <i class="metismenu-icon">
                            </i>rent-C
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class="metismenu-icon pe-7s-display2"></i>
                    Management
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <li <c:if test="${(curUrl eq '/admin/mngList') }"> class="mm-active" </c:if>>
                        <a href="/admin/mngList">
                            <i class="metismenu-icon"></i>
                            Admin Management
                        </a>
                    </li>
                        <%--<li>
                            <a href="/admin/rsv/addRsv">
                                <i class="metismenu-icon"></i>
                                Reservation Calender
                            </a>
                        </li>--%>
                </ul>
            </li>
            </c:if>
        </ul>
    </div>
</div>
</div>