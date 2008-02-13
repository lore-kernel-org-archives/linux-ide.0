From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 9962] New: 2.6.26-git0: IDE oops during boot
Date: Wed, 13 Feb 2008 14:07:41 -0800 (PST)
Message-ID: <bug-9962-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50081 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934625AbYBMWHn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 13 Feb 2008 17:07:43 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [207.189.120.79])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1DM7fxj008346
	for <linux-ide@vger.kernel.org>; Wed, 13 Feb 2008 14:07:42 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=9962

           Summary: 2.6.26-git0: IDE oops during boot
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.25-git0
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


Subject         : 2.6.26-git0: IDE oops during boot
Submitter       : Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date            : 2008-02-12 14:34
References      : http://lkml.org/lkml/2008/2/12/91
Handled-By      : Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This entry is being used for tracking a regression from 2.6.24.  Please don't
close it until the problem is fixed in the mainline.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
