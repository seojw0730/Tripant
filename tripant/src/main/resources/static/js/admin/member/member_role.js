$(loadedHandler);

function loadedHandler() {
	$(".btn").on("click", ClickHandler);
	$(".btn-ac").on("click", ClickBtnHandler);
}

function ClickHandler() {
	console.log("++");
	Swal.fire({
         title: " <p style='font-size:17px'>" + "등급변경" + "</p>",
         confirmButtonText:"수정완료",
         confirmButtonColor:"black",
         width:"280px",
         confirmButtonTextFont:"Binggrae",
         html: `
             <select name="selectRole" id="selectRole" style='font-family:Binggrae; font-size:13px; height:25px'>
                 <option value="1">휴면회원</option>
                 <option value="2">일반회원</option>
                 <option value="3">폰튼적용회원</option>
                 <option value="4">관리자</option>
             </select>
         `,
         focusConfirm: false,
         preConfirm: () => {  //확인 버튼 누르면 실행되는 콜백함수
             const selectRole = document.getElementById('selectRole').value;
             const memEmail=$(this).parent().prev().prev().prev().prev().prev().text(); //button에서 부모요소인 li로 올라가서 prev() 달기
             $.ajax({
            	 url:"/admin/member/role",
            	 method:"post",
            	 data: {selectRole:selectRole, memEmail:memEmail},
				 //success: 1이면 업데이트 완료 0이면 실패
				 success : function(result) {
							console.log(result);
							if (result == 1 ) {
								alert("성공");
								location.reload();
							} else {
								alert("실패");
							}
				 },
				 error : function(request, status, error) {
							alert("code: " + request.status + "\n"
									+ "message: " + request.responseText + "\n"
									+ "error: " + error);
						}
             });
             return { selectRole: selectRole };
         }
     }).then((result) => {  
         if (result.isConfirmed) { //모달창에서 confirm 버튼을 눌렀다면
             console.log('Selected Role:', result.value.selectRole);
         }
     });
	 
}
function ClickBtnHandler(){
	Swal.fire({
         title: " <p style='font-size:17px'>" + "활성화 여부" + "</p>",
         confirmButtonText:"수정완료",
         confirmButtonColor:"black",
         width:"280px",
         confirmButtonTextFont:"Binggrae",
         html: `
             <select name="selectRole" id="selectActive" style='font-family:Binggrae; font-size:13px; height:25px'>
                 <option value="0">비활성화</option>
                 <option value="1">활성화</option>
             </select>
         `,
         focusConfirm: false,
         preConfirm: () => {  //확인 버튼 누르면 실행되는 콜백함수
             const selectActive = document.getElementById('selectActive').value;
             const memEmail=$(this).parent().prev().prev().prev().prev().text(); //button에서 부모요소인 li로 올라가서 prev() 달기
             $.ajax({
            	 url:"/admin/member/active",
            	 method:"post",
            	 data: {selectActive:selectActive, memEmail:memEmail},
				 //success: 1이면 업데이트 완료 0이면 실패
				 success : function(result) {
							console.log(result);
							if (result == 1 ) {
								alert("성공");
								location.reload();
							} else {
								alert("실패");
							}
				 },
				 error : function(request, status, error) {
							alert("code: " + request.status + "\n"
									+ "message: " + request.responseText + "\n"
									+ "error: " + error);
						}
             });
             return { selectActive: selectActive };
         }
     }).then((result) => {  
         if (result.isConfirmed) { //모달창에서 confirm 버튼을 눌렀다면
             console.log('selectActive:', result.value.selectActive);
         }
     });
	 
}
