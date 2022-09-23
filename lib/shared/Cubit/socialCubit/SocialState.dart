abstract class SocialStates {}
class SocialInitialState extends SocialStates {}

// ----------------------------------------------------------//
///START : GetUserData 1
class GetUserDataLoadingState extends SocialStates {}
class GetUserDataSuccessState extends SocialStates {}
class GetUserDataErrorState extends SocialStates {
  final String error ;
  GetUserDataErrorState (this.error);
}
///END : GetUserData

// ----------------------------------------------------------//
///START : GetAllUsers 2
class GetAllUsersLoadingState extends SocialStates {}
class GetAllUsersSuccessState extends SocialStates {}
class GetAllUsersErrorState extends SocialStates {
  final String error ;
  GetAllUsersErrorState (this.error);
}
///END : GetAllUsers

// ----------------------------------------------------------//
///START : ChangeTabBar 3
class SocialChangeTabBarState extends SocialStates {}
///END : ChangeTabBar

// ---------------------------------------------------------//
///START : ChangeMenuItem 4
class ChangeMenuItemState extends SocialStates {}
class ChangeMenuScreenState extends SocialStates {}
///END : ChangeMenuItem

// ----------------------------------------------------------//
///START : ChangeTheme 5
class ChangeThemeState extends SocialStates {}
///END : ChangeTheme

// ----------------------------------------------------------//
///START : GetProfileImage 6
class GetProfileImagePickedSuccessState extends SocialStates {}
class GetProfileImagePickedErrorState extends SocialStates {}
///END : GetProfileImage

// ----------------------------------------------------------//
///START : GetCoverImage 7
class GetCoverImagePickedSuccessState extends SocialStates {}
class GetCoverImagePickedErrorState extends SocialStates {}
///END : GetCoverImage

// ----------------------------------------------------------//
///START : UploadProfileImage 8
class UploadProfileImageSuccessState extends SocialStates {}
class UploadProfileImageErrorState extends SocialStates {}

///END : UploadProfileImage

// ----------------------------------------------------------//
///START : UploadCoverImage 9
class UploadCoverImageSuccessState extends SocialStates {}
class UploadCoverImageErrorState extends SocialStates {}
///END : UploadCoverImage

// ----------------------------------------------------------//
///START : UpdateUserData 10
class UpdateUserLoadingState extends SocialStates {}
class UpdateUserErrorState extends SocialStates {}
///END : UpdateUserData

// ----------------------------------------------------------//
///START : CreatePost 11
class CreatePostLoadingState extends SocialStates {}
class CreatePostSuccessState extends SocialStates {}
class CreatePostErrorState extends SocialStates {}
///END : CreatePost

// ----------------------------------------------------------//
///START : UploadPost 12
class UploadPostLoadingState extends SocialStates {}
class UploadPostSuccessState extends SocialStates {}
class UploadPostErrorState extends SocialStates {}
///END : UploadPost

// ----------------------------------------------------------//
///START : GetPostImage 13
class GetPostImagePickedSuccessState extends SocialStates {}
class GetPostImagePickedErrorState extends SocialStates {}
///END : GetPostImage

// ----------------------------------------------------------//
///START : RemovePostImage 14
class RemovePostImageSuccessState extends SocialStates {}
///END : RemovePostImage

// ----------------------------------------------------------//
///START : GetPosts 15
class GetPostsLoadingState extends SocialStates {}
class GetPostsSuccessState extends SocialStates {}
class GetPostsErrorState extends SocialStates {
  final String error ;
  GetPostsErrorState (this.error);
}

class GetSinglePostSuccessState extends SocialStates {}
///END : GetPosts

// ----------------------------------------------------------//
///START : GetUserPosts 16
class GetUserPostsSuccessState extends SocialStates {}
///END : GetUserPosts

// ----------------------------------------------------------//
///START : Likes 17
class LikesLoadingState extends SocialStates {}
class LikesSuccessState extends SocialStates {}
class LikesErrorState extends SocialStates {
  final String error ;
  LikesErrorState (this.error);
}

class DisLikesSuccessState extends SocialStates {}
class DisLikesErrorState extends SocialStates {
  final String error ;
  DisLikesErrorState (this.error);
}

class GetLikedUsersSuccessState extends  SocialStates {}
///END : Likes

// ----------------------------------------------------------//
///START : Comments 18
class SendCommentSuccessState extends  SocialStates {}
class SendCommentErrorState extends  SocialStates {}
class GetCommentsSuccessState extends  SocialStates {}
class RemoveCommentImageSuccessState extends  SocialStates {}
///END : Comments

