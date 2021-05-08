<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>信用积分</el-breadcrumb-item>
            <el-breadcrumb-item>积分明细</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
            <el-table :data="positions" border stripe>
                <el-table-column type="index"></el-table-column>
                <el-table-column label="用户名" prop="username"></el-table-column>
                <el-table-column label="班级" prop="classes"></el-table-column>
                <el-table-column label="积分">
                    <template slot-scope="scope">
                        <el-button type="text"  @click="searchKFInfo(scope.row.username)">{{scope.row.credit}}</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>

        <el-dialog title="扣分详情" :visible.sync="dialogFormVisible">
            <el-table :data="gridData">
                <el-table-column property="bJBusername" label="用户名" ></el-table-column>
                <el-table-column property="dates" label="时间"></el-table-column>
                <el-table-column property="kf" label="扣分"></el-table-column>
                <el-table-column property="content" label="违章内容"></el-table-column>
            </el-table>
        </el-dialog>

    </div>
</template>

<script>
    export default {
        name: "JiFenMingxi",
        created() {
            this.username = window.sessionStorage.getItem("username");
            this.initt();
        },
        data() {
            return {
                gridData:[],
                dialogFormVisible:false,
                bJBusername:'',
                formLabelWidth:'120px',
                username:'',
                positions:[],
            }
        },
        methods: {
            async initt(){
                const {data: res} = await this.$http.post("getAllStudents");
                this.positions = res.listOfStudents;
            },
            async searchKFInfo(username){
                this.dialogFormVisible = true;
                const {data: res} = await this.$http.post("getSomeoneDeductions",{username:username});
                this.gridData = res.listOfDeduction;
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