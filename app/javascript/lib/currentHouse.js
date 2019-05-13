document.addEventListener("turbolinks:load", () => {
	let currentHouseSelect = document.getElementById("current-house-select");
	currentHouseSelect.addEventListener("change", ()=>{
		let currentHouseForm = document.getElementById("current-house-form")
		currentHouseForm.submit();
	});
});