From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10574] Hard disk makes bad noise at poweroff when shutting down.
Date: Tue, 29 Apr 2008 07:28:18 -0700 (PDT)
Message-ID: <20080429142818.93A2E10805F@picon.linux-foundation.org>
References: <bug-10574-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35242 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751016AbYD2O2U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 29 Apr 2008 10:28:20 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m3TESIke010126
	for <linux-ide@vger.kernel.org>; Tue, 29 Apr 2008 07:28:19 -0700
In-Reply-To: <bug-10574-11633@http.bugzilla.kernel.org/>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10574


bzolnier@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         AssignedTo|io_ide@kernel-bugs.osdl.org |bzolnier@gmail.com
             Status|NEW                         |ASSIGNED




------- Comment #3 from bzolnier@gmail.com  2008-04-29 07:28 -------
You're using libata driver not IDE one.  I'm re-assigning the bug.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
You are the assignee for the bug, or are watching the assignee.
