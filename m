From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 8006] a likely logging error in "cdrom/sbpcd.c"
Date: Fri, 15 Feb 2008 04:41:53 -0800 (PST)
Message-ID: <20080215124153.05841108068@picon.linux-foundation.org>
References: <bug-8006-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:48201 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753100AbYBOMm0 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 15 Feb 2008 07:42:26 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1FCfrwV020433
	for <linux-ide@vger.kernel.org>; Fri, 15 Feb 2008 04:41:54 -0800
In-Reply-To: <bug-8006-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=8006


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|linux-ide@vger.kernel.org   |bzolnier@gmail.com
             Status|NEW                         |ASSIGNED




------- Comment #5 from bzolnier@gmail.com  2008-02-15 04:41 -------
cdrom/sbpcd.c was removed in 2.6.23 (BTW it was not an IDE driver).

I'm closing the bug.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
