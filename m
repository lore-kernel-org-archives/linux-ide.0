From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10185] Commit 9f10d9ee breaks CD mounting/burning
Date: Sun,  9 Mar 2008 16:52:22 -0700 (PDT)
Message-ID: <20080309235222.CCDEB10806A@picon.linux-foundation.org>
References: <bug-10185-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37532 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752636AbYCIXw5 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Mar 2008 19:52:57 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m29NqwSB001869
	for <linux-ide@vger.kernel.org>; Sun, 9 Mar 2008 16:52:59 -0700
In-Reply-To: <bug-10185-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10185


rjw@sisk.pl changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |CLOSED
         Resolution|                            |CODE_FIX




------- Comment #1 from rjw@sisk.pl  2008-03-09 16:52 -------
Fixed by:
http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=b348487f0dc06f09a4c0d9e353eaa66e70230c7d


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
