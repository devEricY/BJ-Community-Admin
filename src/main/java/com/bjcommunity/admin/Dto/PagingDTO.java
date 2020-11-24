package com.bjcommunity.admin.Dto;

public class PagingDTO {
    private int rownum;
    private int page;
    private int perPageNum;
    private int endPage;

    public int getPageStart() {
        return (this.page-1)*perPageNum;
    }
    public int getPageEnd() {
        return (this.page)*perPageNum;
    }

    public PagingDTO() {
        this.page = 1;
        this.perPageNum = 10;
    }

    public int getPage() {
        return page;
    }
    public void setPage(int page) {
        if(page <= 0) {
            this.page = 1;
        } else {
            this.page = page;
        }
    }
    public int getPerPageNum() {
        return perPageNum;
    }
    public void setPerPageNum(int pageCount) {
        int cnt = this.perPageNum;
        if(pageCount != cnt) {
            this.perPageNum = cnt;
        } else {
            this.perPageNum = pageCount;
        }
    }
}
