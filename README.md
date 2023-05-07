# Refresher courses 85%

[![Typing SVG](https://readme-typing-svg.demolab.com?font=Alata&pause=1000&color=F7F7F7&background=80FFC400&width=435&lines=Insanity+is+doing+the+same+thing;over+and+over+again;expecting+different+results.;Albert+Einstein)](https://git.io/typing-svg)

*Refresher courses* program that works with [Firebase](https://firebase.google.com/) and Firebase real-time database (JSON model). Each new user registers on the site (maybe later I will add registration ﾍ(=￣∇￣)ﾉ ) in Firebase Authentication and, accordingly, in the Firebase Real-time database. Using a database, the user can be provided with a course containing lectures that he can watch without downloading to his phone. Video lectures are stored on Google Drive and stored in the model as links to them, and in the program they are already processed into the necessary link for working with AVPlayer.

### Stack

+ UIKit
+ AVKit - plays video-lectures
+ [Nuke](https://github.com/kean/Nuke) v12.1.0 - uploading photo
+ [Firebase](https://firebase.google.com/)
  + Firebase Real-time Database
  + Firebase Authentication 
+ MVC

### Preview
<p>
  <img src="https://user-images.githubusercontent.com/91137341/233851587-45e4bbbd-cef1-4015-8723-8197b9d3c59d.jpg" width="200">
  <img src="https://user-images.githubusercontent.com/91137341/233852059-297c25d4-a033-497d-81ef-d82f23200cfe.jpg" width="200">
  <img src="https://user-images.githubusercontent.com/91137341/233852246-344714e9-aaff-4cce-9c5b-6b11207efb2e.jpg" width="200">
</p>
 
Handling lecture link:
```Swift
let lectureURL = lecture.link
//lectureURL: https://drive.google.com/file/d/1tUk6dSavwL4-emKRVBFEsznTO916W1hU/view?usp=share_link
let pattern = "/d/([a-zA-Z0-9-_]+)"
guard let regex = try? NSRegularExpression(pattern: pattern),
    let match = regex.firstMatch(in: lectureURL, range: NSRange(location: 0, length: lectureURL.utf16.count)),
    let range = Range(match.range(at: 1), in: lectureURL) else {
    // failed to extract id from url
    return
}
//fileID: 1tUk6dSavwL4-emKRVBFEsznTO916W1hU
let fileID = String(lectureURL[range])

let videoURL = URL(string: "https://drive.google.com/uc?export=download&id=\(fileID)")
```

### Available

+ auth users
+ adding (registration) of user occurs through site firebase
+ adding new courses and lectures to course occurs through site
+ sorting courses by their end date (переписать)
+ update courses in real time (when course is added to user)
+ Dark/Light theme



