
$(loadedHandler);
function loadedHandler() {
	//좋아요
	$(".btn.like").on("click", ClickLikeHandler);
	//조회수
	$(".btn.view").on("click", ClickViewHandler);
	//조건검색
	//$('.btn-search').on("click",searchHandler);
	
}

//좋아요수 정렬
function ClickLikeHandler(){
	$.ajax({
		url:"/admin/like",
		 method:"post",
		 success : function(like) {
			 $('#list').html(LikeHandler(like));
				},
	 error : function(request, status, error) {
				alert("code: " + request.status + "\n"
						+ "message: " + request.responseText + "\n"
						+ "error: " + error);
			}
	});
} 
function LikeHandler(like){
	var htmlVal = '';
	for (var idx in like){
		var memBoard = like[idx];
		htmlVal+=`
			<ul class="col list">
				<li>${memBoard.diaryId}</li>
				<li>${memBoard.diaryTitle}</li>
				<li>${memBoard.memNick}</li>
				<li>${memBoard.diaryDate}</li>
				<li>${memBoard.diaryViews}</li>
				<li>${memBoard.likes}</li>
				<li></li>
			</ul>
			`;
	}
	return htmlVal;
}

//조회수 정렬
function ClickViewHandler(){
	$.ajax({
		url:"/admin/view",
		 method:"post",
		 success : function(view) {
			 $('#list').html(ViewHandler(view));
				},
	 error : function(request, status, error) {
				alert("code: " + request.status + "\n"
						+ "message: " + request.responseText + "\n"
						+ "error: " + error);
			}
	});
} 
function ViewHandler(view){
	var htmlVal = '';
	for (var idx in view){
		var memBoard = view[idx];
		htmlVal+=`
			<ul class="col list">
				<li>${memBoard.diaryId}</li>
				<li>${memBoard.diaryTitle}</li>
				<li>${memBoard.memNick}</li>
				<li>${memBoard.diaryDate}</li>
				<li>${memBoard.diaryViews}</li>
				<li>${memBoard.likes}</li>
				<li></li>
			</ul>
			`;
	}
	return htmlVal;
}

var currentPage = 1;
var totalPageCount = null;
var startPageNum = null;
var endPageNum = null;

/* 페이징 이동 함수 */
function goPageHandler() {
			var currentpage = $(this).data("targetpage");
			$.ajax({
				url:"/admin/keyword"
				, method : "get"
				, data : {
						pick:pick, search:search ,
						currentpage : currentpage}
				, dataType : "json"
				, error : ajaxErrorHandler
				, success : function(result){
					if(result.search){
						$("[name=search]").val(result.search);
					}
					memListHandler(result);
				}
			});
	}

// 검색
function searchBtnHandler(thisElement){
	var pick=$("select[name=option] option:selected").val(); //선택한 option val값 
	var search = $("[name=search]").val();  //input 값
	var targetPage = $(thisElement).data('targetpage');
	$.ajax({
		url:"/admin/keyword",
		method:"post",
		data: {pick:pick, search:search , page: targetPage},
		success : function(searchList) {
				$('.wrap-list').replaceWith(searchList);
				},
	 error : function(request, status, error) {
				alert("code: " + request.status + "\n"
						+ "message: " + request.responseText + "\n"
						+ "error: " + error);
			}
		
	});
}

function memListHandler(searchList){
	var htmlVal = '';
	for (var idx in searchList){
		var memBoard = searchList[idx];
		htmlVal+=`
			<ul class="col list">
				<li>${memBoard.diaryId}</li>
				<li>${memBoard.diaryTitle}</li>
				<li>${memBoard.memNick}</li>
				<li>${memBoard.diaryDate}</li>
				<li>${memBoard.diaryViews}</li>
				<li>${memBoard.likes}</li>
				<li></li>
			</ul>
			`;
	}
	return htmlVal;
}