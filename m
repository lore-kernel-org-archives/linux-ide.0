From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12144] optiarc bc-5500A can't read audio cds
Date: Sun, 14 Dec 2008 15:27:04 -0800 (PST)
Message-ID: <20081214232704.4DC12108041@picon.linux-foundation.org>
References: <bug-12144-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:49571 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751524AbYLNX1d (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 14 Dec 2008 18:27:33 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBENR4sF022367
	for <linux-ide@vger.kernel.org>; Sun, 14 Dec 2008 15:27:05 -0800
In-Reply-To: <bug-12144-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12144





------- Comment #10 from manoet.ita@gmail.com  2008-12-14 15:27 -------
Sorry, maybe I misunderstood you.
I'm not able to play any audio cd in kernel 2.6.27.7 too. The output of "cdplay
/dev/hda" is "cdplay: ioctl cdromplaymsf: Operation not
supported".
The module of scsi-cdrom is loaded.
What do you suggest?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
