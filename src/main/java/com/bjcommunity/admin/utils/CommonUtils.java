package com.bjcommunity.admin.utils;

import com.bjcommunity.admin.Dto.CommonDTO;
import com.bjcommunity.admin.Dto.FileDTO;
import com.bjcommunity.admin.Mapper.CommonMapper;
import org.apache.commons.io.FileUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.ClassPathResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpRequest;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Service
public class CommonUtils {

    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    public static final String IS_MOBILE = "MOBILE";
    private static final String IS_PHONE = "PHONE";
    public static final String IS_TABLET = "TABLET";
    public static final String IS_PC = "PC";

    @Value("${file.upload.directory}")
    String uploadFileDir;

    @Value("${file.upload.repDirectory}")
    String uploadRepDir;

    @Value("${file.upload.urlPath}")
    String uploadFileUrl;

    @Value("${server.status.name}")
    String server_status;

    @Autowired
    CommonMapper commonMapper;

    @Autowired
    JavaMailSender javaMailSender;


    public Map<String, Object> calendar(String paramYear, String paramMonth){
        String today = "";

        SimpleDateFormat format_today = new SimpleDateFormat ( "yyyy-MM-dd");
        SimpleDateFormat format_year = new SimpleDateFormat ( "yyyy");
        SimpleDateFormat format_month = new SimpleDateFormat ( "MM");
        SimpleDateFormat format_day = new SimpleDateFormat ( "dd");

        Map<String, Object> dateInfo = new HashMap<String, Object>();

        Calendar cal = Calendar.getInstance();
        int dday = Integer.parseInt(format_day.format(cal.getTime()));
        today = format_today.format(cal.getTime());
        String thisYear = format_year.format(cal.getTime());
        String thisMonth = format_month.format(cal.getTime());

        System.out.println("today : " + today);

        if(paramYear == null){
            paramYear = format_year.format(cal.getTime());
        }

        if(paramMonth == null){
            paramMonth = format_month.format(cal.getTime());
            paramMonth = String.valueOf(Integer.parseInt(paramMonth) - 1);
        }

        System.out.println("paramYear : " + paramYear + " &&& paramMonth : " + paramMonth);

        cal.set(Integer.parseInt(paramYear), Integer.parseInt(paramMonth), 1);

        System.out.println("year : " + cal.get(cal.YEAR) + " month : " + cal.get(cal.MONTH));

        //cal.set(2020, 03, 05); 월 임의로 조정 가능

        int year=cal.get(cal.YEAR);
        int month=cal.get(cal.MONTH)+1 ;

        System.out.println("second yaer : " + year + " second month : " +  month);

        int firstDay = 0;

        cal.set(cal.DATE, 1);

        int lastDay=(month*9-month*9%8)/8%2;
        if(month!=2){ lastDay+=30;
        }else if((year%400==0)||(year%4==0)&&(year%100!=0)){
            lastDay+=29;
        } else{
            lastDay+=28;
        }

        int week = cal.get(cal.DAY_OF_WEEK);

        cal.set(year, month, 01);
        /*firstDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);*/

        if(month < 10 ){
            dateInfo.put("month", "0" + month);
        }else{
            dateInfo.put("month", month);
        }

        System.out.println("cur month : " + month + " cur year : " + year );

        if(month == 0){
            dateInfo.put("beforeYear", year - 1);
            dateInfo.put("beforeMonth", 11);
            dateInfo.put("afterYear", year);
            dateInfo.put("afterMonth", month);
        }else if(month == 12){
            dateInfo.put("beforeYear", year);
            dateInfo.put("beforeMonth", month - 2);
            dateInfo.put("afterYear", year + 1);
            dateInfo.put("afterMonth", 0);
        }else{
            dateInfo.put("beforeYear", year);
            dateInfo.put("beforeMonth", month - 2);
            dateInfo.put("afterYear", year);
            dateInfo.put("afterMonth", month);
        }

        System.out.println("after month : " + month + " after year : " + year );

        dateInfo.put("year", year);
        dateInfo.put("dday", dday);
        dateInfo.put("firstDay", week);
        dateInfo.put("lastDay", lastDay);
        dateInfo.put("fullToday", today);
        dateInfo.put("thisYear", thisYear);
        dateInfo.put("thisMonth", thisMonth);

        return dateInfo;
    }

