import com.bookShop.service.MerchantService;
import com.haizhang.entity.MerchantShop;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.io.File;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@Transactional()
@TransactionConfiguration(transactionManager = "transactionManager",defaultRollback = true)
@ContextConfiguration("classpath:spring-aop.xml")
public class TestMerchantService {
    @Resource
    MerchantService merchantServiceImpl;
//    //注册商家
//    public boolean regMerchant(int userId, String addr, String shopLogo, String shopName);
//    //得到商铺信息
//    public MerchantShop getShopInfoByName(String ShopName) ;
//    //得到商铺信息by userId
//    public MerchantShop getShopInfoByMerchantId(int userId);
    //得到所有的商铺
    @Test
    public void getAllShop(){
        List<MerchantShop> merchantShops=merchantServiceImpl.getAllShop();
        for(MerchantShop m:merchantShops){
            System.out.println(m);
        }
    }



//    //上架货物
//    public boolean upGoods(GoodsInfo goodsInfo);

//    //发货
//    public boolean sendGood(int goodsId, int userId, int merchantId, int payFlag);
//
//    //下架货物
//    public boolean downGoods(int goodsId, int userId);
//
//    //查询所有订单
//    public List<OrderItem> getAllUserOrder(int merchantId);

//    //查询热销量前x的店铺
    @Test
    public void getRankShop(){
        List<MerchantShop> merchantShops=merchantServiceImpl.getRankShop(10);
        for(MerchantShop m:merchantShops){
            System.out.println(m);
        }
    }

    @Test
    public void testQueryMerchantShop(){
        System.out.println(merchantServiceImpl.getShopInfoByMerchantId(1));
    }

    @Test
    public void testQueryMerchantShopByName(){
        System.out.println(merchantServiceImpl.getShopInfoByName("爱书"));
    }

    @Test
    public void testUpdateShopInfo(){
        MerchantShop merchantShop =new MerchantShop();
        merchantShop.setMerchantId(6);
        merchantShop.setShopName("南岸书城");
        System.out.println(merchantServiceImpl.updateShopInfo(merchantShop));
    }

}
