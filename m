From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10749] IDE sis5513: the system doesn't shutdown
Date: Sun, 25 May 2008 16:50:36 -0700 (PDT)
Message-ID: <20080525235036.B6D69108038@picon.linux-foundation.org>
References: <bug-10749-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59644 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751081AbYEYXvK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 May 2008 19:51:10 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4PNoakt022761
	for <linux-ide@vger.kernel.org>; Sun, 25 May 2008 16:50:38 -0700
In-Reply-To: <bug-10749-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10749


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |bzolnier@gmail.com
             Status|NEW                         |ASSIGNED




------- Comment #6 from bzolnier@gmail.com  2008-05-25 16:50 -------
I already did, see:

http://lkml.org/lkml/2008/5/25/149

ACPI errors in the dmesg seem to confirm that this is not an sis5513 problem,

I'm reverting it back to ACPI for now.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
