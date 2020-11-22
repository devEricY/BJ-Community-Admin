package com.bjcommunity.admin.Service;

import com.bjcommunity.admin.Dto.*;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface AdminService {
    public Map<String, Object> loginProcess(AdminDTO adminDTO) throws Exception;

}
