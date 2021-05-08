<template>
    <div>
        <el-breadcrumb separator-class="el-icon-arrow-right">
            <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
            <el-breadcrumb-item>交流管理</el-breadcrumb-item>
            <el-breadcrumb-item>信息交流</el-breadcrumb-item>
        </el-breadcrumb>
        <el-card>
            <el-row>
                <el-col :span="4">
                    <el-button type="primary" @click="dialogVisible = true">增加交流帖</el-button>
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
                <el-table-column label="发表者" prop="sendUsername"></el-table-column>
            </el-table>
        </el-card>


        <el-dialog title="具体交流内容" :visible.sync="dialogFormVisible">
            <el-table :data="gridData">
                <el-table-column property="replyUsername" label="回复者" ></el-table-column>
                <el-table-column property="dates" label="时间"></el-table-column>
                <el-table-column property="content" label="回复内容"></el-table-column>
            </el-table>

            <div slot="footer" class="dialog-footer">
                <el-input placeholder="请输入要发表的内容"  v-model="addContent" autocomplete="off"></el-input>
                <el-button type="primary" @click="addReply()">发 表</el-button>
            </div>
        </el-dialog>




        <el-dialog title="增加交流帖" :visible.sync="dialogVisible">
            <el-form >
                <el-form-item label="主题" :label-width="formLabelWidth">
                    <el-input v-model="addTitle" autocomplete="off"></el-input>
                </el-form-item>
                <el-form-item label="发表人" :label-width="formLabelWidth">
                    <el-input v-model="addUsername" autocomplete="off" disabled></el-input>
                </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
                <el-button @click=" dialogVisible= false">取 消</el-button>
                <el-button type="primary" @click="addInfoCommunication()">确 定</el-button>
            </div>
        </el-dialog>

    </div>
</template>

<script>
    export default {
        name: "InfoCommunication",
        created() {
            this.addUsername = window.sessionStorage.getItem("username");
            this.initt();
        },
        data() {
            return {
                gridData:[],
                addUsername:'',
                dialogVisible:false,
                dialogFormVisible:false,
                formLabelWidth:'120px',
                positions:[],
                content:'',
                addContent:'',
                addTitle:'',
                id:'',
            }
        },
        methods: {
            async initt(){
                const {data: res} = await this.$http.post("getAllInfoCommunication");
                this.positions = res.listOfInfoCommunication;
            },
            async searchInfo(id){
                this.id = id;
                console.log(this.id);
                this.dialogFormVisible = true;
                const {data: res} = await this.$http.post("getSomeoneReply",{mid:this.id});
                this.gridData = res.InfoCommunications;
            },
            async addInfoCommunication(){
                const {data: res} = await this.$http.post("addInfoCommunication",{title:this.addTitle,sendUsername:this.addUsername});
                if (res == "success") {
                    this.$message.success("操作成功！");
                } else {
                    this.$message.error("操作失败！");
                }
                this.dialogVisible=false;
                this.initt();
            },
            async addReply(){
                const {data: res} = await this.$http.post("addReply",{mid:this.id,content:this.addContent,replyUsername:this.addUsername});
                if (res == "success") {
                    this.$message.success("操作成功！");
                } else {
                    this.$message.error("操作失败！");
                }
                const {data: re} = await this.$http.post("getSomeoneReply",{mid:this.id});
                this.gridData = re.InfoCommunications;
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