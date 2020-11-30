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
                <a href="/" <c:if test="${curUrl eq '/'}"> class="mm-active" </c:if> >
                    <i class="metismenu-icon pe-7s-news-paper"></i>
                    Dashboard
                </a>
            </li>
            <li class="app-sidebar__heading">Member Management</li>
            <li>
                <a href="#">
                    <i class="metismenu-icon pe-7s-id"></i>
                    회원 관리
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <li <c:if test="${(curUrl eq '/member/list') || (curUrl eq '/member/view')}"> class="mm-active" </c:if>>
                        <a href="/member/list">
                            <i class="metismenu-icon"></i>
                            회원
                        </a>
                    </li>
                </ul>
            </li>
            <li class="app-sidebar__heading">Site Management</li>
            <li>
                <a href="#">
                    <i class="metismenu-icon pe-7s-note2"></i>
                        검증사이트 관리
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <li <c:if test="${(curUrl eq '/board/list') || (curUrl eq '/board/info')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=1">
                            <i class="metismenu-icon"></i>
                            검증 카지노
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/board/list') || (curUrl eq '/board/info')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=2">
                            <i class="metismenu-icon"></i>
                            비공개 카지노
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class="metismenu-icon pe-7s-cash"></i>
                    먹튀&카지노 관리
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=3">
                            <i class="metismenu-icon"></i>
                            먹튀 사이트
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=4">
                            <i class="metismenu-icon"></i>
                            카지노 사이트
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class="metismenu-icon pe-7s-cash"></i>
                    커뮤니티 관리
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=5">
                            <i class="metismenu-icon"></i>
                            카지노 검증/먹튀
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=6">
                            <i class="metismenu-icon"></i>
                            자유게시판
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=19">
                            <i class="metismenu-icon"></i>
                            회원이벤트
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=7">
                            <i class="metismenu-icon"></i>
                            온카지노 후기
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=9">
                            <i class="metismenu-icon"></i>
                            오프카지노 후기
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=8">
                            <i class="metismenu-icon"></i>
                            질문/답변
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=10">
                            <i class="metismenu-icon"></i>
                            카지노 노하우
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=11">
                            <i class="metismenu-icon"></i>
                            블랙리스트
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=12">
                            <i class="metismenu-icon"></i>
                            분쟁게시판
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=13">
                            <i class="metismenu-icon"></i>
                            펌/카지노 노하우
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=14">
                            <i class="metismenu-icon"></i>
                            펌/오프라인 후기
                        </a>
                    </li>
                    <li <c:if test="${(curUrl eq '/admin/rsv/list') || (curUrl eq '/admin/rsv/rsvInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=15">
                            <i class="metismenu-icon"></i>
                            펌/연제
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class="metismenu-icon pe-7s-help1"></i>
                    공지사항 관리
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <li <c:if test="${(curUrl eq '/admin/qnaList') || (curUrl eq '/admin/qnaInfo')}"> class="mm-active" </c:if>>
                        <a href="/board/list?class_seq=16">
                            <i class="metismenu-icon"></i>
                            공지사항
                        </a>
                    </li>
                </ul>
            </li>
            <li>
                <a href="#">
                    <i class="metismenu-icon pe-7s-help1"></i>
                    1:1문의 관리
                    <i class="metismenu-state-icon pe-7s-angle-down caret-left"></i>
                </a>
                <ul>
                    <li <c:if test="${(curUrl eq '/admin/qnaList') || (curUrl eq '/admin/qnaInfo')}"> class="mm-active" </c:if>>
                        <a href="/inquiry/list?">
                            <i class="metismenu-icon"></i>
                            문의
                        </a>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
</div>
</div>