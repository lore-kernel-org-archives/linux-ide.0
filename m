From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10185] New: Commit 9f10d9ee breaks CD mounting/burning
Date: Thu,  6 Mar 2008 14:59:09 -0800 (PST)
Message-ID: <bug-10185-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36664 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752967AbYCFW7h (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 6 Mar 2008 17:59:37 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m26MxVWJ014399
	for <linux-ide@vger.kernel.org>; Thu, 6 Mar 2008 14:59:33 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10185

           Summary: Commit 9f10d9ee breaks CD mounting/burning
           Product: IO/Storage
           Version: 2.5
     KernelVersion: commit 9f10d9ee0ac6d79d7bc8b9a158bf4a29322d84d3
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


Submitter       : walt <w41ter@gmail.com>
Date            : 2008-03-06 1:16
References      : http://marc.info/?t=120476623500003&r=1&w=2
Handled-By      : Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Patch           : http://marc.info/?l=linux-kernel&m=120483868101033&w=2

This entry is being used for tracking a regression from 2.6.24.  Please don't
close it until the problem is fixed in the mainline.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
