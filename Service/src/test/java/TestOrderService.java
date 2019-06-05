import com.bookShop.service.OrderService;
import com.bookShop.utils.IdWorker;
import com.haizhang.DTO.OrderDTO;
import com.haizhang.DTO.OrderDetailDTO;
import com.haizhang.entity.Order;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

/**
 * @author Austin
 * @date 2019/6/1
 */
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional()
@TransactionConfiguration(transactionManager = "transactionManager",defaultRollback = true)
@ContextConfiguration("classpath:spring-aop.xml")
public class TestOrderService {
    @Resource
    OrderService orderService;

    @Test
    public void queryAllUserOrderByUserId() {
        int userId = 5;
        List<Order> orderList = orderService.queryAllUserOrderByUserId(5);
        for(Order order:orderList){
            System.out.println(order.toString());
        }
    }

    @Test
    public void queryUserOrderByStatus() {
        int userId = 5;
        int status = 1; //1：未付款  2：已付款，未发货  3：已发货，未确认  4；交易成功   5：交易取消  6：已经评价   // 7:提醒发货
        List<Order> orderList = orderService.queryUserOrderByStatus(userId,status);
        for(Order order:orderList){
            System.out.println(order.toString());
        }
    }

    @Test
    public void queryAllUserOrderDetail() {
        long orderId = 1134344003277594624l;
        Order order = orderService.queryAllUserOrderDetail(orderId);
        System.out.println(order.toString());

    }

    @Test
    public void deleteUserOrder() {
        long orderId = 1134344003277594624l;
        boolean flag = orderService.deleteUserOrder(orderId);
        System.out.println(flag);
    }

    @Test
    public void modifyUserOrderStatus() {
        long orderId = 1134344003277594624l;
        int stauts = 3;
        boolean flag = orderService.modifyUserOrderStatus(orderId,stauts);
        System.out.println(flag);
    }

    @Test
    public void modifyUserOrderBybackpay() {
        long orderId = 1134344003277594624l;
        int stauts = 3;
        boolean flag = orderService.modifyUserOrderBybackpay(orderId,stauts);
        System.out.println(flag);
    }

    @Test
    public void createOrder() {
       int userId = 5;

        OrderDTO orderDTO = new OrderDTO();
        orderDTO.setActualPay(20);
        orderDTO.setPaymentType(1);
        orderDTO.setPostFee(10);
        orderDTO.setBuyerMessage("hahha");
        orderDTO.setReceiver("austin");
        orderDTO.setReceiverAddress("吉林" );
        orderDTO.setReceiverMobile("13726278887");
        orderDTO.setReceiverZip("123456");
        orderDTO.setUserId(userId);

        List<OrderDetailDTO> orderDetailDTOList = new ArrayList<>();

        OrderDetailDTO orderDetailDTO1 = new OrderDetailDTO();
        orderDetailDTO1.setNum(2);
        orderDetailDTO1.setGoodsId(3);
        orderDetailDTOList.add(orderDetailDTO1);

        OrderDetailDTO orderDetailDTO2 = new OrderDetailDTO();
        orderDetailDTO2.setNum(1);
        orderDetailDTO2.setGoodsId(4);
        orderDetailDTOList.add(orderDetailDTO2);

        OrderDetailDTO orderDetailDTO3 = new OrderDetailDTO();
        orderDetailDTO3.setNum(1);
        orderDetailDTO3.setGoodsId(2);
        orderDetailDTOList.add(orderDetailDTO3);

        boolean flag = orderService.createOrder(orderDTO,orderDetailDTOList);
        System.out.println(flag);
    }


    @Test
    public void queryAllManagerOrderByUserId() {
        int merchantId = 1;
        List<Order> orderList = orderService.queryAllManagerOrderByUserId(merchantId);
        for(Order order:orderList){
            System.out.println(order.toString());
        }
    }

    @Test
    public void queryManagerOrderByStatus() {
        int merchantId = 1;
        int status = 2;
        List<Order> orderList = orderService.queryManagerOrderByStatus(merchantId,status);
        for(Order order:orderList){
            System.out.println(order.toString());
        }
    }

    @Test
    public void updatePaymentTime() {
        long orderId = 1134344003277594624l;
        boolean flag = orderService.updatePaymentTime(orderId);
        System.out.println(flag);
    }

    @Test
    public void updateConsignTime() {
        long orderId = 1134344003277594624l;
        boolean flag = orderService.updateConsignTime(orderId);
        System.out.println(flag);
    }

    @Test
    public void updateEndTime() {
        long orderId = 1134344003277594624l;
        boolean flag = orderService.updateEndTime(orderId);
        System.out.println(flag);
    }

    @Test
    public void updateCloseTime() {
        long orderId = 1134344003277594624l;
        boolean flag = orderService.updateCloseTime(orderId);
        System.out.println(flag);
    }

    @Test
    public void updateCommentTime() {
        long orderId = 1134344003277594624l;
        boolean flag = orderService.updateCommentTime(orderId);
        System.out.println(flag);
    }
}