// ----------------------------------------------------------//
///START : SavedToGallery 19
class SavedToGalleryLoadingState extends SocialStates{}
class SavedToGallerySuccessState extends SocialStates{}
class SavedToGalleryErrorState extends SocialStates{}
///END : SavedToGallery
//------------------------------------------------------------//
///START : EditPost 20
class EditPostLoadingState extends SocialStates {}
class EditPostSuccessState extends SocialStates {}
class EditPostErrorState extends SocialStates {}

class DeletePostSuccessState extends SocialStates {}
///END : EditPost

//------------------------------------------------------------//
///START : ChangeUserPassword 21
class ChangeUserPasswordLoadingState extends SocialStates {}
class ChangeUserPasswordSuccessState extends SocialStates {}
class ChangeUserPasswordErrorState extends SocialStates {
  final String error ;
  ChangeUserPasswordErrorState(this.error);
}

class ShowPasswordState extends SocialStates {}
///END : ChangeUserPassword

//------------------------------------------------------------//
///START : Message 21
class SendMessageSuccessState extends SocialStates {}
class SendMessageErrorState extends SocialStates {}

class GetMessageSuccessState extends SocialStates {}
class GetMessageErrorState extends SocialStates {}

class MessageImagePickedSuccessState extends SocialStates {}
class MessageImagePickedErrorState extends SocialStates {}

class UploadMessageImageLoadingState extends SocialStates {}
class UploadMessageImageSuccessState extends SocialStates {}
class UploadMessageImageErrorState extends SocialStates {}

class GetMessageImageSuccessState extends SocialStates {}
class GetMessageImageErrorState extends SocialStates {}

class DeleteMessageImageSuccessState extends SocialStates {}
///END : Message

//------------------------------------------------------------//
///START : Friends 22
class GetFriendProfileLoadingState extends SocialStates {}
class GetFriendProfileSuccessState extends SocialStates {}

class AddFriendLoadingState extends SocialStates {}
class AddFriendSuccessState extends SocialStates {}
class AddFriendErrorState extends SocialStates {}


class GetFriendLoadingState extends SocialStates {}
class GetFriendSuccessState extends SocialStates {}
class GetFriendErrorState extends SocialStates {}

class CheckFriendSuccessState extends SocialStates {}

class UnFriendLoadingState extends SocialStates {}
class UnFriendSuccessState extends SocialStates {}
class UnFriendErrorState extends SocialStates {}

class FriendRequestLoadingState extends SocialStates {}
class FriendRequestSuccessState extends SocialStates {}
class FriendRequestErrorState extends SocialStates {}
class CheckFriendRequestSuccessState extends SocialStates {}

class DeleteFriendRequestLoadingState extends SocialStates {}
class DeleteFriendRequestSuccessState extends SocialStates {}
class DeleteFriendRequestErrorState extends SocialStates {}
///END : Friends

// --------------------------------------------------//
///START : Story 23
class GetStoryLoadingState extends SocialStates {}
class GetStorySuccessState extends SocialStates {}

class CreateStoryImagePickedSuccessState extends SocialStates {}
class CreateStoryImagePickedErrorState extends SocialStates {}

class CreateStoryLoadingState extends SocialStates {}
class CreateStorySuccessState extends SocialStates {}
class CreateStoryErrorState extends SocialStates {}

class RemoveStoryImagePickedSuccessState extends SocialStates {}

class CloseCreateStoryScreenState extends SocialStates {}

class AddTextSuccessState extends SocialStates {}
///END : Story

// ---------------------------------------------------//
///START : Search 24
class SearchLoadingState extends SocialStates {}
class SearchSuccessState extends SocialStates {}
class SearchErrorState extends SocialStates {
  final String error ;
  SearchErrorState(this.error);
}
///END : Search

// -------------------------------------------------//
///START : Notification 25
class SendInAppNotificationLoadingState extends SocialStates {}

class GetInAppNotificationLoadingState extends SocialStates {}
class GetInAppNotificationSuccessState extends SocialStates {}

class ReadNotificationSuccessState extends SocialStates {}

class SetNotificationIdSuccessState extends SocialStates {}
class GetNotificationsErrorState extends SocialStates {
  final String error ;
  GetNotificationsErrorState(this.error);
}
///END : Notification

//----------------------------------------------------------//
///START : Token 25
class SetUSerTokenLoadingState extends SocialStates {}
class SetUSerTokenSuccessState extends SocialStates {}
///END : Token

//----------------------------------------------------//