//
//  Colors.swift
//  testJSON
//
//  Created by oleh yeroshkin on 13.06.2024.
//

import Foundation


enum ColorNameEng: String, CaseIterable {
    case black = "黑色"
    case black2 = "黑颜色"

    case  yellow = "黄色"

    case green = "绿色"
    case green2 = "绿颜色"

    case purple = "紫色"
    case purple2 = "紫颜色"

    case pink = "粉红色"
    case pink2 = "粉红"

    case red = "红色"
    case blue = "蓝色"
    case golden = "金色"
    case orange = "橘色"
    case creamyWhite = "米白"
    case apricot = "杏色"
    case noName = "No name"

    case white = "白色"
    case milkyWhite = "奶白"
    case coffeeWhite = "奶咖色"

    case gray = "灰色"
    case lightPurple = "淡紫"
    case mingGreen = "薄荷绿"
    case champane = "香槟"
    case brown = "咖啡"
    case beige = "肤色"
    case beige2 = "卡其色"

    //    黑色, 黑，黑颜色  black
    //              黄色，黄，黄颜色 yellow
    //              绿色，绿，绿颜色 green
    //              紫色，  紫， 紫颜色 purple
    //              粉红色，粉， 粉红  pink
    //              红色， 红，红颜色 red
    //              蓝色， 蓝， 蓝颜色blue
    //              金色 ，  金黄色，金，金颜色golden
    //              橘色， 橘，橘颜色 orange
    //              米白 ，米白色creamy white
    //              杏色 ，杏，杏颜色apricot
    var colorNameEng: String {
        switch self {
        case .black, .black2:
            return "Black"
        case .yellow:
            return "Yellow"
        case .green, .green2:
            return "Green"
        case .purple, .purple2:
            return "Purple"
        case .pink, .pink2:
            return "Pink"
        case .red:
            return "Red"
        case .blue:
            return "Blue"
        case .golden:
            return "Golden"
        case .orange:
            return "Orange"
        case .creamyWhite:
            return "CreamyWhite"
        case .apricot:
            return "Apricot"
        case .white:
            return "White"
        case .gray:
            return "Gray"
        case .milkyWhite:
            return "Milky white"
        case .coffeeWhite:
            return "Milk coffee"
        case .lightPurple:
            return "Light purple"
        case .mingGreen:
            return "Mint green"
        case .champane:
            return "Champane"
        case .brown:
            return "Brown"
        case .beige:
            return "Beige"
        case .beige2:
            return "Beige"
        case .noName:
            return "No name"
        }
    }
}
//
//{
//  "code": 200,
//  "msg": "success",
//  "data": {
//    "item_id": 742720370270,
//    "product_url": "",
//    "title": "高质量无痕裸感内衣女一片式光面小胸聚拢通勤无钢圈舒适文胸罩薄",
//    "category_id": 124196008,
//    "root_category_id": 312,
//    "currency": "CNY",
//    "offer_unit": "件",
//    "product_props": [
//      {
//        "功能": "聚拢,无痕,透气,上托,调整型,舒适,侧收,收副乳,大胸显小"
//      },
//      {
//        "货号": "8871#"
//      },
//      {
//        "品牌": "竹林沁峰"
//      },
//      {
//        "主面料成分": "锦纶"
//      },
//      {
//        "面料名称": "锦纶"
//      },
//      {
//        "里料成分": "氨纶"
//      },
//      {
//        "里料成分含量": "30%以下"
//      },
//      {
//        "款式": "传统型"
//      },
//      {
//        "产地": "普宁"
//      },
//      {
//        "是否有钢圈": "无钢圈"
//      },
//      {
//        "罩杯型": "三角杯"
//      },
//      {
//        "模杯类型": "薄模杯"
//      },
//      {
//        "肩带类型": "可拆卸双肩带"
//      },
//      {
//        "排扣类型": "后双排搭扣"
//      },
//      {
//        "颜色": "香槟,肤色,咖啡,黑色,红色"
//      },
//      {
//        "尺码": "S 【建议80-95斤】,M 【建议96-115斤】,L 【建议116-135斤】,XL 【建议135-160斤】"
//      },
//      {
//        "是否跨境出口专供货源": "是"
//      },
//      {
//        "上市时间": "2023年秋季"
//      },
//      {
//        "适用年龄段": "青年（18-40周岁）"
//      },
//      {
//        "主面料成分含量": "80%（含）-90%（不含）"
//      },
//      {
//        "风格": "简约休闲"
//      }
//    ],
//    "main_imgs": [
//      "https://cbu01.alicdn.com/img/ibank/O1CN01dB4uCH1bPoTuF6f8S_!!2208538513458-0-cib.jpg",
//      "https://cbu01.alicdn.com/img/ibank/O1CN01XHppy21bPoTwIpVf6_!!2208538513458-0-cib.jpg",
//      "https://cbu01.alicdn.com/img/ibank/O1CN01dIUVdQ1bPoTzPLstZ_!!2208538513458-0-cib.jpg",
//      "https://cbu01.alicdn.com/img/ibank/O1CN01J95Abh1bPoTzPN1Z0_!!2208538513458-0-cib.jpg",
//      "https://cbu01.alicdn.com/img/ibank/O1CN01qxspor1bPoTw2Y8no_!!2208538513458-0-cib.jpg",
//      "https://cbu01.alicdn.com/img/ibank/O1CN0104pzxd1bPoTvy2jHq_!!2208538513458-0-cib.jpg",
//      "https://cbu01.alicdn.com/img/ibank/O1CN01eskz6X1bPoTqbqGts_!!2208538513458-0-cib.jpg",
//      "https://cbu01.alicdn.com/img/ibank/O1CN01Dcu8h81bPoTzP9GHB_!!2208538513458-0-cib.jpg",
//      "https://cbu01.alicdn.com/img/ibank/O1CN013PEJCw1bPoTt7YsEB_!!2208538513458-0-cib.jpg"
//    ],
//    "video_url": "",
//    "detail_url": "https://air.1688.com/pages/od/app-desc/d7p56fw2w/index.html?url=https://itemcdn.tmall.com/1688offer/icoss4283449243db9ff2838d0530ff&offerId=742720370270&sellerLoginId=竹林沁峰贸易有限公司",
//    "sale_count": "702",
//    "sale_info": {
//      "sale_quantity_90days": "702"
//    },
//    "price_info": {
//      "price": "16.50",
//      "origin_price": null,
//      "price_min": "16.50",
//      "price_max": "16.50",
//      "origin_price_min": "16.50",
//      "origin_price_max": "16.50",
//      "discount_price": ""
//    },
//    "tiered_price_info": {
//      "prices": [
//        {
//          "price": "16.50",
//          "beginAmount": "2"
//        }
//      ],
//      "begin_num": "2"
//    },
//    "mixed_batch": {
//      "mix_num": "5",
//      "mix_begin": "0",
//      "mix_amount": "80",
//      "shop_mix_num": "2147483647"
//    },
//    "shop_info": {
//      "shop_name": "普宁市竹林沁峰贸易有限公司",
//      "shop_url": "https://winport.m.1688.com/page/index.html?memberId=b2b-220853851345875490",
//      "seller_login_id": "竹林沁峰贸易有限公司",
//      "seller_user_id": "2208538513458",
//      "seller_member_id": "b2b-220853851345875490"
//    },
//    "delivery_info": {
//      "location": "广东省揭阳市",
//      "location_code": "32043520",
//      "delivery_fee": 3.8,
//      "unit_weight": 0.5,
//      "template_id": "15275541"
//    },
//    "sku_price_scale": "￥16.50",
//    "sku_price_scale_original": "￥16.50",
//    "sku_price_range": {
//      "stock": "17311",
//      "begin_num": "2",
//      "mix_param": {
//        "mixNum": "5",
//        "mixBegin": "0",
//        "mixAmount": "80",
//        "shopMixNum": "2147483647",
//        "supportMix": "true"
//      },
//      "sku_param": [
//        {
//          "price": "16.50",
//          "beginAmount": "2"
//        }
//      ]
//    },
//    "sku_props": [
//      {
//        "pid": "0",
//        "prop_name": "颜色",
//        "values": [
//          {
//            "vid": "0",
//            "name": "香槟",
//            "imageUrl": "https://cbu01.alicdn.com/img/ibank/O1CN0104pzxd1bPoTvy2jHq_!!2208538513458-0-cib.jpg"
//          },
//          {
//            "vid": "1",
//            "name": "肤色",
//            "imageUrl": "https://cbu01.alicdn.com/img/ibank/O1CN013PEJCw1bPoTt7YsEB_!!2208538513458-0-cib.jpg"
//          },
//          {
//            "vid": "2",
//            "name": "咖啡",
//            "imageUrl": "https://cbu01.alicdn.com/img/ibank/O1CN0161QfJP1bPoTuCtEYT_!!2208538513458-0-cib.jpg"
//          },
//          {
//            "vid": "3",
//            "name": "黑色",
//            "imageUrl": "https://cbu01.alicdn.com/img/ibank/O1CN01Dcu8h81bPoTzP9GHB_!!2208538513458-0-cib.jpg"
//          },
//          {
//            "vid": "4",
//            "name": "红色",
//            "imageUrl": "https://cbu01.alicdn.com/img/ibank/O1CN01eskz6X1bPoTqbqGts_!!2208538513458-0-cib.jpg"
//          }
//        ]
//      },
//      {
//        "pid": "1",
//        "prop_name": "尺码",
//        "values": [
//          {
//            "vid": "0",
//            "name": "S 【建议80-95斤】",
//            "imageUrl": ""
//          },
//          {
//            "vid": "1",
//            "name": "M 【建议96-115斤】",
//            "imageUrl": ""
//          },
//          {
//            "vid": "2",
//            "name": "L 【建议116-135斤】",
//            "imageUrl": ""
//          },
//          {
//            "vid": "3",
//            "name": "XL 【建议135-160斤】",
//            "imageUrl": ""
//          }
//        ]
//      }
//    ],
//    "skus": [
//      {
//        "skuid": "5124431369153",
//        "specid": "69aceb247925da60b6633c95114085cc",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "872",
//        "props_ids": "0:1;1:1",
//        "props_names": "肤色;M 【建议96-115斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369155",
//        "specid": "ce21a7b430c26399f24eaf59b291a0b3",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "886",
//        "props_ids": "0:1;1:3",
//        "props_names": "肤色;XL 【建议135-160斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369162",
//        "specid": "5705fbc778bde946d75051766ed684f1",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "882",
//        "props_ids": "0:3;1:2",
//        "props_names": "黑色;L 【建议116-135斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369159",
//        "specid": "06d0fa4765dfd47cba953d8c2d8b2a82",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "886",
//        "props_ids": "0:2;1:3",
//        "props_names": "咖啡;XL 【建议135-160斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369163",
//        "specid": "b4244dbae1622b443d44173a6a80b4e4",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "886",
//        "props_ids": "0:3;1:3",
//        "props_names": "黑色;XL 【建议135-160斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369150",
//        "specid": "2d4292b43cd05a7d354dd4a2fd9f5534",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "887",
//        "props_ids": "0:0;1:2",
//        "props_names": "香槟;L 【建议116-135斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369151",
//        "specid": "fdb77e8d2a93a352d9e0ae1d35fb80df",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "885",
//        "props_ids": "0:0;1:3",
//        "props_names": "香槟;XL 【建议135-160斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369148",
//        "specid": "0016bdcbf345a01085d4cd63d556785c",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "541",
//        "props_ids": "0:0;1:0",
//        "props_names": "香槟;S 【建议80-95斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369158",
//        "specid": "d0a6b35caa900b1d999df5fc3cfc134a",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "888",
//        "props_ids": "0:2;1:2",
//        "props_names": "咖啡;L 【建议116-135斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369157",
//        "specid": "b358fb66e3267a313d0e2844c4442a8e",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "882",
//        "props_ids": "0:2;1:1",
//        "props_names": "咖啡;M 【建议96-115斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369161",
//        "specid": "3d15686fcc7fd420de60f3dc452683fa",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "871",
//        "props_ids": "0:3;1:1",
//        "props_names": "黑色;M 【建议96-115斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369166",
//        "specid": "12a89ebaf5e29d3e44c88ee3238d7751",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "886",
//        "props_ids": "0:4;1:2",
//        "props_names": "红色;L 【建议116-135斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369152",
//        "specid": "c117d004143b9442a7612daf7ba22460",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "883",
//        "props_ids": "0:1;1:0",
//        "props_names": "肤色;S 【建议80-95斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369156",
//        "specid": "4ed5caf0593949bc44ab8ba97482fc5a",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "888",
//        "props_ids": "0:2;1:0",
//        "props_names": "咖啡;S 【建议80-95斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369149",
//        "specid": "abe63000e80d0fec7bd59d87c5a18631",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "867",
//        "props_ids": "0:0;1:1",
//        "props_names": "香槟;M 【建议96-115斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369167",
//        "specid": "734a66b6d7db6d0a24d755bf3c849af2",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "887",
//        "props_ids": "0:4;1:3",
//        "props_names": "红色;XL 【建议135-160斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369154",
//        "specid": "6e0bcf53975c20c1207263965895dda4",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "888",
//        "props_ids": "0:1;1:2",
//        "props_names": "肤色;L 【建议116-135斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369160",
//        "specid": "edc13aeb82a7af609fa7feb8ec40c980",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "882",
//        "props_ids": "0:3;1:0",
//        "props_names": "黑色;S 【建议80-95斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369165",
//        "specid": "c73f34a36724f697d5b4cc8ba734d82b",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "878",
//        "props_ids": "0:4;1:1",
//        "props_names": "红色;M 【建议96-115斤】",
//        "sale_count": "0"
//      },
//      {
//        "skuid": "5124431369164",
//        "specid": "f511863a148f2e8c82ec7d7130a4755b",
//        "sale_price": "16.50",
//        "origin_price": "16.50",
//        "stock": "886",
//        "props_ids": "0:4;1:0",
//        "props_names": "红色;S 【建议80-95斤】",
//        "sale_count": "0"
//      }
//    ],
//    "is_sold_out": false,
//    "stock": 17311,
//    "promotions": [
//      {
//        "type": "PLATFORM_COUPON",
//        "title": "每100减10|跨店",
//        "content": "每满100减10，可跨店使用",
//        "end_time": "2024-06-18 23:59:59",
//        "type_name": "采购津贴",
//        "start_time": "2024-06-17 00:00:00",
//        "promotion_id": "11619864329"
//      },
//      {
//        "type": "MIX_WHOLESALE",
//        "title": "5件混批",
//        "content": "本店部分商品满80元或5件可混批采购",
//        "end_time": null,
//        "type_name": "混批",
//        "start_time": null,
//        "promotion_id": ""
//      }
//    ]
//  }
//}
