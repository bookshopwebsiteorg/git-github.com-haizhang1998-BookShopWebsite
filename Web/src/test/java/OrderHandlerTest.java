import com.bookShop.controller.OrderHandler;
import com.bookShop.service.OrderService;
import org.junit.Test;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.web.servlet.view.InternalResourceView;

import javax.annotation.Resource;

import static org.junit.Assert.*;
import static org.springframework.test.web.servlet.setup.MockMvcBuilders.standaloneSetup;

/**
 * @author Austin
 * @date 2019/6/1
 */
public class OrderHandlerTest extends BaseTest {
    @Resource
    OrderService orderServiceImpl;

    @Test
    public void queryAllUserOrderByUserId() throws Exception{
        OrderHandler orderHandler = new OrderHandler(orderServiceImpl);
        MockMvc mockMvc=standaloneSetup(orderHandler).setSingleView(new InternalResourceView("/jsp/userOrderManage.jsp")).build();
        String res=commonMockMethod("/order/queryAllUserOrderByUserId");
        System.out.println(res);
    }

    @Test
    public void queryAllUserOrderDetail() {
    }

    @Test
    public void queryUserOrderByStatus() {
    }

    @Test
    public void deleteUserOrder() {
    }

    @Test
    public void modifyUserOrderStatus() {
    }

    @Test
    public void modifyUserOrderBybackpay() {
    }

    @Test
    public void queryAllUserOrderDetail1() {
    }

    @Test
    public void queryAllManagerOrderByUserId() {
    }

    @Test
    public void queryManagerOrderByStatus() {
    }

    @Test
    public void modifyManagerOrderStatus() {
    }

    @Test
    public void modifyManagerOrderBybackpay() {
    }

    @Test
    public void deleteManagerOrder() {
    }
}