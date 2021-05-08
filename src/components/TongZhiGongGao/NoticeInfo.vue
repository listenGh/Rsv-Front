<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>通知公告</el-breadcrumb-item>
            <el-breadcrumb-item>通知信息</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
            <el-row>
                <el-col :span="4">
                    <el-button type="primary" @click="dialogVisible = true">增加通知信息</el-button>
                </el-col>
            </el-row>
            <el-table :data="positions" border stripe>
                <el-table-column type="index"></el-table-column>
                <el-table-column label="主题">
                    <template slot-scope="scope">
                        <el-button type="text"  @click="searchInfo(scope.row.id)">{{scope.row.title}}</el-button>
                    </template>
                </el-table-column>
                <el-table-column label="日期" prop="dates"></el-table-column>
            </el-table>
        </el-card>

        <el-dialog title="具体内容" :visible.sync="dialogFormVisible">
            <span>{{content}}</span>
        </el-dialog>

        <el-dialog title="增加通知信息" :visible.sync="dialogVisible">
            <el-form >
                <el-form-item label="主题" :label-width="formLabelWidth">
                    <el-input v-model="addTitle" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="内容" :label-width="formLabelWidth">
                    <el-input v-model="addContent" autocomplete="off"></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click=" dialogVisible= false">取 消</el-button>
                <el-button type="primary" @click="addNoticeInfo()">确 定</el-button>
            </div>
        </el-dialog>

    </div>
</template>

<script>
    export default {
        name: "NoticeInfo",
        created() {
            this.username = window.sessionStorage.getItem("username");
            this.initt();
        },
        data() {
            return {
                dialogVisible:false,
                dialogFormVisible:false,
                formLabelWidth:'120px',
                positions:[],
                content:'',
                addContent:'',
                addTitle:'',
            }
        },
        methods: {
            async initt(){
                const {data: res} = await this.$http.post("getAllNotiInfo");
                this.positions = res.listOfnotiInfo;
            },
            async searchInfo(id){
                this.dialogFormVisible = true;
                const {data: res} = await this.$http.post("getSomeoneNotiInfo",{id:id});
                this.content = res.NotiInfo.content;
            },
            async addNoticeInfo(){
                const {data: res} = await this.$http.post("addNoticeInfo",{title:this.addTitle,content:this.addContent});
                if (res == "success") {
                    this.$message.success("操作成功！");
                } else {
                    this.$message.error("操作失败！");
                }
                this.dialogVisible=false;
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