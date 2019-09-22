<style>
    html, body, .container {
        padding: 0;
        font-size: 12px;
    }
    .banner_content {
        padding-top: 5px;
        border: none;
    }

    .fixed_banner {
        position: absolute;
        padding: 5px 0px;
        border-radius: 5px;
        background-color: white;
        width: 90%;
        height: 28%;
        right: 20px;
        bottom: 45px;
    }
    .banner_image {
        height: 60%;
        
    }
    .tag_edit {
        color: gray;
        background-color: #eaecf0;
    }
    .filter_box {
        background-color: white;
        padding: 10px 0px;
        z-index: 200;
        cursor: pointer;
        position: fixed;
        bottom: 0;
        left: 0;
        width: 100%;
        /* height: 60%; */
        border-radius: 15px 15px 0px 0px;
        font-size: 13px;
    }
    .filter_option a i {
        color : #67757c;
    }
    .filter_result_box {
        width: 100%;
        cursor: pointer;
        position: fixed;
        padding: 5px 0px;
        height: 55px;
    }
    .filter_overlay {
        height:100%;
        width:100%;
        position: absolute;
        z-index: 100;
        top: 0;
        left: 0;
        background-color: black !important;
        opacity: 0.3;
    }
    .filter_result_option {
        z-index: 200;
        opacity: 1;
        cursor: pointer;
        position: fixed;
        border-radius: 5px;
        text-align: center;
        font-size: 13px;
        width: 100%;
    }
    .filter_option_item{
        background-color: white;
        padding: 4px 5px;
        color: #67757c;
    }
    .filter_header {
        padding: 0px 10px;
    }
    .filter_header .row .col-2 a i {
        font-weight: 700;
        font-size: 17px;
        color: #40444d;
    }
    .filter_title {
        font-size: 15px;
        color: #40444d;
        font-weight: 500;
    }
    .filter_option {
        border-radius: 3px;
        padding: 5px 3px;
    }
    .icon_color {
        color: #40444d;        
    }
    .apply_btn {
        font-weight: 400;
        font-size: 12px;
        color: #00ad52;
    }
    .chosen {
        color: #00ad52 !important;
    }
    .category_name {
        color: #7d8493;
        font-size: 11px;
    }
  
    .title {
        color: #4C5362;
        font-weight: 500;
        font-size: 13px;
        text-transform: uppercase;
    }
    .distance {
        padding: 6px 0px;
        width:100%;
        background-color: #f2f2f2;
        color:  #4C5362;
        border-radius: 3px;
    }
    .distance_chosen {
        color: white;
        font-weight: 500;
        background-color: #00ad52;
    }
    .set_default_btn {
        padding: 10px 0px;
        width:100%;
        background-color: #e8e8e8;
        color:  #464646;
        font-weight: 500;
        border-radius: 3px;
    }
    .card {
        box-shadow: none;
    }
</style>