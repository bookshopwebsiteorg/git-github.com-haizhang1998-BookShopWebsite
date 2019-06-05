package com.bookShop.service;

import com.haizhang.entity.CommentItem;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CommentService {

    //获取商品所有的评价
    public List<CommentItem> getAllCommentOfGood(int goodsId);

    //发送评价
    public boolean sendCommentItem(CommentItem commentItem);

    //删除评价

    public boolean deleteCommentItem(int userId, int goodsId);

    //得到某一个用户对商品的评价，可以判断是否追加评价
    public CommentItem  getOneUserComment(int userId, int goodsId);


}
