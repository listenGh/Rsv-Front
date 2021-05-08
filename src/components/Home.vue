<template>
    <el-container class="home-container">
        <el-header>
            <div class="a">
                <img src="../assets/logo.jpg" alt/>
                <span class="b">图书馆订座平台</span>
            </div>
            <el-button type="info" @click="logout()">安全退出</el-button>
        </el-header>
        <el-container>
            <el-aside width="200px">
                <el-menu background-color="#545c64" text-color="#fff" active-text-color="#409eff"
                         unique-opened :router="true" :default-active="activePath">

<!--                    item.id+'' 数字变为字符串-->
                    <el-submenu :index="item.id+''" v-for="item in menuList" :key="item.id">

                        <template slot="title">
                            <i class="el-icon-location"></i>
                            <span>{{item.title}}</span>
                        </template>

                        <el-menu-item :index="it.path" v-for="it in item.subMenuList" :key="it.id"
                        @click="saveNavState(it.path)">
                            <template slot="title">
                                <span>{{it.title}}</span>
                            </template>
                        </el-menu-item>

                    </el-submenu>

                </el-menu>

            </el-aside>

            <el-main>
                <router-view></router-view>
            </el-main>
        </el-container>
    </el-container>
</template>

<script>
    export default {
        name: "Home",
        data() {
            return {
                menuList: [],
                activePath:'/welcome',
                role:'',
            }
        },
        created() {
            this.getMenuList();
            this.activePath = window.sessionStorage.getItem('activePath');
        },
        methods: {
            logout() {
                window.sessionStorage.clear();
                this.$router.push("/login");
            },
            async getMenuList() {

                this.role = window.sessionStorage.getItem("role");
                if(this.role =="Admin"){
                    const {data: res} = await this.$http.get("menus");
                    if (res.flag == 404) return this.$message.error("获取列表失败！");
                    this.menuList = res.menu;
                }else if(this.role =="Student"){
                    const {data: res} = await this.$http.get("menusOfStudent");
                    if (res.flag == 404) return this.$message.error("获取列表失败！");
                    this.menuList = res.menu;
                }else{
                    const {data: res} = await this.$http.get("menusOfTeacher");
                    if (res.flag == 404) return this.$message.error("获取列表失败！");
                    this.menuList = res.menu;
                }

            },
            //保存路径
            saveNavState(activePath){
                window.sessionStorage.setItem('activePath',activePath);
                this.activePath = activePath;
            },
        },
    }
</script>

<style scoped>
    .el-header {
        background-color: #373d41;
        display: flex;
        justify-content: space-between;
        padding-left: 0%;
        color: #fff;
        align-items: center;
        font-size: 20px;
    }

    .a {
        display: flex;
        align-items: center;
    }

    .b {
        margin-left: 15px;
    }

    .el-aside {
        background-color: #333744;
        .el-menu{
            border-right: none;
        }
    }

    .el-main {
        background-color: #eaedf1;
    }

    .home-container {
        height: 100%;
    }

    img {
        width: 100px;
        height: 65px;
    }

</style>