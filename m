From: bugme-daemon@bugzilla.kernel.org
Subject: [Bug 12217] New: reading a cdrom hangs the system
Date: Sat, 13 Dec 2008 14:59:04 -0800 (PST)
Message-ID: <bug-12217-11633@http.bugzilla.kernel.org/>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:44543 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751837AbYLMW7g (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 13 Dec 2008 17:59:36 -0500
Received: from picon.linux-foundation.org (picon.linux-foundation.org [140.211.169.79])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBDMx4QS032645
	for <linux-ide@vger.kernel.org>; Sat, 13 Dec 2008 14:59:05 -0800
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

http://bugzilla.kernel.org/show_bug.cgi?id=12217

           Summary: reading a cdrom hangs the system
           Product: IO/Storage
           Version: 2.5
     KernelVersion: > 2.6.22
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: IDE
        AssignedTo: io_ide@kernel-bugs.osdl.org
        ReportedBy: michel.schmid-ms@orange.fr


Latest working kernel version: 2.6.22
Earliest failing kernel version: 2.6.24
Distribution:ubuntu
Hardware Environment:acer aspire 1310. wifi netgear 
Software Environment:ubuntu 8.10
Problem Description:
Since the upgrade to Ubuntu Hardy, with kernel 2.6.24, attempting to read a
cdrom results in a system hang after ~ 20 MB read (mouse and keyboard frozen).
However, burning a CD, or listening to an audio cd works well.
If I boot with the kernel 2.6.22, No problems of this kind but strange restarts
of the X session.

Hardware: laptop Acer Aspire 1310. RAM 512MB. HD IDE 30 GB. Netgear WiFi
network card.
tanks & best regards
Michel.


Steps to reproduce: Insert a CD and copy the content to a directory


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are the assignee for the bug, or are watching the assignee.
