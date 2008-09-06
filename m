From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 11511] New: HPT374 detection crash with 74811f355f4f69a187fa74892dcf2a684b84ce99
Date: Sat,  6 Sep 2008 14:42:22 -0700 (PDT)
Message-ID: <bug-11511-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43793 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752269AbYIFVmz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 6 Sep 2008 17:42:55 -0400
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m86LgMO6024982
	for <linux-ide@vger.kernel.org>; Sat, 6 Sep 2008 14:42:23 -0700
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=11511

           Summary: HPT374 detection crash with
                    74811f355f4f69a187fa74892dcf2a684b84ce99
           Product: IO/Storage
           Version: 2.5
     KernelVersion: 2.6.27-rc1
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


Subject    : HPT374 detection crash with
74811f355f4f69a187fa74892dcf2a684b84ce99
Submitter  : "Masoud Sharbiani" <masouds@masoud.ir>
Date       : 2008-09-04 23:11
References : http://marc.info/?l=linux-kernel&m=122056994113818&w=4
Handled-By : Masoud Sharbiani <masouds@google.com>
Patch      : http://marc.info/?l=linux-kernel&m=122072163527041&w=4

This entry is being used for tracking a regression from 2.6.26.  Please don't
close it until the problem is fixed in the mainline.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
