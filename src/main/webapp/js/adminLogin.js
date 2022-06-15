const container = document.querySelector(".container");
const pwShowHide = document.querySelectorAll(".showHideIcon");
const pwFields = document.querySelectorAll(".password");
const signUp = document.querySelector(".signup-text");
const login = document.querySelector(".login-link");

// js 顯示和隱藏密碼和改變icon
// 建立事件聆聽功能 click
// 如果click後則type 會從 password 改為 text
pwShowHide.forEach(eyeIcon => {
    eyeIcon.addEventListener("click", () => {
        pwFields.forEach(pwFields => {
            if (pwFields.type === "password") {
                pwFields.type = "text";

                pwShowHide.forEach(icon => {
                    icon.classList.replace("uil-eye-slash", "uil-eye") //替換icon效果
                })
            } else {
                pwFields.type = "password";
                pwShowHide.forEach(icon => {
                    icon.classList.replace("uil-eye","uil-eye-slash") //反之，替換icon效果
                })
            }
        })
    })
})


// js code 顯示signup 、 login form
signUp.addEventListener("click", () => {
    container.classList.add("active");
});
login.addEventListener("click", () => {
    container.classList.remove("active");
});


