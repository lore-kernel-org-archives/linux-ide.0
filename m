From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 7506] it821x: long wait time due to dma_timer_expiry
Date: Sat, 16 Feb 2008 10:45:31 -0800 (PST)
Message-ID: <20080216184531.1496C11D10A@picon.linux-foundation.org>
References: <bug-7506-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:42402 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751301AbYBPSqf (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 16 Feb 2008 13:46:35 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1GIk17q007985
	for <linux-ide@vger.kernel.org>; Sat, 16 Feb 2008 10:46:02 -0800
In-Reply-To: <bug-7506-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=7506


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|bzolnier@gmail.com          |io_ide@kernel-bugs.osdl.org
      KernelVersion|2.6.19-rc3                  |2.6.19-rc3 - 2.6.23-rc2




------- Comment #12 from bzolnier@gmail.com  2008-02-16 10:45 -------
Martin, could you try 2.6.25-rc2?


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
