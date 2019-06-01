import com.bookShop.service.FootPrintService;
import com.haizhang.entity.FootPrintItem;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 测试足迹
 */
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional()
@TransactionConfiguration(transactionManager = "transactionManager",defaultRollback = true)
@ContextConfiguration("classpath:spring-aop.xml")

public class TestFootPrintService {
    @Resource
    FootPrintService footPrintService;

    @Test
    public void getAllFootPrint(){
        Map<String,List<FootPrintItem>> footPrintItem=footPrintService.getAllFootPrint(21);
        for(Map.Entry<String, List<FootPrintItem>> footPrintItemEntry:footPrintItem.entrySet()){
            System.out.println(footPrintItemEntry.getKey()+":");
            System.out.println(footPrintItemEntry.getValue());
        }

    }

    @Test
    public void addFootPrint(){
        FootPrintItem footPrintItem=new FootPrintItem();
        footPrintItem.setGoodsId(11);
        footPrintItem.setId(2);
    }

    @Test
    public void delFootPrint(){
        System.out.println(footPrintService.delFootPrint(1,11));
    }
}
