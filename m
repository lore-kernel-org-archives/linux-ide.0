From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11420] attempting to read scuffed CDs causes libata to switch the drive to PIO0 mode and there's no way switch back
Date: Mon, 25 Aug 2008 01:51:45 -0700 (PDT)
Message-ID: <20080825085145.44EDC108058@picon.linux-foundation.org>
References: <bug-11420-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44673 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752281AbYHYIwO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Aug 2008 04:52:14 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7P8pjSM018216
	for <linux-ide@vger.kernel.org>; Mon, 25 Aug 2008 01:51:46 -0700
In-Reply-To: <bug-11420-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11420


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |bzolnier@gmail.com
             Status|NEW                         |ASSIGNED




------- Comment #2 from bzolnier@gmail.com  2008-08-25 01:51 -------
Re-assigning to libata component.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