    /**
     * 모바일,타블렛,PC구분
     * @param req
     * @return
     */
    public static String isDevice(HttpServletRequest req) {
        String userAgent = req.getHeader("User-Agent").toUpperCase();

        if(userAgent.indexOf(IS_MOBILE) > -1) {
            if(userAgent.indexOf(IS_PHONE) == -1)
                return IS_MOBILE;
            else
                return IS_TABLET;
        } else
            return IS_PC;
    }


    public void sendMail(String gubun, Map<String, Object> data) throws MessagingException{

        String sendMsg = "";
        String title = "";
        String to = "";
        DecimalFormat Commas = new DecimalFormat("#,###");

        if(gubun.equals("reserv")){
            title = "[에이도즈 스튜디오] 예약이 완료되었습니다.";
            to = (String)data.get("toEmail");

            ClassPathResource resource = new ClassPathResource("/static/mail/rsvMail.html");
            try {
                Path path = Paths.get(resource.getURI());
                List<String> content = Files.readAllLines(path);

                for(int i=0; i < content.size(); i++){
                    sendMsg += content.get(i);
                }

                /*if(data.get("timeInt") != null){

                }*/

                if(data.get("usrNm") != null){
                    sendMsg = sendMsg.replace("${usrNm}", (String)data.get("usrNm"));
                }

                if(data.get("compNm") != null){
                    sendMsg = sendMsg.replace("${compNm}", "(" + (String)data.get("compNm") + ")");
                }else{
                    sendMsg = sendMsg.replace("${compNm}", "");
                }

                if(data.get("rsvNo") != null){
                    sendMsg = sendMsg.replace("${rsvno}", (String)data.get("rsvNo"));
                }

                if(data.get("str_date") != null){
                    sendMsg = sendMsg.replace("${str_date}", (String)data.get("str_date"));
                }

                if(data.get("rsvImg") != null){
                    sendMsg = sendMsg.replace("${rsv_Img}", (String)data.get("rsvImg"));
                }

                if(data.get("rsvOpt") != null){

                    if("photo".equals(data.get("rsvOpt"))){
                        sendMsg = sendMsg.replace("${deposit}", "50,000");
                    }else{
                        sendMsg = sendMsg.replace("${deposit}", "100,000");
                    }

                }


                if(data.get("rsv_time") != null){
                    int[] times = (int[]) data.get("rsv_time");
                    String timeStr = "";




                    timeStr = String.valueOf(times[0]);

                    System.out.println("timeStr : " + timeStr);

                    if(times[0] < 10){
                        sendMsg = sendMsg.replace("${startTime}",  "0" +  timeStr);
                    }else{
                        sendMsg = sendMsg.replace("${startTime}", timeStr );
                    }

                    timeStr = String.valueOf(times[times.length-1] + 1);

                    if(times[times.length-1] < 10){
                        sendMsg = sendMsg.replace("${endTime}",  "0" + timeStr );
                    }else{
                        sendMsg = sendMsg.replace("${endTime}", timeStr );
                    }

                    timeStr = String.valueOf(times.length);

                      sendMsg = sendMsg.replace("${hour}", timeStr );

                }

                if(data.get("usrCnt") != null){
                    sendMsg = sendMsg.replace("${usrCnt}", data.get("usrCnt").toString());
                }

                if(data.get("payType") != null){
                    String tempType = "일반 계좌이체";
                    if(data.get("payType").toString().equals("company")){
                        tempType = "세금계산서 계좌이체";
                    }else if(data.get("payType").toString().equals("credit")){
                        tempType = "카드결제";
                    }
                    sendMsg = sendMsg.replace("${payType}", tempType);
                }

                if(data.get("rentAmt") != null){
                    sendMsg = sendMsg.replace("${rentAmt}", Commas.format(data.get("rentAmt")).toString());
                }

                if(data.get("usrAmt") != null){
                    sendMsg = sendMsg.replace("${usrAmt}", Commas.format(data.get("usrAmt")).toString());
                }else{
                    sendMsg = sendMsg.replace("${usrAmt}", "0");
                }

                if(data.get("eqAmt") != null){
                    sendMsg = sendMsg.replace("${eqAmt}", Commas.format(data.get("eqAmt")).toString());
                }else{
                    sendMsg = sendMsg.replace("${eqAmt}", "0");
                }

                /*if(data.get("rsv_price") != null){
                    int totalAmt = (int)data.get("rentAmt") + (int)data.get("usrAmt");
                    int rsv_vat = (int) (totalAmt * 0.10);
                    sendMsg = sendMsg.replace("${rsv_vat}", Commas.format(rsv_vat).toString());
                }*/

                if(data.get("rsv_price") != null){
                    sendMsg = sendMsg.replace("${rsv_price}", Commas.format(data.get("rsv_price")).toString());
                }

                if(data.get("str_date") != null){
                    sendMsg = sendMsg.replace("${str_date}", data.get("str_date").toString());
                }


                if(data.get("rentNm") != null){
                    sendMsg = sendMsg.replace("${rentNm}", data.get("rentNm").toString());
                }

                System.out.println("sendMsg : " + sendMsg);

            } catch (IOException e) {
                System.out.println(e.getMessage().toString());
            }
        }else if(gubun.equals("qna")){

            title = "[에이도즈 스튜디오] 문의사항 답변 드립니다.";
            to = (String)data.get("toEmail");

            try{

                ClassPathResource resource = new ClassPathResource("/static/mail/qnaMail.html");

                Path path = Paths.get(resource.getURI());
                List<String> content = Files.readAllLines(path);

                for(int i=0; i < content.size(); i++){
                    sendMsg += content.get(i);
                }

                if(data.get("usrNm") != null){
                    sendMsg = sendMsg.replace("${usrNm}", data.get("usrNm").toString());
                }
                if(data.get("ansMsg") != null){
                    sendMsg = sendMsg.replace("${ansMsg}", data.get("ansMsg").toString());
                }

            }catch  (IOException e) {
                System.out.println(e.getMessage().toString());
            }

        }else if(gubun.equals("rsvConfirm")){
            title = "[에이도즈 스튜디오] 예약 확정 안내드립니다.";
            to = (String)data.get("toEmail");

            try{

                ClassPathResource resource = new ClassPathResource("/static/mail/confirmMail.html");

                Path path = Paths.get(resource.getURI());
                List<String> content = Files.readAllLines(path);

                for(int i=0; i < content.size(); i++){
                    sendMsg += content.get(i);
                }

                if(data.get("usrNm") != null){
                    sendMsg = sendMsg.replace("${usrNm}", data.get("usrNm").toString());
                }
                if(data.get("ansMsg") != null){
                    sendMsg = sendMsg.replace("${ansMsg}", data.get("ansMsg").toString());
                }

            }catch  (IOException e) {
                System.out.println(e.getMessage().toString());
            }
        }

        MimeMessage message = javaMailSender.createMimeMessage();
        message.setSubject(title);
        message.setRecipients(Message.RecipientType.TO, String.valueOf(new InternetAddress(to)));

        MimeMessageHelper helper = new MimeMessageHelper(message, true);
        helper.setTo(to);
        helper.setText(sendMsg, true);

        message.setSentDate(new Date());
        javaMailSender.send(message);
    }

