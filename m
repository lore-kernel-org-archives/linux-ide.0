From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 10715] New: 2.6.25 -> 2.6.26-rc1: pcmcia flash card changed name from hda to hdc
Date: Thu, 15 May 2008 15:56:29 -0700 (PDT)
Message-ID: <bug-10715-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40654 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752050AbYEOW4b (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 15 May 2008 18:56:31 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4FMuTos028195
	for <linux-ide@vger.kernel.org>; Thu, 15 May 2008 15:56:30 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=10715

           Summary: 2.6.25 -> 2.6.26-rc1: pcmcia flash card changed name
                    from hda to hdc
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.26-rc1
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


Subject    : 2.6.25 -> 2.6.26-rc1: pcmcia flash card changed name from hda to
hdc
Submitter  : Pavel Machek <pavel@suse.cz>
Date       : 2008-05-15 13:23
References : http://marc.info/?l=linux-kernel&m=121085784809468&w=4

This entry is being used for tracking a regression from 2.6.25.  Please don't
close it until the problem is fixed in the mainline.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
