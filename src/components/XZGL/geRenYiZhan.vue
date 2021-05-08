<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>选座管理</el-breadcrumb-item>
            <el-breadcrumb-item>个人已占</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
            <el-table :data="positions" border stripe>
                <el-table-column type="index"></el-table-column>
                <el-table-column label="用户名" prop="username"></el-table-column>
                <el-table-column label="阅览室" prop="readRoom"></el-table-column>
                <el-table-column label="桌号" prop="num"></el-table-column>
                <el-table-column label="开始时间" prop="startTime"></el-table-column>
                <el-table-column label="结束时间" prop="endTime"></el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button size="mini" type="danger" @click="cancel(scope.row.id)">取消预约</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>
    </div>
</template>

<script>
    export default {
        name: "geRenYiZhan",
        created() {
            this.username = window.sessionStorage.getItem("username");
            this.initt();
        },
        data() {
            return {
                username:'',
                positions:[],
            }
        },
        methods: {
            async initt(){
                const {data: res} = await this.$http.post("yZJLGR",{username:this.username});
                this.positions = res.listOfZH;
            },
            //取消预约
            async cancel(id){
                const {data: res} = await this.$http.post("cancel", {id:id});
                if (res == "success") {
                    this.$message.success("操作成功！");
                } else {
                    this.$message.error("操作失败！");
                }
                this.initt();
            },

        }
    }
</script>

<style lang="less" scoped>

    .el-breadcrumb {
        margin-bottom: 16px;
        font-size: 12px;
    }
</style>