    public List<FileDTO> fileUpload(List<MultipartFile> files){
        List<FileDTO> fileDTO = new ArrayList<FileDTO>();
        FileDTO fileSub = new FileDTO();
        String[] path = new String[files.size()];
        String fileDir = sibuncho("dir");
        String fileNm = sibuncho("fileNm");
        int i = 0;

        for(MultipartFile file : files){
            fileSub = new FileDTO();
            fileNm = sibuncho("fileNm");
            String[] fileExtension = file.getOriginalFilename().split("\\.");
            File targetFile = new File(fileDir + fileNm + "." + fileExtension[1]);

            try {
                InputStream fileStream = file.getInputStream();
                FileUtils.copyInputStreamToFile(fileStream, targetFile);

                if(server_status.equals("dev")){
                    fileSub.setFileUrl(fileDir.replaceAll("\\\\","/").replaceAll(uploadRepDir, ""));
                }else{
                    fileSub.setFileUrl(uploadFileUrl + fileDir.replaceAll(uploadFileDir, ""));
                }
                fileSub.setFileOriName(file.getOriginalFilename());
                fileSub.setFileEts(fileExtension[1]);
                fileSub.setFileName(fileNm);
                fileDTO.add(fileSub);

                i++;
            } catch (IOException e) {
                FileUtils.deleteQuietly(targetFile);
                e.printStackTrace();
            }
        }

        return fileDTO;
    }

