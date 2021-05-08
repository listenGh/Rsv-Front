<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>阅览室篇</el-breadcrumb-item>
            <el-breadcrumb-item>阅览室信息</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
            <el-row>
                <el-col :span="4">
                    <el-button type="primary" @click="dialogFormVisible = true">增加具体阅览室</el-button>
                </el-col>
            </el-row>
            <el-table :data="positions" border stripe>
                <el-table-column type="index"></el-table-column>
                <el-table-column label="名称" prop="name"></el-table-column>
                <el-table-column label="类型" prop="type"></el-table-column>
                <el-table-column label="行数" prop="row"></el-table-column>
                <el-table-column label="列数" prop="col"></el-table-column>
                <el-table-column label="总数" prop="sum"></el-table-column>
            </el-table>
        </el-card>

        <el-dialog title="新阅览室信息" :visible.sync="dialogFormVisible">
            <el-form :model="readRoomInfo">
                <el-form-item label="名称" :label-width="formLabelWidth">
                    <el-input v-model="readRoomInfo.name" autocomplete="off" ></el-input>
                </el-form-item>
                <el-form-item label="阅览室类型选择" :label-width="formLabelWidth">
                    <el-select v-model="readRoomInfo.type" placeholder="请选择阅览室类型" >
                        <el-option v-for="item in types" :label="item.type" :value="item.type"></el-option>
                    </el-select>
                </el-form-item>
                <el-form-item label="行数" :label-width="formLabelWidth">
                    <el-input v-model="readRoomInfo.row" autocomplete="off" ></el-input>
                </el-form-item>
                <el-form-item label="列数" :label-width="formLabelWidth">
                    <el-input v-model="readRoomInfo.col" autocomplete="off" ></el-input>
                </el-form-item>
                <el-form-item label="总数" :label-width="formLabelWidth">
                    <el-input v-model="readRoomInfo.sum" autocomplete="off" ></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click="dialogFormVisible = false">取 消</el-button>
                <el-button type="primary" @click="addReadRoomInfo()">确 定</el-button>
            </div>
        </el-dialog>

    </div>
</template>

<script>
    export default {
        name: "Info",
        created() {
            this.initt();
        },
        data() {
            return {
                types:[],
                dialogFormVisible:false,
                formLabelWidth:'120px',
                positions:[],
                readRoomInfo:{
                    name:'',
                    type:'',
                    row:'',
                    col:'',
                    sum:'',
                }
            }
        },
        methods: {
            async initt(){
                const {data: res} = await this.$http.post("getAllReadRoomInfo");
                this.positions = res.listOfReadRoomInfo;
                this.types = res.types;
            },
            async addReadRoomInfo(){//别忘了增加 positionInfo
                const {data: res} = await this.$http.get("addReadRoomInfo", {params:this.readRoomInfo});
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