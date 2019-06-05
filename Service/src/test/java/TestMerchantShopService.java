import com.bookShop.service.MerchantShopService;
import com.haizhang.entity.MerchantShop;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * 测试足迹
 */
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional()
@TransactionConfiguration(transactionManager = "transactionManager",defaultRollback = true)
@ContextConfiguration("classpath:spring-aop.xml")


public class TestMerchantShopService {
    @Resource
    MerchantShopService merchantShopService;

    @Test
    public void getShopByName(){
        List<MerchantShop> merchantShop=merchantShopService.getShopByName("爱");
        for(MerchantShop m:merchantShop)
            System.out.println(m);
    }
}
