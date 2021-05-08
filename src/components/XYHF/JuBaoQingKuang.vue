<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>信用积分</el-breadcrumb-item>
            <el-breadcrumb-item>举报情况</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
            <el-table :data="positions" border stripe>
                <el-table-column type="index"></el-table-column>
                <el-table-column label="举报人" prop="jBusername"></el-table-column>
                <el-table-column label="被举报人" prop="bJBusername"></el-table-column>
                <el-table-column label="时间" prop="dates"></el-table-column>
                <el-table-column label="举报内容" prop="content"></el-table-column>
                <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button size="mini" @click="isTrue(scope.row.id,scope.row.bJBusername)">True</el-button>
                        <el-button size="mini" type="danger" @click="isFalse(scope.row.jBusername)">False</el-button>
                    </template>
                </el-table-column>
            </el-table>
        </el-card>

        <el-dialog title="扣分" :visible.sync="dialogFormVisible">
            <el-form :model="kf">
                <el-form-item label="扣除分数" :label-width="formLabelWidth">
                    <el-input v-model="kf.num" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="KF()">确 定</el-button>
            </div>
        </el-dialog>

    </div>
</template>

<script>
    export default {
        name: "JuBaoQingKuang",
        created() {
            this.username = window.sessionStorage.getItem("username");
            this.initt();
        },
        data() {
            return {
                dialogFormVisible:false,
                kf:{
                    num:'',
                },
                bJBusername:'',
                id:'',
                formLabelWidth:'120px',
                username:'',
                positions:[],
            }
        },
        methods: {
            async initt(){
                const {data: res} = await this.$http.post("getAllDeduction");
                this.positions = res.listOfDeduction;
            },
            isTrue(id,bJBusername){
                this.dialogFormVisible = true;
                this.id = id;
                this.bJBusername = bJBusername;
            },
            async KF(){
                const {data: res} = await this.$http.post("isTrue", {bJb:this.bJBusername,id:this.id,kf:this.kf.num});
                if (res == "success") {
                    this.$message.success("操作成功！");
                } else {
                    this.$message.error("操作失败！");
                }
                this.dialogFormVisible = false;
                this.initt();

            },
            async isFalse(JBusername){
                const {data: res} = await this.$http.post("isFalse", {jb:this.username,bjb:JBusername});
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