import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from "../components/Login";
import Home from "../components/Home";
import Welcome from "../components/Welcome";
import UserList from "../components/admin/UserList";
import kongYu from "../components/XZGL/kongYu";
import yiZhan from "../components/XZGL/yiZhan";
import geRenYiZhan from "../components/XZGL/geRenYiZhan";
import JuBaoQingKuang from "../components/XYHF/JuBaoQingKuang";
import JiFenMingXi from "../components/XYHF/JiFenMingXi";
import Type from "../components/YueLanShi/Type";
import Info from "../components/YueLanShi/Info";
import Students from "../components/ShiShengXinXi/Students";
import Teachers from "../components/ShiShengXinXi/Teachers";
import NoticeInfo from "../components/TongZhiGongGao/NoticeInfo";
import InfoCommunication from "../components/JiaoLiuGuanLi/InfoCommunication";
import TypeF from "../components/YueLanShi/TypeF";
import InfoF from "../components/YueLanShi/InfoF";
import personalInfoManaOfStudent from "../components/GeRenXinXi/personalInfoManaOfStudent";
import personalInfoManaOfTeacher from "../components/GeRenXinXi/personalInfoManaOfTeacher";

Vue.use(VueRouter)

const routes = [
  {
    path:"/",
    redirect:"/login"
  },
  {
    path:"/login",
    component:Login
  },
  {
    path:"/homeOfAdmin",
    component:Home,
    redirect:"/welcomeOfAdmin",
    children:[
        {path:"/welcomeOfAdmin",component:Welcome},
        // {path:"/user",component:UserList},
        {path:"/kongYu",component:kongYu},
        {path:"/yiZhan",component:yiZhan},
        {path:"/geRenYiZhan",component:geRenYiZhan},
        {path:"/jB",component:JuBaoQingKuang},
        {path:"/details",component:JiFenMingXi},
        {path:"/type",component:Type},
        {path:"/formation",component:Info},
        {path:"/student",component:Students},
        {path:"/teacher",component:Teachers},
        {path:"/noticeInfo",component:NoticeInfo},
        {path:"/infoCommunication",component:InfoCommunication},
    ]
  },

    {
        path:"/homeOfStudent",
        component:Home,
        redirect:"/welcomeOfStudent",
        children:[
            {path:"/welcomeOfStudent",component:Welcome},
            {path:"/user",component:UserList},
            {path:"/kongYu",component:kongYu},
            {path:"/yiZhan",component:yiZhan},
            {path:"/geRenYiZhan",component:geRenYiZhan},
            {path:"/jB",component:JuBaoQingKuang},
            {path:"/details",component:JiFenMingXi},
            {path:"/typeF",component:TypeF},
            {path:"/formationF",component:InfoF},
            {path:"/student",component:Students},
            {path:"/teacher",component:Teachers},
            {path:"/noticeInfo",component:NoticeInfo},
            {path:"/infoCommunication",component:InfoCommunication},
            {path:"/personalInfoManaOfTeacher",component:personalInfoManaOfTeacher},
        ]
    },

    {
        path:"/homeOfTeacher",
        component:Home,
        redirect:"/welcomeOfTeacher",
        children:[
            {path:"/welcomeOfTeacher",component:Welcome},
            {path:"/user",component:UserList},
            {path:"/kongYu",component:kongYu},
            {path:"/yiZhan",component:yiZhan},
            {path:"/geRenYiZhan",component:geRenYiZhan},
            {path:"/jB",component:JuBaoQingKuang},
            {path:"/details",component:JiFenMingXi},
            {path:"/typeF",component:TypeF},
            {path:"/formationF",component:InfoF},
            {path:"/student",component:Students},
            {path:"/teacher",component:Teachers},
            {path:"/noticeInfo",component:NoticeInfo},
            {path:"/infoCommunication",component:InfoCommunication},
            {path:"/personalInfoManaOfStudent",component:personalInfoManaOfStudent},
        ]
    },
]

const router = new VueRouter({
  routes,
  mode:"history"
})

//确认安全退出后，不留下个人信息
router.beforeEach((to,from,next)=>{
    if(to.path=='/login') return next();
    const userFlag = window.sessionStorage.getItem("user");
    if(!userFlag){
        return next('/login');
    }
    next();
})
export default router
