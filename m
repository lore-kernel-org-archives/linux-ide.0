From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11732] Oops while mounting a DVD-ROM
Date: Fri, 10 Oct 2008 12:17:55 -0700 (PDT)
Message-ID: <20081010191755.EE1D6108058@picon.linux-foundation.org>
References: <bug-11732-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57879 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763550AbYJJTSO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 10 Oct 2008 15:18:14 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m9AJHtbL029300
	for <linux-ide@vger.kernel.org>; Fri, 10 Oct 2008 12:17:57 -0700
In-Reply-To: <bug-11732-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11732


akpm@osdl.org changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |akpm@osdl.org
         AssignedTo|io_other@kernel-            |io_ide@kernel-bugs.osdl.org
                   |bugs.osdl.org               |
          Component|Other                       |IDE
         Regression|0                           |1




------- Comment #1 from akpm@osdl.org  2008-10-10 12:17 -------
I recategorised this to IDE.

I assume it is a regression also.  It might be that we just
added more debug stuff and the problme has been there for some time.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
