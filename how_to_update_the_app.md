1. Updates (see YearlyChanges.plist): cycle days, changes to schedule, change KEY_RET

2. Increment Version and Build in The Daily Charger (the one at the top of the project directory) > General.
Also, set Team to Albuquerque Academy. If there's an error under Team, let Xcode fix the issue.
I had to fiddle with it a little bit before the error disappeared.

3. Make sure Code Signing Identity > Release is set to iOS Distribution in The Daily Charger > Build Settings.

4. Set the build target to Generic iOS Device. In the top menu, select Product > Archive.

5. When the archive is done, select Upload to App Store... in the popup window (Archives).
Continue through the menu and upload the archive.
If you get a screen complaining about not having the private keys for a certificate, you can create a new certificate for iOS Distribution.

6. Sign into iTunes Connect (itunesconnect.apple.com) as aascheduleapp@gmail.com. Go to My Apps, then Daily Charger.

7. Click +Version or Platform, and everything should be obvious from there.

(8. If you're running really close to the deadline, you can request an expedited review, which we've had luck with before)

9. In Xcode, go to Source Control > Commit. Check the "Push to remote" box and commit the updates.
