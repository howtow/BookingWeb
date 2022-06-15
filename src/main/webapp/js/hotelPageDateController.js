var day = new Date();
		var year = day.getFullYear();
		var month = (day.getMonth()+1) < 10 ? '0'+(day.getMonth()+1) : (day.getMonth()+1)
		var date = (day.getDate()) < 10 ? '0'+(day.getDate()) : (day.getDate())
		var set = year + '-' + month + '-' + date
		//最小日期(今天之前)
		$('#logindate').attr('min',set);
		$('#logoutdate').attr('min',set);

		//設訂入住為min
		$('#logindate').change(function(){
			let setmin = this.value;
			$('#logoutdate').attr('min',setmin);
		})

		//設訂退房為max
		$('#logoutdate').change(function(){
			let setmax = this.value;
			$('#logindate').attr('max',setmax);
		})