    public FileDTO fileUpload(MultipartFile files){
        FileDTO fileDTO = new FileDTO();
        String[] fileExtension = files.getOriginalFilename().split("\\.");
        String fileDir = sibuncho("dir");
        String fileNm = sibuncho("fileNm");

        File targetFile = new File(fileDir + fileNm + "." + fileExtension[1]);
        try {
            InputStream fileStream = files.getInputStream();
            FileUtils.copyInputStreamToFile(fileStream, targetFile);
            if(server_status.equals("dev")){
                fileDTO.setFileUrl(fileDir.replaceAll("\\\\","/").replaceAll(uploadRepDir, ""));
            }else{
                fileDTO.setFileUrl( uploadFileUrl + fileDir.replaceAll(uploadFileDir, ""));
            }
            fileDTO.setFileName(fileNm);
            fileDTO.setFileEts(fileExtension[1]);
            fileDTO.setFileOriName(files.getOriginalFilename());
        } catch (IOException e) {
            FileUtils.deleteQuietly(targetFile);
            e.printStackTrace();
        }

        return fileDTO;
    }

    public String sibuncho(String gubun){
        SimpleDateFormat  formatter01 = new SimpleDateFormat("yyMMdd");
        SimpleDateFormat  formatter02 = new SimpleDateFormat("hh:mm:ss.SSS");
        SimpleDateFormat  formatter03 = new SimpleDateFormat("yyyyMMdd");

        Calendar cal = Calendar.getInstance();

        String todate01 = formatter01.format(cal.getTime());
        String todate02 = formatter02.format(cal.getTime());
        String todate03 = formatter03.format(cal.getTime());

        String rtrnStr = "";

        if(gubun.equals("dir")){
            rtrnStr = uploadFileDir + todate03 +"/";
        }else if(gubun.equals("fileNm")){
            rtrnStr = todate01 + todate02.replaceAll(":", "").replaceAll("\\.","");
        }

        return rtrnStr;
    }

    public boolean isMobile(HttpServletRequest request){
        String userAgent = request.getHeader("user-agent").toUpperCase();

        if(userAgent.indexOf(Constants.IS_MOBILE) > -1) {
            return true;
        }else{
            return false;
        }
    }

    public Map<String, Object> serverPath(HttpServletRequest request){
        Map<String, Object> pathMap = new HashMap<String, Object>();

        pathMap.put("subPath", request.getServletPath());  // 현재 경로
        pathMap.put("subQuery", request.getQueryString()); // 매개 변수

        return pathMap;
    }

}
