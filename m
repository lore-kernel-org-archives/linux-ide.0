From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11420] New: attempting to read scuffed CDs causes libata to switch the drive to PIO0 mode and there's no way switch back
Date: Sun, 24 Aug 2008 20:03:38 -0700 (PDT)
Message-ID: <bug-11420-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34734 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753130AbYHYDEL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 24 Aug 2008 23:04:11 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7P33c9c030532
	for <linux-ide@vger.kernel.org>; Sun, 24 Aug 2008 20:03:39 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11420

           Summary: attempting to read scuffed CDs causes libata to switch
                    the drive to PIO0 mode and there's no way switch back
           Product: IO/Storage
           Version: 2.5
     KernelVersion: kernel-2.6.25.14-108.fc9.x86_64
          Platform: All
        OS/Version: Linux
              Tree: Fedora
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: nmiell@comcast.net


Attempting to rip a scuffed CD results in lots of errors in the log as libata
steps down from UDMA66 to PIO0 (for no reason, afaik, these are media errors,
not link errors). Once the libata has erroneously decided on a tediously slow
communication method, there's no way to tell it to go back to UDMA66.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
