<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>阅览室篇</el-breadcrumb-item>
            <el-breadcrumb-item>阅览室类型</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
            <el-table :data="positions" border stripe>
                <el-table-column type="index"></el-table-column>
                <el-table-column label="类型" prop="type"></el-table-column>
                <el-table-column label="信用积分限制" prop="limit"></el-table-column>
            </el-table>
        </el-card>

        <el-dialog title="新阅览室类型" :visible.sync="dialogFormVisible">
            <el-form :model="ReadRoomClass">
                <el-form-item label="类型" :label-width="formLabelWidth">
                    <el-input v-model="ReadRoomClass.type" autocomplete="off" ></el-input>
                </el-form-item>
                <el-form-item label="信用积分限制" :label-width="formLabelWidth">
                    <el-input v-model="ReadRoomClass.limit" autocomplete="off" ></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="addReadClass()">确 定</el-button>
            </div>
        </el-dialog>

    </div>
</template>

<script>
    export default {
        name: "TypeF",
        created() {
            this.initt();
        },
        data() {
            return {
                dialogFormVisible:false,
                formLabelWidth:'120px',
                positions:[],
                ReadRoomClass:{
                    type:'',
                    limit:'',
                }
            }
        },
        methods: {
            async initt(){
                const {data: res} = await this.$http.post("getAllReadClass");
                this.positions = res.listOfReadClass;
            },
            async addReadClass(){
                const {data: res} = await this.$http.get("addReadRoomClass", {params:this.ReadRoomClass});
                if (res == "success") {
                    this.$message.success("操作成功！");
                } else {
                    this.$message.error("操作失败！");
                }
                this.dialogFormVisible = false;
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