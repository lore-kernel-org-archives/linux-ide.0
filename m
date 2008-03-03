From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10159] New: 2.6.25-rc2 IDE + smartd = hang
Date: Mon,  3 Mar 2008 03:09:39 -0800 (PST)
Message-ID: <bug-10159-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36307 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751441AbYCCLKK (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 3 Mar 2008 06:10:10 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m23B9kgT021416
	for <linux-ide@vger.kernel.org>; Mon, 3 Mar 2008 03:09:48 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10159

           Summary: 2.6.25-rc2 IDE + smartd = hang
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.25-rc2 and -rc3
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: aeriksson@fastmail.fm


git says: 852738f39258deafb3d89c187cb1a4050820d555 is the first bad commit

Starting smartd v5.37 with classic IDE drivers hangs the system. 

For details see the thread at 
http://lkml.org/lkml/2008/2/23/359


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
