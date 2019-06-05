import com.bookShop.mapper.GoodsMapper;
import com.bookShop.service.GoodService;
import com.haizhang.entity.GoodsInfo;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import javax.annotation.Resource;
import org.apache.log4j.*;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 测试货物相关的service接口
 */
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional()
@TransactionConfiguration(transactionManager = "transactionManager",defaultRollback = true)
@ContextConfiguration("classpath:spring-aop.xml")
public class TestGoodService {

    @Resource
    GoodService goodService;

//
//
//    public GoodsInfo (GoodsInfo goodsInfo);


    //获取所有货物信息，HashMap，键值对===  货物编号====货物信息
    @Test
    public void TestGetAllGoods(){
        HashMap<Integer,GoodsInfo> res=goodService.getAllGoods();
        for(Map.Entry<Integer,GoodsInfo>r:res.entrySet())
            System.out.println(r.getValue());
    }

    //根据goodsName或goodsId获取唯一的货物
    @Test
    public void TestqueryGoodsByGoodsInfo(){
        GoodsInfo goodsInfo=new GoodsInfo();
        goodsInfo.setGoodsId(93);
        GoodsInfo res=goodService.queryGoodsByGoodsInfo(goodsInfo);
        System.out.println(res);
    }

    //得到所有新上架的商品
    @Test
    public void TestgetAllNewGood(){
         List<GoodsInfo> goodsInfos=goodService.getAllNewGood();
         for(GoodsInfo r:goodsInfos)
             System.out.println(r);
    }

    //实现商品名的模糊查询
    @Test
    public void  TestqueryGoodsInVague(){
        List<GoodsInfo> goodsInfo=goodService.queryGoodsInVague("小");
        for(GoodsInfo r:goodsInfo)
            System.out.println(r);
    }

    //得到商铺所有商品
    @Test
    public void TestqueryShopGoods(){
        List<GoodsInfo> goodsInfos=goodService.queryShopGoods(1);
        for(GoodsInfo r:goodsInfos)
            System.out.println(r);
    }

    //测试好书推荐
    @Test
    public void  TestqueryExcellentBook(){
        List<GoodsInfo> excellentBookList=goodService.queryExcellentBook();
        for(GoodsInfo r:excellentBookList)
            System.out.println(r);
    }

    @Test
    public void queryBookByEachType() {
        List<GoodsInfo> goodsInfos=goodService.queryBookByEachType();
        for(GoodsInfo set:goodsInfos){
            System.out.println(set);
        }
    }

    @Test
    public void testUpGoods(){
        GoodsInfo goodsInfo=new GoodsInfo();
        goodsInfo.setPossesserId(1);
        goodsInfo.setUpTime(new Date());
        goodsInfo.setType("科学与技术");
        goodsInfo.setGoodsName("test");
        goodsInfo.setDetail("testdetail");
        goodsInfo.setRemainNumber(1);
        goodsInfo.setPrice(-1);
        goodsInfo.setImgDir("123");
        goodsInfo.setAddr("123");
        goodService.upGoods(goodsInfo);
    }

    @Test
    public void testUpdateGoodsPrice(){
        System.out.println(goodService.updateGoodsPrice(121,12));
    }

    @Test
    public void testDownGoods(){
       goodService.downGoods(121,1);
    }
}
