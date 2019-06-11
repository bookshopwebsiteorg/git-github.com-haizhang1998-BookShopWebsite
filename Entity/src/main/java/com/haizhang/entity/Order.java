package com.haizhang.entity;
import java.util.List;

/**
 * @author Austin
 * @date 2019/5/25
 * 订单
 */
public class Order {
    private Long orderId;           //订单编号
    private double actualPay;         //实付金额
    private int paymentType;    //支付类型  1、微信支付  2：支付宝支付  3：银行卡支付
    private double postFee;      //邮费
    private int userId;            //用户编号
    private String buyerMessage;    //买家留言
    private int buyerRate = 0;      //买家是否评价  0未评价  1已评价
    private String receiver;        //收货人姓名
    private String receiverMobile;  //收货人手机
    private String receiverAddress;  //收货地址
    private String receiverZip;      //邮政编码

    private OrderStatus orderStatus;
    private List<OrderDetail> orderDetails;

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public double getActualPay() {
        return actualPay;
    }

    public void setActualPay(double actualPay) {
        this.actualPay = actualPay;
    }

    public Integer getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(Integer paymentType) {
        this.paymentType = paymentType;
    }

    public Double getPostFee() {
        return postFee;
    }

    public void setPostFee(Double postFee) {
        this.postFee = postFee;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getBuyerMessage() {
        return buyerMessage;
    }

    public void setBuyerMessage(String buyerMessage) {
        this.buyerMessage = buyerMessage;
    }

    public int getBuyerRate() {
        return buyerRate;
    }

    public void setBuyerRate(int buyerRate) {
        this.buyerRate = buyerRate;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public String getReceiverMobile() {
        return receiverMobile;
    }

    public void setReceiverMobile(String receiverMobile) {
        this.receiverMobile = receiverMobile;
    }

    public String getReceiverAddress() {
        return receiverAddress;
    }

    public void setReceiverAddress(String receiverAddress) {
        this.receiverAddress = receiverAddress;
    }

    public String getReceiverZip() {
        return receiverZip;
    }

    public void setReceiverZip(String receiverZip) {
        this.receiverZip = receiverZip;
    }

    public OrderStatus getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(OrderStatus orderStatus) {
        this.orderStatus = orderStatus;
    }

    public List<OrderDetail> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderDetail> orderDetails) {
        this.orderDetails = orderDetails;
    }


    @Override
    public String toString() {
        return "Order{" +
                "orderId=" + orderId +
                ", actualPay=" + actualPay +
                ", paymentType=" + paymentType +
                ", postFee=" + postFee +
                ", userId=" + userId +
                ", buyerMessage='" + buyerMessage + '\'' +
                ", buyerRate=" + buyerRate +
                ", receiver='" + receiver + '\'' +
                ", receiverMobile='" + receiverMobile + '\'' +
                ", receiverAddress='" + receiverAddress + '\'' +
                ", receiverZip='" + receiverZip + '\'' +
                ", orderStatus=" + orderStatus +
                ", orderDetails=" + orderDetails +
                '}';
    }
}
