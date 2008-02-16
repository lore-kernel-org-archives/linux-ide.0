From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 3615] Kernels 2.6.9 and 2.6.10-rc1 hang for 30 seconds during boot
Date: Sat, 16 Feb 2008 11:16:12 -0800 (PST)
Message-ID: <20080216191613.01F9310806A@picon.linux-foundation.org>
References: <bug-3615-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:49024 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756218AbYBPTQm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 14:16:42 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1GJGDYJ009158
	for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 11:16:14 -0800
In-Reply-To: <bug-3615-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=3615


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|bzolnier@gmail.com          |io_ide@kernel-bugs.osdl.org




------- Comment #15 from bzolnier@gmail.com  2008-02-16 11:16 -------
Could you try 2.6.24 or 2.6.25-rc2 with "hdc=noprobe" parameter?

[ yeah, not a full solution but may serve as a working workaround ]


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
