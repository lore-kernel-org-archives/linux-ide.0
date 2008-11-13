From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11943] Boot fails at scsi0:MESH with hde: lost interrupt, AEC6260
Date: Thu, 13 Nov 2008 13:17:19 -0800 (PST)
Message-ID: <20081113211719.32644108041@picon.linux-foundation.org>
References: <bug-11943-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51803 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751268AbYKMVRr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 13 Nov 2008 16:17:47 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mADLHJLw013713
	for <linux-ide@vger.kernel.org>; Thu, 13 Nov 2008 13:17:20 -0800
In-Reply-To: <bug-11943-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11943


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |bzolnier@gmail.com
             Status|NEW                         |ASSIGNED




------- Comment #24 from bzolnier@gmail.com  2008-11-13 13:17 -------
Thanks for testing it anyway.  It really seems like a platform specific issue
so I'll re-assing this bug to Platform/PPC for now.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
