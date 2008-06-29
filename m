From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11006] New: 2.6.26-rc6: pcmcia stopped working
Date: Sun, 29 Jun 2008 11:13:32 -0700 (PDT)
Message-ID: <bug-11006-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45020 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754115AbYF2SNe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jun 2008 14:13:34 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5TIDWQC023314
	for <linux-ide@vger.kernel.org>; Sun, 29 Jun 2008 11:13:33 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11006

           Summary: 2.6.26-rc6: pcmcia stopped working
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.26-rc6
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: rjw@sisk.pl
OtherBugsDependingO 10492
             nThis:
        Regression: 1


Subject    : 2.6.26-rc6: pcmcia stopped working
Submitter  : Pavel Machek <pavel@suse.cz>
Date       : 2008-06-22 22:40
References : http://marc.info/?l=linux-kernel&m=121420740806363&w=4
References : http://marc.info/?t=121439185700001&r=1&w=4
Handled-By : Tejun Heo <htejun@gmail.com>

This entry is being used for tracking a regression from 2.6.25.  Please don't
close it until the problem is fixed in the mainline.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
