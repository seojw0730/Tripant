//ajax error 부분
function ajaxErrorHandler (){
	Swal.fire({
		text: "알 수 없는 오류가 발생했습니다. 관리자에게 문의해주시기 바랍니다.",
		icon: "error", 
		confirmButtonColor: "#000000", 
		confirmButtonText: "확인"
	});
}