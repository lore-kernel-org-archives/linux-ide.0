From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10086] New: 2.6.25-rc2 + smartd = hang
Date: Sat, 23 Feb 2008 14:41:02 -0800 (PST)
Message-ID: <bug-10086-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([207.189.120.13]:44473 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753232AbYBYHyQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 25 Feb 2008 02:54:16 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1P7sDhc004521
	for <linux-ide@vger.kernel.org>; Sun, 24 Feb 2008 23:54:14 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10086

           Summary: 2.6.25-rc2 + smartd = hang
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.25-rc2
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: rjw@sisk.pl
OtherBugsDependingO 9832
             nThis:
        Regression: 1


Subject         : 2.6.25-rc2 + smartd = hang
Submitter       : Anders Eriksson <aeriksson@fastmail.fm>
Date            : 2008-02-22 17:51
References      : http://lkml.org/lkml/2008/2/22/239

This entry is being used for tracking a regression from 2.6.24.  Please don't
close it until the problem is fixed in the mainline.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
