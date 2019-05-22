import com.bookShop.service.EnshrineService;
import com.haizhang.entity.EnshrineItem;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@Transactional()
@TransactionConfiguration(transactionManager = "transactionManager",defaultRollback = true)
@ContextConfiguration("classpath:spring-aop.xml")

public class TestEnshrineService {

    @Resource
    EnshrineService enshrineService;

    @Test
    //修改收藏商品的Valid状态 （下架货物时直接为1，不许传参数，状态不可逆）
    public void updateValidStatus(){
           enshrineService.updateValidStatus(7);
    }

    /**
     *修改商品的降价状态
     * @return
     */
    @Test
    public void  updatePriceFlagStatus(){
        System.out.println(enshrineService.updatePriceFlagStatus(1,-1,7));
    }


    //获取收藏商品
    @Test
    public void getAllEnshrineOfGood(){
        List<EnshrineItem> enshrineItems= enshrineService.getAllEnshrineGood(1);
        for(EnshrineItem enshrineItem:enshrineItems){
            System.out.println(enshrineItem);
        }

    }
    //
//    //添加收藏商品
    @Test
    public void addEnshrineGood(){
        /*EnshrineItem enshrineItem=new EnshrineItem();
        enshrineItem.setId(2);
        enshrineItem.setGoodsId(7);
        enshrineItem.setValidFlag(0);
        enshrineItem.setDecreaseFlag(0);
        enshrineService.addEnshrineGood(enshrineItem);*/

        enshrineService.addEnshrineGood(2,8);

    }
    //
//    //删除收藏商品
    @Test
    public void deleteEnshrineItem(){
        enshrineService.removeEnshrineGood(1,7);
    }

    @Test
    public void queryIsHaveId(){
        enshrineService.queryIsHaveId(16,1);
    }
}
