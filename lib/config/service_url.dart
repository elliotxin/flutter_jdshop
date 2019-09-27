// const serviceUrl = 'http://v.jspang.com:8088/baixing/';
// const serviceUrl = 'http://jd.itying.com/';
const serviceUrl = 'https://wxmini.baixingliangfan.cn/baixing/';
const servicePath = {
  'homePageContext': serviceUrl + 'wxmini/homePageContent', // 商家首页信息
  'homePageBelowConten': serviceUrl + 'wxmini/homePageBelowConten', //商城首页热卖商品拉取
  'getCategory': serviceUrl + 'wxmini/getCategory', //商品类别信息
  'getMallGoods': serviceUrl + 'wxmini/getMallGoods', //商品分类的商品列表
  'getGoodDetailById': serviceUrl + 'wxmini/getGoodDetailById', //商品详细信息列表
};
const home_page_content = 'homePageContent';
const home_page_tip = 'getHomePageTip';
const home_page_below_conten = 'homePageBelowConten';
const category_page_content = 'getCategory';
const category_page_small_category = 'getMallGoods';
const goods_goods_detail = 'getGoodsInfo';
