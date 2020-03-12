<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
    
<style>
.uploadResult {
  width:100%;
  background-color: gray;
}
.uploadResult ul{
  display:flex;
  flex-flow: row;
  justify-content: center;
  align-items: center;
}
.uploadResult ul li {
  list-style: none;
  padding: 10px;
  align-content: center;
  text-align: center;
}
.uploadResult ul li img{
  width: 100px;
}
.uploadResult ul li span {
  color:white;
}
.bigPictureWrapper {
  position: absolute;
  display: none;
  justify-content: center;
  align-items: center;
  top:0%;
  width:100%;
  height:100%;
  background-color: gray; 
  z-index: 100;
  background:rgba(255,255,255,0.5);
}
.bigPicture {
  position: relative;
  display:flex;
  justify-content: center;
  align-items: center;
}

.bigPicture img {
  width:600px;
}

</style>

    
<%@include file="../includes/header.jsp" %>

 			<div class="row">
	                <div class="col-lg-12">
	                    <h1 class="page-header">Board Register</h1>
	                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                           Board Read Page
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                        	<form role="form" action="/board/modify" method="post">
                        		<input type='hidden' name="${_csrf.parameterName }" value="${_csrf.token }"/>
                        		<input type='hidden' name='pageNum' value='<c:out value="${cri.pageNum }"/>'>
                        		<input type='hidden' name='amount' value='<c:out value="${cri.amount }"/>'>
                        		<input type='hidden' name='type' value='<c:out value="${cri.type }"/>'>
                        		<input type='hidden' name='keyword' value='<c:out value="${cri.keyword }"/>'>
                        		<div class="form-group">
                            		<label>Bno</label><input class="form-control" name='bno' value='<c:out value="${board.bno}"/>' readonly="readonly">
                            	</div>
                        
                            	<div class="form-group">
                            		<label>Title</label><input class="form-control" name='title' value='<c:out value="${board.title}"/>' >
                            	</div>
                            	
                            	<div class="form-group">
                            		<label>Text area</label><textarea class="form-control" rows="3" name='content' ><c:out value="${board.content }"/></textarea>
                            	</div>
                            	
                            	<div class="form-group">
                            		<label>Writer</label><input class="form-control" name='writer' value='<c:out value="${board.writer}"/>' readonly="readonly">
                            	</div>
                            	
                            	<div class="form-group">
                            		<label>RegDate</label><input class="form-control" name='regdate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate }" />' readonly="readonly">
                            	</div>
                            	
                            	<div class="form-group">
                            		<label>Update Date</label><input class="form-control" name='updateDate' value='<fmt:formatDate pattern="yyyy/MM/dd" value="${board.regdate }" />' readonly="readonly">
                            	</div>
                            	<sec:authentication property="principal" var="pinfo"/>
								<sec:authorize access="isAuthenticated()">
									<c:if test="${pinfo.username eq board.writer }">
                            	<button data-oper='modify' type="submit" class="btn btn-default">Modify</button>
                            	<button data-oper="remove" type="submit" class="btn btn-info">Remove</button>
									</c:if>
								</sec:authorize>
                            	<button data-oper="list" type="submit" class="btn btn-info">List</button>
                            </form>
                            <!-- /.form -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            
            <div class="row">
			  <div class="col-lg-12">
			    <div class="panel panel-default">
			
			      <div class="panel-heading">Files</div>
			      <!-- /.panel-heading -->
			      <div class="panel-body">
					<div class="form-group uploadDiv">
						<input type="file" name='uploadFile' mulitple="multiple">
					</div>
						        
			        <div class='uploadResult'> 
			          <ul>
			          </ul>
			        </div>
			      </div>
			      <!--  end panel-body -->
			    </div>
			    <!--  end panel-body -->
			  </div>
			  <!-- end panel -->
			</div>
			<!-- /.row -->
            
            
        <%@include file="../includes/footer.jsp" %>
        
        <script type="text/javascript">
        $(document).ready(function(){
        	
        	/* button data-oper 이용한 동작처리 */
        	var formObj = $("form");
        	$('button').on("click", function(e){
        		e.preventDefault(); //submit 버튼 비활성화 
        		var operation = $(this).data("oper");
        		console.log(operation);
        		if(operation === 'remove'){
        			formObj.attr("action", "/board/remove");
        		}else if(operation === 'list'){
        			/* self.location="/board/list"; */
        			/* return; */
        			formObj.attr("action", "/board/list").attr("method", "get");
        			var pageNumTag = $("input[name='pageNum']").clone();
        			var amountTag = $("input[name='amount']").clone();
        			var typeTag = $("input[name='type']").clone();
        			var keywordTag = $("input[name='keyword']").clone();
        			
        			formObj.empty();
        			formObj.append(pageNumTag);
        			formObj.append(amountTag);
        			formObj.append(typeTag);
        			formObj.append(keywordTag);
        		}else if(operation === 'modify'){
        			console.log("submit clicked");
					var str = "";
					$(".uploadResult ul li").each(function(i, obj){
						var jobj = $(obj);
						console.dir(jobj);
						str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+jobj.data("filename")+"'>";
						str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+jobj.data("uuid")+"'>";
						str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+jobj.data("path")+"'>";
						str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ jobj.data("type")+"'>";
					});
					console.log(str);
					formObj.append(str).submit();
        		}
        		formObj.submit(); //submit 버튼 활성화(/board/modify)
        	});
        });
		</script>
		
		<script type="text/javascript">
			$(document).ready(function(){
				(function(){
					var bno = '<c:out value="${board.bno}"/>';
					$.getJSON("/board/getAttachList", {bno: bno}, function(arr){
						console.log(arr);
						var str = "";
						$(arr).each(function(i, attach){
							 if(attach.fileType){
								 var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
								 
								 str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
						         str += "<span> "+ attach.fileName+"</span>";
						         str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>";
						         str += "<i class='fa fa-times'></i></button><br>";
								 str += "<img src='/upload/display?fileName="+fileCallPath+"'>";
								 str += "</div></li>";
							 }else{
								 str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
								 str += "<span> "+ attach.fileName+"</span><br/>";
						         str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'>";
						         str += "<i class='fa fa-times'></i></button><br>";
								 str += "<img src='/resources/img/attach.png'></a>";
								 str += "</div></li>";
							 }
	 						});
					    $(".uploadResult ul").html(str);
					}); //getJSON
				})(); //function
				
				$(".uploadResult").on("click", "button", function(e){
				    
				    console.log("delete file");
				    if(confirm("Remove this file? ")){
				      var targetLi = $(this).closest("li");
				      targetLi.remove();
				    }
				});
				
				var regex = new RegExp("(.*?)\.(exe|sh|zup|alz|7z)$");
				var maxSize = 5242880; //5MB
				function checkExtension(fileName, fileSize){
					if(fileSize >= maxSize){
						alert("파일사이즈 초과");
						return false;
					}
					if(regex.test(fileName)){
						alert("해당종류의 파일은 업로드 불가");
						return false;
					}
					return true;
				}
				
				var csrfHeaderName="${_csrf.headerName}";
				var csrfTokenValue="${_csrf.token}";
				$("input[type='file']").change(function(e){
					var formData = new FormData();
					var inputFile = $("input[name='uploadFile']");
					var files = inputFile[0].files;
//			 		console.log(files);
					for(var i = 0; i < files.length; i++){
						if(!checkExtension(files[i].name, files[i].size) ){
					        return false;
					    }
						formData.append("uploadFile", files[i]);
					}
					
					$.ajax({
						url: '/upload/uploadAjaxAction',
						processData: false,
						contentType: false, 
						data: formData,
						beforeSend: function(xhr){
							xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
						},
						type: 'POST',
						dataType: 'json',
						success: function(result){
							console.log(result);
							showUploadResult(result);
						}
					}); // .ajax
				});
				
				    
				function showUploadResult(uploadResultArr){
					console.log("1");
					if(!uploadResultArr || uploadResultArr.length == 0){
						return;
					}
					var uploadUL = $(".uploadResult ul");
				    var str = "";
					console.log("2");
				    $(uploadResultArr).each(function(i, obj){
				        if(obj.image){
							console.log("3");
				        	var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
				         	str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
				         	str += "<span>"+obj.fileName+"</span>";
				          	str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='image' class='btn btn-warning btn-circle'>";
				          	str += "<i class='fa fa-times'></i></button><br>";
				          	str += "<img src='/upload/display?fileName="+fileCallPath+"'>";
				          	str += "</div></li>";
				        }else{
							console.log("4");
				        	var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);            
				        	var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/");
				          	str += "<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.image+"'><div>";
				          	str += "<span>"+obj.fileName+"</span>";
				          	str += "<button type='button' data-file=\'"+fileCallPath+"\' data-type='file' class='btn btn-warning btn-circle'>";
				          	str += "<i class='fa fa-times'></i></button><br>";
				          	str += "<img src='/resources/img/attach.png'>";
							str += "</div></li>";
				        }
				    });
				    uploadUL.append(str);
			    }
				
			});
			
		</script>
			
