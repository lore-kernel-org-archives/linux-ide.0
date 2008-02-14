From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9962] 2.6.26-git0: IDE oops during boot
Date: Wed, 13 Feb 2008 16:09:48 -0800 (PST)
Message-ID: <20080214000948.6AD00108068@picon.linux-foundation.org>
References: <bug-9962-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:59574 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758645AbYBNAKW (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 19:10:22 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1E09maE014925
	for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 16:09:49 -0800
In-Reply-To: <bug-9962-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9962





------- Comment #4 from bzolnier@gmail.com  2008-02-13 16:09 -------
Also the bug summary is totally wrong now since IDE OOPS has been already
fixed,
the problem now is:

Creating root device.
Mounting root filesystem.
mount: could not  find filesystem
Kernel panic - not syncing: Attempted to kill init!

but hopefully we will know more soon.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
