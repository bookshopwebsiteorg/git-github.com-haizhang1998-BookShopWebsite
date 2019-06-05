import com.bookShop.service.CommentService;
import com.bookShop.service.OrderService;
import com.haizhang.entity.Order;
import com.haizhang.entity.OrderDetail;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: 71479
 * Date: 2019/6/1
 * Time: 21:21
 * Description: No Description
 */
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional()
@TransactionConfiguration(transactionManager = "transactionManager",defaultRollback = true)
@ContextConfiguration("classpath:spring-aop.xml")
public class TestOrderServiceJ {

    @Resource
    OrderService orderService;

    //通过查询order_id查询有多少个OrderDetail(goodsId)，查询表为tb_order_detail
    @Test
    public void queryAllUserOrderDetail()
    {
         Order order=orderService.queryAllUserOrderDetail(992320901993336213L);
         order.toString();

    }
   /* @Test
    public void queryOrerDetailByOrderId(){
        List<OrderDetail> orderDetailList=orderService.queryOrerDetailByOrderId(992320901993336213L);
        for(OrderDetail orderDetail:orderDetailList){
            System.out.println(orderDetail);
        }
    }

    @Test
    public void changeBuyerRate(){
        boolean a=orderService.changeBuyerRate(992320901993336213L);
        System.out.println(a);
    }*/

    @Test
    public void queryGoodIdHaveNotRateByOrderId(){
        List<String> list=orderService.queryGoodIdHaveNotRateByOrderId(992320901993336213L);
        for(String lis:list){
            System.out.println(lis);
        }
    }

    @Test
    public void queryOrderIdByGoodsId(){
        long a=orderService.queryOrderIdByGoodsId(32);
        System.out.println(a);
    }

    @Test
    public void queryOrderDetailByGoodsId(){
        /*OrderDetail detail=orderService.queryOrderDetailByGoodsId(32,);
        detail.toString();*/
    }
}
