package com.haizhang.DTO;

/**
 * @author Austin
 * @date 2019/5/30
 * 订单的传输数据
 */
public class OrderDTO {
    private double actualPay;         //实付金额
    private int paymentType;    //支付类型  1、微信支付  2：支付宝支付  3：银行卡支付   4、货到付款
    private double postFee;      //邮费
    private String buyerMessage;    //买家留言
    private String receiver;        //收货人姓名
    private String receiverMobile;  //收货人手机
    private String receiverAddress;  //收货地址
    private String receiverZip;      //邮政编码
    private int userId;            //用户编号

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getActualPay() {
        return actualPay;
    }

    public void setActualPay(double actualPay) {
        this.actualPay = actualPay;
    }

    public int getPaymentType() {
        return paymentType;
    }

    public void setPaymentType(int paymentType) {
        this.paymentType = paymentType;
    }

    public double getPostFee() {
        return postFee;
    }

    public void setPostFee(double postFee) {
        this.postFee = postFee;
    }

    public String getBuyerMessage() {
        return buyerMessage;
    }

    public void setBuyerMessage(String buyerMessage) {
        this.buyerMessage = buyerMessage;
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


}
