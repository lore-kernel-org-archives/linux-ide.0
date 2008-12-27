From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Sat, 27 Dec 2008 11:17:32 -0800 (PST)
Message-ID: <20081227191732.84517108048@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48017 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753707AbYL0TRe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 27 Dec 2008 14:17:34 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBRJHWmq005166
	for <linux-ide@vger.kernel.org>; Sat, 27 Dec 2008 11:17:33 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144


hancockr@shaw.ca changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |hancockr@shaw.ca




------- Comment #31 from hancockr@shaw.ca  2008-12-27 11:17 -------
Wait a minute. It's quite likely that the drive in fact cannot play audio in
the way you're trying to make it. Modern systems don't normally play audio in
this way anymore, this requires an analog audio output from the drive into the
sound hardware which is unlikely on a laptop. In Windows Media Player, etc.
when you insert an audio CD it's actually digitally extracting the audio from
the disc and playing it, which does not involve the "play audio" command. I'm
sure there is some media player software in Linux which will do the same.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
