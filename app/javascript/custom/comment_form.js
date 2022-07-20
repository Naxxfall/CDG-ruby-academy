var commentNew=document.querySelector(".comment_new");
var commentEdit=document.querySelector(".comment_edit");
var commentControlEdit=document.querySelectorAll(".comment__control--edit");
var commentControlDelete=document.querySelectorAll(".comment__control--delete");
var commentEditText=document.querySelector(".comment_edit__text");
var commentId=document.querySelector(".comment_edit__id");

function showEditForm(newForm, editForm){
    newForm.classList.add("visually-hidden");
    editForm.classList.remove("visually-hidden");
}

commentControlEdit.forEach(function (showEdit) {
    showEdit.addEventListener("click", function (evt) {
        evt.preventDefault();
        var commentItem = this.closest(".comments__item");
        commentEditText.value = commentItem.querySelector(".comment__text").textContent;
        commentId.value = commentItem.querySelector(".comment__id").textContent;
        showEditForm(commentNew,commentEdit);
        commentEditText.focus();
    });

});

commentControlDelete.forEach(function (deleteComment) {
    deleteComment.addEventListener("click", function (evt) {
        evt.preventDefault();
        var commentItem = this.closest(".comments__item");
        var deleteCommentId = commentItem.querySelector(".delete-comment__id");
        deleteCommentId.value = commentItem.querySelector(".comment__id").textContent;
        var deleteCommentSubmit = commentItem.querySelector(".delete-comment-button");
        deleteCommentSubmit.click();
    });
});



