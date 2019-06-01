package com.bookShop.utils;

import com.haizhang.entity.*;
import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

public class CommonUtil {
    //单例设计模式
    private static CommonUtil commonUtil =null;
    private CommonUtil(){
    }
    public static CommonUtil getInstance(){
        if(commonUtil ==null){
            synchronized (CommonUtil.class){
                if(commonUtil ==null){
                    synchronized (CommonUtil.class){
                         commonUtil =new CommonUtil();
                    }
                }
            }
        }
        return commonUtil;
    }

    /**
     * 上传用户头像代码
     * @param userInfo
     * @param profilePicture
     * @return
     * @throws IOException
     */
    public UserInfo resolveUserUpImage(UserInfo userInfo, MultipartFile profilePicture) throws IOException {

        synchronized (CommonUtil.class){
            int id=userInfo.getId();
            userInfo.setId(id);
            //获取个人头像，并生成头像名，然后存储到指定目录
            String newFilename="";
            if(profilePicture!=null){
                String originalName=profilePicture.getOriginalFilename();
                if(originalName!=null && originalName.trim().length()>0){
                    String pathInProject="E:\\BookShopWebsite\\Web\\src\\main\\webapp\\images\\shopImage\\";
                    newFilename= UUID.randomUUID()+originalName.substring(originalName.lastIndexOf("."));
                    profilePicture.transferTo(new File(pathInProject+newFilename));
                }
            }

            if(newFilename!=null && newFilename.trim().length()>0){
                userInfo.setImageLogo("/images/userLogo/"+newFilename);
            }
        }
        return userInfo;
    }


    /**
     * 修改上传店铺头像
     * @param merchantShop
     * @param profilePicture
     * @return
     * @throws IOException
     */
    public MerchantShop updateShopImage(MerchantShop merchantShop,MultipartFile profilePicture,String curPic) throws IOException {
        System.err.println("cur:"+curPic);
        synchronized (CommonUtil.class){
            //删除原先的图片
            String pathInProject="E:\\BookShopWebsite\\Web\\src\\main\\webapp\\images\\shopImage\\";
            System.err.println(pathInProject);
            if(curPic!=null){
                File relativeFile = new File(pathInProject+curPic.substring(curPic.lastIndexOf('/')+1));
                if(!curPic.contains("defaultShopImag.jpg")){
                    relativeFile.delete();
                }


            }

            String newFilename="";
            if(!profilePicture.isEmpty()){
                String originalName=profilePicture.getOriginalFilename();
                if(originalName!=null && originalName.trim().length()>0){
                    newFilename= UUID.randomUUID()+originalName.substring(originalName.lastIndexOf("."));
                    profilePicture.transferTo(new File(pathInProject+newFilename));
                }
            }

            if(newFilename!=null && newFilename.trim().length()>0){
                merchantShop.setShopLogo("/images/shopImage/"+newFilename);
            }
        }
        return merchantShop;
    }

    /**
     * 商家货物
     * @param profilePicture
     * @return
     * @throws IOException
     */
    public GoodsInfo upGoodsImage(GoodsInfo goodsInfo, MultipartFile profilePicture) throws IOException {
        synchronized (CommonUtil.class){
            String newFilename="";
            if(profilePicture!=null){
                String originalName=profilePicture.getOriginalFilename();
                if(originalName!=null && originalName.trim().length()>0){
                    String pathInProject="E:\\BookShopWebsite\\Web\\src\\main\\webapp\\images\\"+goodsInfo.getType()+"\\";
                    newFilename= UUID.randomUUID()+originalName.substring(originalName.lastIndexOf("."));
                    profilePicture.transferTo(new File(pathInProject+newFilename));

                }
            }
            //更新数据库
            if(newFilename!=null && newFilename.trim().length()>0){
                goodsInfo.setImgDir("/images/"+goodsInfo.getType()+"/"+newFilename);
                goodsInfo.setUpTime(new Date());
            }
        }
        return goodsInfo;
    }



    public RequestRecordShop resolveShopUpImage(RequestRecordShop requestRecordShop, MultipartFile profilePicture) throws IOException {
        synchronized (CommonUtil.class){
            //获取个人头像，并生成头像名，然后存储到指定目录
            String newFilename="";
            if(profilePicture!=null){
                String originalName=profilePicture.getOriginalFilename();
                if(originalName!=null && originalName.trim().length()>0){

                    String pathInProject="E:\\BookShopWebsite\\Web\\src\\main\\webapp\\images\\shopImage\\";
                    newFilename= UUID.randomUUID()+originalName.substring(originalName.lastIndexOf("."));
                    profilePicture.transferTo(new File(pathInProject+newFilename));
                }
            }
            //更新数据库
            if(newFilename!=null && newFilename.trim().length()>0){
                requestRecordShop.setShopLogo("/images/shopImage/"+newFilename);
            }
        }
        return requestRecordShop;
    }


    //封装用户数据进map
    public Map<String,Object> packageDataIntoMap(int rowCount, List<UserInfo>userInfos){
        Map<String,Object> map=new HashMap<>();
        map.put("data",userInfos);
        map.put("total",rowCount);
        return map;
    }

    //封装冻结数据进map
    public Map<String,Object> packageFreezeDataIntoMap(int rowCount, List<Freezerecord>freezerecords){
        Map<String,Object> map=new HashMap<>();
        map.put("data",freezerecords);
        map.put("total",rowCount);
        return map;
    }

    //检查日期是否合理
    public boolean checkDateValid(Date d1, Date d2){
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyy-MM-dd");
        return d2.after(d1)?true:false;
    }
}
