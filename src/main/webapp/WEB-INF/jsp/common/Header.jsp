<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<div class="app-container app-theme-white body-tabs-shadow fixed-sidebar fixed-header">
    <div class="app-header header-shadow">
        <div class="app-header__logo">
            <div><a href="/dashboard"><%--<img src="/static/img/kob_logo.png" style="width:155px;" />--%></a></div>
            <div class="header__pane ml-auto"><div>
<%--                <button type="button" class="hamburger close-sidebar-btn hamburger--elastic" data-class="closed-sidebar">
                    <span class="hamburger-box">
                    <span class="hamburger-inner"></span>
                    </span>
                </button>--%>
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
        </div>
        <div class="app-header__content">
            <div class="app-header-right">
                <div class="header-btn-lg pr-0">
                    <div class="widget-content p-0">
                        <div class="widget-content-wrapper">
                            <div class="widget-content-left">
                                <div class="btn-group">
                                    <div tabindex="-1" role="menu" aria-hidden="true" class="dropdown-menu dropdown-menu-right">
                                        <button type="button" tabindex="0" class="dropdown-item">User Account</button>
                                        <button type="button" tabindex="0" class="dropdown-item">Settings</button>
                                        <h6 tabindex="-1" class="dropdown-header">Header</h6>
                                        <button type="button" tabindex="0" class="dropdown-item">Actions</button>
                                        <div tabindex="-1" class="dropdown-divider"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="widget-content-left  ml-3 header-user-info">
                                <div class="widget-heading">
                                    ${adminId}
                                </div>
                                <div class="widget-subheading">
                                     Manager
                                </div>
                            </div>
                        </div>
                    </div>
                </div>        </div>
        </div>
    </div>
    <div class="ui-theme-settings">
    <%--<button type="button" id="TooltipDemo" class="btn-open-options btn btn-warning">
        <i class="fa fa-cog fa-w-16 fa-spin fa-2x"></i>
    </button>--%>
    <div class="theme-settings__inner">
        <div class="scrollbar-container">
            <div class="theme-settings__options-wrapper">
                <h3 class="themeoptions-heading">Layout Options
                </h3>
                <div class="p-3">
                    <ul class="list-group">
                        <li class="list-group-item">
                            <div class="widget-content p-0">
                                <div class="widget-content-wrapper">
                                    <div class="widget-content-left mr-3">
                                        <div class="switch has-switch switch-container-class" data-class="fixed-header">
                                            <div class="switch-animate switch-on">
                                                <input type="checkbox" checked data-toggle="toggle" data-onstyle="success">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="widget-content-left">
                                        <div class="widget-heading">Fixed Header
                                        </div>
                                        <div class="widget-subheading">Makes the header top fixed, always visible!
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <div class="widget-content p-0">
                                <div class="widget-content-wrapper">
                                    <div class="widget-content-left mr-3">
                                        <div class="switch has-switch switch-container-class" data-class="fixed-sidebar">
                                            <div class="switch-animate switch-on">
                                                <input type="checkbox" checked data-toggle="toggle" data-onstyle="success">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="widget-content-left">
                                        <div class="widget-heading">Fixed Sidebar
                                        </div>
                                        <div class="widget-subheading">Makes the sidebar left fixed, always visible!
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="list-group-item">
                            <div class="widget-content p-0">
                                <div class="widget-content-wrapper">
                                    <div class="widget-content-left mr-3">
                                        <div class="switch has-switch switch-container-class" data-class="fixed-footer">
                                            <div class="switch-animate switch-off">
                                                <input type="checkbox" data-toggle="toggle" data-onstyle="success">
                                            </div>
                                        </div>
                                    </div>
                                    <div class="widget-content-left">
                                        <div class="widget-heading">Fixed Footer
                                        </div>
                                        <div class="widget-subheading">Makes the app footer bottom fixed, always visible!
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
</div>