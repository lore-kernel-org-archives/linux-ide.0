From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11697] New: CD tray closes spontaneously after opening it
Date: Sat,  4 Oct 2008 11:19:23 -0700 (PDT)
Message-ID: <bug-11697-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59315 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752409AbYJDSTx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Oct 2008 14:19:53 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m94IJNPO004673
	for <linux-ide@vger.kernel.org>; Sat, 4 Oct 2008 11:19:24 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11697

           Summary: CD tray closes spontaneously after opening it
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.27-rc
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: rjw@sisk.pl
OtherBugsDependingO 11167
             nThis:
        Regression: 1


Subject    : CD tray closes spontaneously after opening it
Submitter  : Frans Pop <elendil@planet.nl>
Date       : 2008-09-30 10:47
References : http://marc.info/?l=linux-kernel&m=122277167125264&w=4
Handled-By : "Kay Sievers" <kay.sievers@vrfy.org>

This entry is being used for tracking a regression from 2.6.26.  Please don't
close it until the problem is fixed in the mainline.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
