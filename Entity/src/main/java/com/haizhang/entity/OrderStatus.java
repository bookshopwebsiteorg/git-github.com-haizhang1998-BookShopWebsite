package com.haizhang.entity;
import java.util.Date;


/**
 * @author Austin
 * @date 2019/5/25
 * 订单状态
 */
public class OrderStatus{
    private Long orderId;     //订单id
    private int status;   //状态  1：未付款  2：已付款，未发货  3：已发货，未确认  4；交易成功   5：交易取消  6：已经评价   // 7:提醒发货
    private int backpay;      //退款/退货标记位   0:未申请  1：退款申请  2:退货申请   3：退款成功  4：不同意退款  5：同意退货   6：不同退货   7：等待卖家退货审核  8：退货成功  9：退货失败
    private Date createTime;  //订单创建时间
    private Date paymentTime; //付款时间
    private Date consignTime; //发货时间
    private Date endTime;     //交易完成时间
    private Date closeTime;   //交易关闭时间
    private Date commentTime; //评价时间

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getPaymentTime() {
        return paymentTime;
    }

    public void setPaymentTime(Date paymentTime) {
        this.paymentTime = paymentTime;
    }

    public Date getConsignTime() {
        return consignTime;
    }

    public void setConsignTime(Date consignTime) {
        this.consignTime = consignTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Date getCloseTime() {
        return closeTime;
    }

    public void setCloseTime(Date closeTime) {
        this.closeTime = closeTime;
    }

    public Date getCommentTime() {
        return commentTime;
    }

    public void setCommentTime(Date commentTime) {
        this.commentTime = commentTime;
    }

    public int getBackpay() {
        return backpay;
    }

    public void setBackpay(int backpay) {
        this.backpay = backpay;
    }

    @Override
    public String toString() {
        return "OrderStatus{" +
                "orderId=" + orderId +
                ", status=" + status +
                ", createTime=" + createTime +
                ", paymentTime=" + paymentTime +
                ", consignTime=" + consignTime +
                ", endTime=" + endTime +
                ", closeTime=" + closeTime +
                ", commentTime=" + commentTime +
                '}';
    }
}
