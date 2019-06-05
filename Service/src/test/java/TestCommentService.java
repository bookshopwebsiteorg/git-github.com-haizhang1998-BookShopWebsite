import com.bookShop.service.CommentService;
import com.haizhang.entity.CommentItem;
import org.apache.ibatis.annotations.Param;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.transaction.TransactionConfiguration;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.Date;
import java.util.List;
/**
 * 测试时间：2019/5/6
 * 测试人员: 黄骏杰
 * 测试货物相关的service接口
 */
@RunWith(SpringJUnit4ClassRunner.class)
@Transactional()
@TransactionConfiguration(transactionManager = "transactionManager",defaultRollback = true)
@ContextConfiguration("classpath:spring-aop.xml")

public class TestCommentService {
    @Resource
    CommentService commentService;
    //获取商品所有的评价
    @Test
    public void getAllCommentOfGood(){
          List<CommentItem> commentItems=commentService.getAllCommentOfGood(2);
          for(CommentItem commentItem:commentItems){
              System.out.println(commentItem);
          }
    }
//
//    //发送评价
      @Test
    public void sendCommentItem(){

          CommentItem commentItem=new CommentItem();
          commentItem.setId(1);
          commentItem.setGoodsId(19);
          commentItem.setCommentDetail("excellent book");
          commentItem.setScore(4);
          commentItem.setTime(new Date());
          commentService.sendCommentItem(commentItem);

      }
//
//    //删除评价
    @Test
    public void deleteCommentItem(){
          commentService.deleteCommentItem(1,19);
    }

//    //得到某一个用户对商品的评价，可以判断是否追加评价
    @Test
    public void  getOneUserComment(){
          commentService.getOneUserComment(1,19);
    }



}
